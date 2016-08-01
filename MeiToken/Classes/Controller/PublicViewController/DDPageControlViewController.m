//
//  DDPageControlViewController.m
//  DDPageControl
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//


#import <KMateLibs/basesHeader.h>

@implementation DDPageControlViewController


-(instancetype)initWith{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"KMateApi" withExtension:@"bundle"]];
    self = [super initWithNibName:@"DDPageControlViewController" bundle:bundle];
    if (self) {
        return self;
    }
    return nil;
}

- (void)viewDidLoad
{
	[super viewDidLoad] ;
    self.navigationController.navigationBar.hidden = YES;

    
	int numberOfPages = 4 ;
	
	// define the scroll view content size and enable paging
    _scrollView.frame = CGRectMake(0, 0, WinSize.width, WinHeight);
	[_scrollView setContentSize: CGSizeMake(_scrollView.frame.size.width * numberOfPages, _scrollView.frame.size.height-WinTitleHeight)] ;
	
	// programmatically add the page control
	pageControl = [[DDPageControl alloc] init] ;
	[pageControl setCenter: CGPointMake(_scrollView.center.x, _scrollView.bounds.size.height-15.0f)] ;
    
	[pageControl setNumberOfPages: numberOfPages] ;
	[pageControl setCurrentPage: 0] ;
	[pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
	[pageControl setDefersCurrentPageDisplay: YES] ;
	[pageControl setType: DDPageControlTypeOnFullOffEmpty] ;
		[pageControl setOnColor:[KidMateApi setGuidePageIncolor]] ;
	 [pageControl setOffColor: [KidMateApi setGuidePageOutcolor]] ;
	[pageControl setIndicatorDiameter: 15.0f] ;
	[pageControl setIndicatorSpace: 15.0f] ;
	[self.view addSubview: pageControl] ;
	
	CGRect pageFrame ;
	for (int i = 1 ; i <= numberOfPages ; i++)
	{
		// determine the frame of the current page
		pageFrame = CGRectMake((i-1) * _scrollView.frame.size.width, 0.0f, _scrollView.frame.size.width, _scrollView.contentSize.height);
		
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:pageFrame];
        imageView.image = [[SystemSupport share] imageOfFile:[NSString stringWithFormat:@"guid_%d",i]];
		
		// add it to the scroll view
		[_scrollView addSubview: imageView];
        
        if (i == numberOfPages)
        {
            UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
            loginButton.frame = CGRectMake(pageFrame.origin.x+80, _scrollView.bounds.size.height-120, 152, 40);
            [loginButton setTitle:MLString(@"欢迎回家") forState:UIControlStateNormal];
            [loginButton setTitleColor:[KidMateApi setGuidePageBtnTextcolor] forState:UIControlStateNormal];
            loginButton.backgroundColor = [UIColor clearColor];
            
            CALayer *piclayer =  [loginButton layer];
            //是否设置边框以及是否可见
            [piclayer setMasksToBounds:YES];
            //设置边框圆角的弧度
            [piclayer setCornerRadius:20];
            [piclayer setBorderWidth:1.0];
            [piclayer setBorderColor:[[KidMateApi setGuidePageBtncolor] CGColor]];
            
            [loginButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];

           
            [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:loginButton];
        }
	}
}

- (void) loginAction:(UIButton*)sender
{
    UserDefault_Set_GuideDidView();
	Login_VC* loginVC = [[Login_VC alloc] initWithNibName:@"Login_VC" bundle:KMateApiBundle];
//    [self.navigationController pushViewController:loginVC animated:YES];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:loginVC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"DDPageControlView"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"DDPageControlView"];
}

#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
	DDPageControl *thePageControl = (DDPageControl *)sender ;
	
	// we need to scroll to the new index
	[_scrollView setContentOffset: CGPointMake(_scrollView.frame.size.width * thePageControl.currentPage, _scrollView.contentOffset.y) animated: YES] ;
}


#pragma mark -
#pragma mark UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
	CGFloat pageWidth = _scrollView.frame.size.width ;
    float fractionalPage = _scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (_scrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait) ;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning] ;
}

@end
