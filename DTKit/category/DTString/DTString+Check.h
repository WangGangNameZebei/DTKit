//
//  DTString+Check.h
//  DTKitDemo
//
//  Created by DT on 14-11-30.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString扩展类,主要实现校验功能
 */
@interface NSString (Check)

/**
 *  邮箱验证
 *
 *  @return 是邮箱格式返回YES,反之返回NO
 */
- (BOOL)isValidEmail;

/**
 *  手机号码验证
 *
 *  @return 是手机号码返回YES,反之返回NO
 */
- (BOOL)isValidPhoneNum;

/**
 *  车牌号验证
 *
 *  @return 是车牌号返回YES,反之返回NO
 */
- (BOOL)isValidCarNo;

/**
 *  网址验证
 *
 *  @return 是网站返回YES,反之返回NO
 */
- (BOOL)isValidUrl;

/**
 *  IP地址验证
 *  是否符合IP格式，xxx.xxx.xxx.xxx
 *
 *  @return 是IP的返回YES,反之返回NO
 */
- (BOOL)isValidIP;

/**
 *  身份证验证
 *
 *  @return 是身份证的返回YES,反之返回NO
 */
- (BOOL)isValidIdCardNum;

/**
 *  是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字(常用于帐号验证)
 *
 *  @param minLenth            账号最小长度
 *  @param maxLenth            账号最长长度
 *  @param containChinese      是否包含中文
 *  @param firstCannotBeDigtal 首字母不能为数字(支持首位下划线或者字母)
 *
 *  @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 *  去掉两端空格和换行符
 *
 *  @return 去掉两端空格和换行符后的字符串
 */
- (NSString *)stringByTrimmingBlank;

@end
