//
//  DTAddressBookModel.h
//  DTKitDemo
//
//  Created by DT on 14-12-4.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author DT, 14-12-04 16:12:08
 *
 *  @brief  设备通讯录Model
 */
@interface DTAddressBookModel : NSObject

/** 用户id */
@property(nonatomic,assign)NSNumber *personId;
/** 名字 */
@property(nonatomic,copy)NSString *personName;
/** 姓氏 */
@property(nonatomic,copy)NSString *lastName;
/** 中间名 */
@property(nonatomic,copy)NSString *middleName;
/** 前缀 */
@property(nonatomic,copy)NSString *prefix;
/** 后缀 */
@property(nonatomic,copy)NSString *suffix;
/** 昵称 */
@property(nonatomic,copy)NSString *nickName;
/** 名字汉语拼音或音标 */
@property(nonatomic,copy)NSString *firstNamePhonetic;
/** 姓氏汉语拼音或音标 */
@property(nonatomic,copy)NSString *lastNamePhonetic;
/** 中间名汉语拼音或音标 */
@property(nonatomic,copy)NSString *middleNamePhonetic;
/** 组织名 */
@property(nonatomic,copy)NSString *organization;
/** 头衔 */
@property(nonatomic,copy)NSString *jobTitle;
/** 部门 */
@property(nonatomic,copy)NSString *department;
/** 生日 */
@property(nonatomic,strong)NSDate *birthDay;
/** 备注 */
@property(nonatomic,copy)NSString *note;
/** 第一次添加该条记录的时间 */
@property(nonatomic,copy)NSString *firstKnow;
/** 最后一次修改該条记录的时间 */
@property(nonatomic,copy)NSString *lastKnow;
/** email集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *emailArray;
/** address集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *addressArray;
/** dates集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *datesArray;
/** 是否公司 */
@property(nonatomic,assign)BOOL isCompany;
/** IM集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *imArray;
/** phone集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *phoneArray;
/** URL集合 类型是NSDictionary */
@property(nonatomic,strong)NSArray *urlArray;
/** image头像 */
@property(nonatomic,strong)UIImage *image;

@end
