//
//  NSString+util.h
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (util)

//判断是否是中文，但不支持中英文混编
-(BOOL)isChinese;

- (NSString *)pinyin;
//大写
- (NSString *)firstLetter;

//是否只包含十进制数字
- (BOOL)isOnlyNumber;

@end
