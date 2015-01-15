//
//  DTPrivateTool.h
//  DTKitDemo
//
//  Created by DT on 14-12-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author DT, 14-12-01 09:12:06
 *
 *  @brief 私有方法工具类
 */
@interface DTPrivateTool : NSObject

/**
 *  @Author DT, 14-12-10 15:12:02
 *
 *  @brief  获取设备所有手机APP应用
 *
 *  @return DTInstalledAppModel对象的集合
 */
+(NSArray*)getInstalledApps;

@end
