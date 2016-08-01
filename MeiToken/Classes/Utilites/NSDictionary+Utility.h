//
//  NSMutableDictionary+Utility.h
//
//  Created by Kent  on 14-5-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Utility)

/**
 *  如果该Object存在,就添加到字典里; 如果不存在则忽略.
 *
 *  @param object 要添加到字典里的Object, 可以为nil.
 *  @param key    相对应的Key.
 */
-(void)setObjectIfExisted:(id)object forKey:(id<NSCopying>)key;
@end

@interface NSDictionary (Utility)


-(int64_t)longLongValueForKey:(id)key;
-(int32_t)intValueForKey:(id)key;
-(int16_t)shortValueForKey:(id)key;
-(int8_t)charValueForKey:(id)key;
-(BOOL)boolValueForKey:(id)key;
-(double)doubleValueForKey:(id)key;
-(float)floatValueForKey:(id)key;
-(NSString *)stringForKey:(id)key;
-(NSArray *)arrayForKey:(id)key;


-(NSString *)jsonString;

@end

@interface NSDictionary (Difference)

-(NSDictionary *)diffrenceFromDictionary:(NSDictionary *)dictionary;
@end



@interface NSMutableDictionary (Append)

//object不能是NSArray及其子类 如果返回YES,则表示追加成功，NO则表示之前没有对应key的object，并把object添加到对应的key
-(BOOL)appendObject:(id)object forKey:(id)key;

@end

