//
//  DTAddressBookTool.h
//  DTKitDemo
//
//  Created by DT on 14-12-4.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

/**
 *  @Author DT, 14-12-04 16:12:33
 *
 *  @brief  通讯录工具类
 */
@interface DTAddressBookTool : NSObject

/**
 *  @Author DT, 14-12-05 10:12:55
 *
 *  @brief  检查通讯录权限
 *          苹果的app访问位置或者通讯录，第一次都会有一个提示让你选择。
 *          但是第二次及以后，即时删掉，也不会再出现了。
 *          如果想再次出现，可以  设置-通用-还原-还原位置与隐私
 *          这样你再次点击你的app就会再次出现了。
 *
 *  @return 有通讯录权限的返回YES,反之返回NO
 */
+ (BOOL)addressBookAuthorizationEnabled;

/**
 *  @Author DT, 14-12-05 10:12:31
 *
 *  @brief  获取通讯录信息
 *
 *  @param block 回调函数,返回DTAddressBookModel对象,如果没有通讯录访问权限的话不会执行block函数
 *
 *  @return 有通讯录权限的返回YES,反之返回NO
 */
+(BOOL)getAddressBooks:(void(^)(NSArray *addressBookArray))block;

/**
 *  @Author DT, 14-12-05 14:12:32
 *
 *  @brief  根据姓名获取通讯录信息
 *
 *  @param name  姓名
 *  @param block 回调函数,返回DTAddressBookModel对象,如果没有通讯录访问权限的话不会执行block函数
 *
 *  @return 有通讯录权限的返回YES,反之返回NO
 */
+(BOOL)getAddressBooksWithName:(NSString*)name block:(void(^)(NSArray *addressBookArray))block;

/**
 *  @Author DT, 14-12-05 15:12:04
 *
 *  @brief  创建一个通讯录信息
 *
 *  @param name   姓名
 *  @param phones 电话,不定参数,以nil结束
 *
 *  @return 有通讯录权限或者创建成功的话返回YES,反之返回NO
 */
+(BOOL)createNewAddressBookWithName:(NSString*)name phone:(NSString *)phones, ...;

/**
 *  @Author DT, 14-12-05 15:12:03
 *
 *  @brief  修改通讯录信息,会替换掉原来的电话号码
 *
 *  @param personId 通讯录id,可以根据getAddressBooksWithName方法获取id
 *  @param phones   电话,不定参数,以nil结束
 *
 *  @return 有通讯录权限或者修改成功的话返回YES,反之返回NO
 */
+(BOOL)editAddressBookWithId:(NSNumber*) personId phone:(NSString *)phones, ...;

/**
 *  @Author DT, 14-12-05 15:12:24
 *
 *  @brief  删除通讯录信息
 *
 *  @param personId 通讯录id,可以根据getAddressBooksWithName方法获取id
 *
 *  @return 有通讯录权限或者删除成功的话返回YES,反之返回NO
 */
+(BOOL)deleteAddressBookWithId:(NSNumber*) personId;

@end
