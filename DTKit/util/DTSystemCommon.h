//
//  DTSystemCommon.h
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>

//-----------------------------------------
//------------ 系统常用方法 -----------------
//-----------------------------------------

#pragma mark 获取设备屏幕亮度
/**
 *  @Author DT, 14-12-10 10:12:23
 *
 *  @brief  获取设备屏幕亮度
 *
 *  @return 屏幕亮度
 */
double systemBrightnessValue();

#pragma mark 设置设备屏幕亮度
/**
 *  @Author DT, 14-12-10 10:12:50
 *
 *  @brief  设置设备屏幕亮度
 *
 *  @param value 亮度值 范围[0-1]
 */
void systemBrightness(double value);

#pragma mark 打开设备闪光灯
/**
 *  @Author DT, 14-12-09 15:12:45
 *
 *  @brief  打开设备闪光灯
 */
void systemOpenFlashlight();

#pragma mark 关闭设备闪光灯
/**
 *  @Author DT, 14-12-09 15:12:55
 *
 *  @brief  关闭设备闪光灯
 */
void systemOffFlashlight();

#pragma mark 修改设备闪光灯亮度
/**
 *  @Author DT, 14-12-09 16:12:39
 *
 *  @brief  修改设备闪光灯亮度
 *
 *  @param level 亮度范围(0～1) 0:闪光灯会关闭 >0:闪光灯会启动
 */
void systemFlashlightLevel(double level);

#pragma mark 设备闪光灯闪烁
/**
 *  @Author DT, 14-12-09 16:12:39
 *
 *  @brief  设备闪光灯闪烁
 *
 *  @param levflashedel YES:开启闪光灯并且闪烁,间隔1秒 NO:关闭闪光灯
 */
void systemFlashlightFlashing(BOOL flashed);

#pragma mark 设置屏幕休眠状态
/**
 *  @Author DT, 14-12-09 15:12:04
 *
 *  @brief  设置屏幕休眠状态
 *
 *  @param enabled YES的话屏幕不允许休眠,NO的话屏幕允许休眠
 */
void systemTimerDisabled(BOOL enabled);

#pragma mark 判断设备是否联网
/*!
 *  @Author DT
 *
 *  @brief  判断设备是否联网
 *
 *  @return 联网的话返回YES,反之返回NO
 */
BOOL systemConnectedToNetwork();

#pragma mark 获取手机连接wifi的名称
/**
 *  @Author DT, 14-12-09 14:12:54
 *
 *  @brief  获取手机连接wifi的名称
 *
 *  @return 连接wifi的名称,没有连接的话返回空字符串
 */
NSString* systemFetchSSIDInfo();

#pragma mark 获取设备mac地址
/**
 *  @Author DT, 14-12-09 15:12:03
 *
 *  @brief  返回设备mac地址
 *
 *  @return mac地址 格式为 xx:xx:xx:xx:xx:xx
 */
NSString* systemMacAddress();

#pragma mark 获取设备ip地址
/**
 *  @Author DT, 14-12-10 09:12:50
 *
 *  @brief  返回设备ip地址
 *
 *  @return ip地址 格式为xx.xx.xx.xx
 */
NSString* systemIPAddress();

#pragma mark view转化模糊image
/*!
 *  @Author DT
 *
 *  @brief  把指定view转化成模糊图片
 *
 *  @param view 指定view
 *
 *  @return 模糊图片
 */
UIImage* systemFuzzyPicture(UIView *view);

#pragma mark view转化高清image(可用于屏幕截图)
/*!
 *  @Author DT
 *
 *  @brief  把指定view转化成高清图片
 *
 *  @param view 指定view
 *
 *  @return 高清图片
 */
UIImage* systemHQPicture(UIView *view);

#pragma mark view转化半透明高清image
/*!
 *  @Author DT
 *
 *  @brief  把指定view转化成半透明高清图片
 *
 *  @param view 指定view
 *
 *  @return 半透明高清图片
 */
UIImage* systemTranslucenceHQPicture(UIView *view);

#pragma mark 使手机振动
/**
 *  @Author DT, 14-12-09 15:12:12
 *
 *  @brief  使手机振动,只是短振(一次)
 */
void systemStartVibrate();

#pragma mark 使手机播放系统声音
/**
 *  @Author DT, 14-12-10 10:12:35
 *
 *  @brief  使手机播放系统声音
 *
 *  @param soundID 声音id 范围[1000-2000]
 */
void systemRingingSound(int soundID);

#pragma mark 返回设备总的容量大小
/**
 *  @Author DT, 14-12-04 14:12:46
 *
 *  @brief  返回设备总的容量大小
 *
 *  @return 容量大小,单位为GB
 */
double systemTotalDiskSpace();

#pragma mark 返回设备当前可用的容量大小
/**
 *  @Author DT, 14-12-04 14:12:07
 *
 *  @brief  返回设备当前可用的容量大小,跟系统的有点出入
 *
 *  @return 容量大小,单位为MB
 */
double systemFreeDiskSpace();

#pragma mark 返回系统可以使用的内存大小
/**
 *  @Author DT, 14-12-03 17:12:32
 *
 *  @brief  返回系统可以使用的内存的大小
 *
 *  @return 内存大小,单位为MB
 */
double systemAvailableMemory();

#pragma mark 返回应用当前使用的内存的大小
/**
 *  @Author DT, 14-12-03 17:12:13
 *
 *  @brief  返回应用当前使用的内存的大小
 *
 *  @return 内存大小,单位为MB
 */
double systemUsedMemory();

#pragma mark 返回手机剩余电量,精确到0.01
/**
 *  @Author DT, 14-12-09 10:12:55
 *
 *  @brief  返回手机当前剩余电池量,需要导入IOKit库
 *          可以精确到0.01，但是与系统显示的仍有偏差。
 *
 *  @return 电池量,返回-1的话表示模拟器来的
 */
double systemBatteryLevel();

#pragma mark 返回手机剩余电量,精确到0.05
/**
 *  @Author DT, 14-12-09 14:12:51
 *
 *  @brief  使用ios自带API获取手机剩余电池量
 *          获取的数值是从0.0到1.0之间，每次获取的数值都是递增0.05
 *
 *  @return 电池量,返回-1的话表示模拟器来的
 */
double systemOSBatteryLevel();

#pragma mark 获取设置手机号码
/**
 *  @Author DT, 14-12-04 16:12:52
 *
 *  @brief  获取设置手机号码
 *
 *  @return 手机号码字符串
 */
NSString* systemPhoneNumber();

#pragma mark 获取手机sim卡信息
/**
 *  @Author DT, 14-12-04 15:12:02
 *
 *  @brief  获取手机sim卡信息
 *
 *  @return 返回CTCarrier对象,可以具体以下属性获取信息
 *  carrier.carrierName 供应商名称
 *  carrier.mobileCountryCode 国家编号
 *  carrier.mobileNetworkCode 供应商网络编号
 *  carrier.isoCountryCode 国家代码字符串
 *  carrier.allowsVOIP 是否允许voip
 */
CTCarrier* systemCarrierInfo();

#pragma mark 判断当前设备是否越狱
/**
 *  @Author DT, 14-12-04 15:12:17
 *
 *  @brief  判断当前设备是否越狱,
 *          根据读取系统"/User/Applications/"目录的权限来判断是否越狱,没有越狱的话没有权限可以读取得到
 *
 *  @return 已经越狱的话返回YES,反之返回NO
 */
BOOL systemJailBreak();

#pragma mark 判断设备是否ipad
/**
 *  @Author DT, 14-12-03 17:12:32
 *
 *  @brief  判断是否ipad
 *
 *  @return 是ipad返回YES,不是返回NO
 */
BOOL systemDeviceIsPad();

#pragma mark 返回设备屏幕大小
/**
 *  @Author DT, 14-12-03 17:12:50
 *
 *  @brief  返回屏幕的大小
 *
 *  @return 大小
 */
CGSize systemScreenSize();

#pragma mark 返回应用程序框架大小
/**
 *  @Author DT, 14-12-03 17:12:01
 *
 *  @brief  返回应用程序框架的大小
 *
 *  @return 大小
 */
CGSize systemAppFrameSize();

#pragma mark 返回应用程序框架Rect
/**
 *  @Author DT, 14-12-03 17:12:08
 *
 *  @brief  返回应用程序框架的Rect
 *
 *  @return Rect
 */
CGRect systemAppFrameRect();

#pragma mark 返回当前应用程序Rect
/**
 *  @Author DT, 14-12-03 17:12:15
 *
 *  @brief  返回当前应用程序的Rect
 *  @param  设备方向
 *
 *  @return Rect
 */
CGRect systemFrameForOrientation(UIInterfaceOrientation interfaceOrientation);

#pragma mark 获取应用程序名称
/**
 *  @Author DT, 14-12-01 10:12:10
 *
 *  @brief 获取APP名称,使用CFBundleDisplayName
 *
 *  @return 名称
 */
NSString* systemName();

#pragma mark 获取应用程序APP名称
/**
 *  @Author DT, 14-12-01 10:12:49
 *
 *  @brief 获取APP项目名称
 *
 *  @return 项目名称
 */
NSString* systemProjectName();

#pragma mark 获取应用程序包名
/**
 *  @Author DT, 14-12-01 10:12:07
 *
 *  @brief 获取APP项目包名
 *
 *  @return 包名
 */
NSString* systemBundleName();

#pragma mark 获取应用程序Bundle Identifier
/**
 *  @Author DT, 14-12-01 10:12:38
 *
 *  @brief 获取APP项目Bundle Identifier
 *
 *  @return Bundle Identifier
 */
NSString* systemIdentifier();

#pragma mark 获取应用程序版本号
/**
 *  @Author DT, 14-12-01 10:12:04
 *
 *  @brief 获取APP项目版本
 *
 *  @return Version
 */
NSString* systemVersion();

#pragma mark 获取应用程序Build
/**
 *  @Author DT, 14-12-01 10:12:15
 *
 *  @brief 获取APP项目Build
 *
 *  @return Build
 */
NSString* systemBuild();

#pragma mark 获取设备的尺寸
/*
 *  @Author DT
 *
 *  @brief  获取设备的尺寸
 *
 *  @return 返回"3.5"、"4.0"、"4.7"、"5.5",未知设备返回nil
 */
NSString* systemDeviceSize();

#pragma mark 获取设备的硬件名称
/**
 *  @Author DT, 14-12-01 10:12:21
 *
 *  @brief  获取设备的硬件名称
 *
 *  @return 硬件名称
 */
NSString* systemCheckCurrentDeviceInformation();

#pragma mark 获取设备关于本机名称
/**
 *  @Author DT, 14-12-01 10:12:17
 *
 *  @brief 获取设备名称(关于本机 - 名称)
 *
 *  @return 名称
 */
NSString* systemDeviceName();

#pragma mark 获取设备系统名称
/**
 *  @Author DT, 14-12-01 10:12:39
 *
 *  @brief 获取设备系统名称(iPhone OS or iPod OS)
 *
 *  @return 系统名称
 */
NSString* systemDeviceSystemName();

#pragma mark 获取设备系统版本
/**
 *  @Author DT, 14-12-01 10:12:41
 *
 *  @brief 获取设备系统版本
 *
 *  @return 系统版本
 */
NSString* systemDeviceVersion();

#pragma mark 获取设备系统类型
/**
 *  @Author DT, 14-12-01 10:12:52
 *
 *  @brief 获取设备系统类型(iPhone os iPod touch)
 *
 *  @return 系统类型
 */
NSString* systemDeviceModel();

#pragma mark 获取设备系统语言
/**
 *  @Author DT, 14-12-01 10:12:37
 *
 *  @brief 获取设备系统语言
 *
 *  @return 语言
 */
NSString* systemDeviceLanguage();

#pragma mark 获取设备系统国家
/**
 *  @Author DT, 14-12-01 10:12:56
 *
 *  @brief 获取设备系统国家
 *
 *  @return 国家
 */
NSString* systemDeviceCountry();

#pragma mark 获取指定view的x值
/**
 *  @Author DT, 14-12-16 09:12:03
 *
 *  @brief  获取指定view的x值
 *
 *  @param view 指定view
 *
 *  @return x值
 */
float systemX(UIView *view);

#pragma mark 获取指定view的y值
/**
 *  @Author DT, 14-12-16 09:12:29
 *
 *  @brief  获取指定view的y值
 *
 *  @param view 指定view
 *
 *  @return y值
 */
float systemY(UIView *view);

#pragma mark 获取指定view的width值
/**
 *  @Author DT, 14-12-16 09:12:44
 *
 *  @brief  获取指定view的width值
 *
 *  @param view 指定view
 *
 *  @return width值
 */
int systemWidth(UIView *view);

#pragma mark 获取指定view的height值
/**
 *  @Author DT, 14-12-16 09:12:05
 *
 *  @brief  获取指定view的height值
 *
 *  @param view 指定view
 *
 *  @return height值
 */
int systemHeight(UIView *view);

#pragma mark 获取指定view的Right值
/**
 *  @Author DT, 14-12-16 09:12:05
 *
 *  @brief  获取指定view的right值,即x+width
 *
 *  @param view 指定view
 *
 *  @return right值
 */
float systemRight(UIView *view);

#pragma mark 获取指定view的Bottom值
/**
 *  @Author DT, 14-12-16 09:12:05
 *
 *  @brief  获取指定view的bottom值,即y+height
 *
 *  @param view 指定view
 *
 *  @return bottom值
 */
float systemBottom(UIView *view);

#pragma mark 获取设备宽度
/**
 *  @Author DT, 14-12-16 09:12:20
 *
 *  @brief  获取设备宽度
 *
 *  @return 宽度
 */
int systemScreenWidth();

#pragma mark 获取设备高度
/**
 *  @Author DT, 14-12-16 09:12:31
 *
 *  @brief  获取设备高度
 *
 *  @return 高度
 */
int systemScreenHeight();

#pragma mark RGB赋值颜色,没有透明度
/*!
 *  @Author DT
 *
 *  @brief  RGB赋值颜色,没有透明度
 *
 *  @param r 红色
 *  @param g 绿色
 *  @param b 蓝色
 *
 *  @return UIColor
 */
UIColor* systemRGBCOLOR(int r, int g, int b);

#pragma mark RGB赋值颜色,有透明度
/*!
 *  @Author DT
 *
 *  @brief  RGB赋值颜色,有透明度
 *
 *  @param r 红色
 *  @param g 绿色
 *  @param b 蓝色
 *  @param a 透明度[0-1]范围
 *
 *  @return UIColor
 */
UIColor* systemRGBACOLOR(int r, int g, int b, float a);
