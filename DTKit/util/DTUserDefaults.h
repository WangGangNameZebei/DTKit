//
//  DTUserDefaults.h
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author DT, 14-11-28 10:11:52
 *
 *  @brief NSUserDefaults封装类
 */
@interface DTUserDefaults : NSObject

/**
 *  @Author DT, 14-11-28 10:11:11
 *
 *  @brief 获取NSUserDefaults中String类型数据
 *
 *  @param key
 *
 *  @return NSString,默认值是nil
 */
+(NSString*)getStringForKey:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:19
 *
 *  @brief 获取NSUserDefaults中Integer类型数据
 *
 *  @param key
 *
 *  @return NSInteger,默认值是0
 */
+(NSInteger)getIntegerForkey:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:19
 *
 *  @brief 获取NSUserDefaults中Dictionary类型数据
 *
 *  @param key
 *
 *  @return NSDictionary,默认值是nil
 */
+(NSDictionary*)getDictionaryForKey:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:19
 *
 *  @brief 获取NSUserDefaults中Array类型数据
 *
 *  @param key
 *
 *  @return NSArray,默认值是nil
 */
+(NSArray*)getArrayForKey:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:19
 *
 *  @brief 获取NSUserDefaults中BOOL类型数据
 *
 *  @param key
 *
 *  @return BOOL,默认值是NO
 */
+(BOOL)getBoolForKey:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:16
 *
 *  @brief 往NSUserDefaults里面插入String类型数据
 *
 *  @param value
 *  @param key
 */
+(void)setString:(NSString*)value key:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:16
 *
 *  @brief 往NSUserDefaults里面插入Integer类型数据
 *
 *  @param value
 *  @param key
 */
+(void)setInteger:(NSInteger)value key:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:16
 *
 *  @brief 往NSUserDefaults里面插入Dictionary类型数据
 *
 *  @param value
 *  @param key
 */
+(void)setDictionary:(NSDictionary*)value key:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:16
 *
 *  @brief 往NSUserDefaults里面插入Array类型数据
 *
 *  @param value
 *  @param key
 */
+(void)setArray:(NSArray*)value key:(NSString*)key;

/**
 *  @Author DT, 14-11-28 10:11:16
 *
 *  @brief 往NSUserDefaults里面插入Bool类型数据
 *
 *  @param value
 *  @param key
 */
+(void)setBool:(BOOL)value key:(NSString*)key;

@end
