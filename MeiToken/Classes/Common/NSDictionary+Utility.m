//
//  NSMutableDictionary+Utility.m
//
//  Created by Kent  on 14-5-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSMutableDictionary (Utility)

-(void)setObjectIfExisted:(id)object forKey:(id<NSCopying>)key{
    if(object){
        [self setObject:object forKey:key];
    }
}

@end

@implementation NSDictionary (Utility)

-(int64_t)longLongValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj longLongValue];
    }
    return 0;
}
-(int32_t)intValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj intValue];
    }
    return 0;
}

-(int16_t)shortValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj shortValue];
    }else if ([obj isKindOfClass:[NSString class]]){
        return (int16_t)[(NSString *)obj intValue];
    }
    return 0;
}
-(int8_t)charValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ( [obj isKindOfClass:[NSNumber class]])
    {
        return [obj charValue];
    }else if ([obj isKindOfClass:[NSString class]]){
        return (int8_t)[(NSString *)obj intValue];
    }
    return 0;
}
-(BOOL)boolValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj boolValue];
    }
    return 0;
}

-(double)doubleValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj doubleValue];
    }
    return 0;
}

-(float)floatValueForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
    {
        return [obj floatValue];
    }
    return 0;
}

-(NSString *)stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    return nil;
}

-(NSArray *)arrayForKey:(id)key;
{
	id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        if ([(NSArray *) obj containsObject:[NSNull null]]) {
            return nil;
        }
        return obj;
    }
    return nil;
}

-(NSString *)jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    if (! jsonData)
        return nil;
    else
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}


@end

@implementation NSDictionary (Difference)

-(NSDictionary *)diffrenceFromDictionary:(NSDictionary *)dictionary{
    
    NSMutableDictionary * modifyInfoDictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    NSDictionary * originalInfoDictionary = dictionary;
    NSMutableArray * keysToRemove = [NSMutableArray new];
    for (NSString * key in modifyInfoDictionary.keyEnumerator) {
        
        id modifyObject = [modifyInfoDictionary objectForKey:key];
        id originObject = [originalInfoDictionary objectForKey:key];
        if (([modifyObject isKindOfClass:[NSNumber class]] && [(NSNumber *)modifyObject isEqualToNumber:(NSNumber *)originObject])
            ||(([modifyObject isKindOfClass:[NSString class]]) && [(NSString *)modifyObject isEqualToString:(NSString *)originObject])
            ||([modifyObject isKindOfClass:[NSArray class]] && [(NSArray *)modifyObject isEqualToArray:(NSArray *)originObject])
            ||([modifyObject isKindOfClass:[NSDictionary class]] && [(NSDictionary *)modifyObject isEqualToDictionary:(NSDictionary *)originObject])) {
            
            [keysToRemove addObject:key];
        }
    }
    
    [modifyInfoDictionary removeObjectsForKeys:keysToRemove];
    return modifyInfoDictionary;
}

@end

@implementation NSMutableDictionary (Append)

-(BOOL)appendObject:(id)object forKey:(id)key
{
    id obj = [self objectForKey:key];
    if(obj)
    {
        if([obj isKindOfClass:[NSMutableArray class]])
        {
            NSMutableArray *blockArray = (NSMutableArray *)obj;
            [blockArray addObject:object];
        }
        else
        {
            NSMutableArray *blockArray = [NSMutableArray array];
            [blockArray addObject:obj];
            [blockArray addObject:object];
            [self setObject:blockArray forKey:key];
        }
        
        return YES;
    }
    else
    {
        [self setObject:object forKey:key];
        
        return NO;
    }

}

@end
