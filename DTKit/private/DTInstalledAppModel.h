//
//  DTInstalledAppModel.h
//  DTKitDemo
//
//  Created by DT on 14-12-10.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author DT, 14-12-10 13:12:23
 *
 *  @brief  应用数据Model
 */
@interface DTInstalledAppModel : NSObject

/**
 *  @Author DT, 14-12-10 14:12:38
 *
 *  @brief  初始化方法
 *
 *  @param dictionary 数据源
 *
 *  @return 返回当前Model
 */
-(id)initWithPath:(NSString*)path;

/**
 *  @Author DT, 14-12-10 15:12:42
 *
 *  @brief  获取APP应用图片
 *
 *  @return UIImage对象
 */
-(UIImage*)imageWithIcon;

/**
 *  @Author DT, 14-12-11 16:12:16
 *
 *  @brief  返回APP包大小,单位是MB
 *
 *  @return 大小,与系统查的有出入
 */
-(double)appSize;

/** APP应用路径 */
@property(nonatomic,copy)NSString *path;
/** 原始数据源 */
@property(nonatomic,strong)NSDictionary *dictionary;

@property(nonatomic,copy)NSString *BuildMachineOSBuild;
/** 多语言。应用程序本地化的一列表，期间用逗号隔开，例如应用程序支持英语 日语，将会适用 English,Japanese */
@property(nonatomic,copy)NSString *CFBundleDevelopmentRegion;
/** 这用于设置应用程序的名称，它显示在iphone屏幕的图标下方。应用程序名称限制在10－12个字符，如果超出，iphone将缩写名称 */
@property(nonatomic,copy)NSString *CFBundleDisplayName;
/**  应用程序的可执行文件。对于一个可加载束,它是一个可以被束动态加载的二进制文件。对于一个框架，它是一个共享库。Project Builder会自动把该关键字加入到合适项目的Info.plist文件中。 */
@property(nonatomic,copy)NSString *CFBundleExecutable;
/** 应用程序图标。*/
@property(nonatomic,strong)NSMutableArray *CFBundleIconFiles;
/** 应用程序图标。*/
@property(nonatomic,strong)NSDictionary *CFBundleIcons;
/** 应用程序图标。*/
@property(nonatomic,strong)NSDictionary *UILaunchImages;

/** 身份证书，这个为应用程序在iphone developer program portal web站点上设置的唯一标识符。（就是你安装证书的时候，需要把这里对应修改）。*/
@property(nonatomic,copy)NSString *CFBundleIdentifier;

@property(nonatomic,copy)NSString *CFBundleInfoDictionaryVersion;
/** 简称。简称应该小于16个字符并且适合在菜单和“关于”中显示。*/
@property(nonatomic,copy)NSString *CFBundleName;
/** 关键字指定了束的类型，类似于Mac OS 9的文件类型代码。该关键字的值包含一个四个字母长的代码。应用程序的代码是‘APPL’；框架的代码是‘FMWK’；可装载束的代码是‘BND’ */
@property(nonatomic,copy)NSString *CFBundlePackageType;

@property(nonatomic,copy)NSString *CFBundleResourceSpecification;
/** 指定了束的版本号。一般包含该束的主、次版本号。CFBundleShortVersionString的值描述了一种更加正式的并且不随每一次创建而改变的版本号。*/
@property(nonatomic,copy)NSString *CFBundleShortVersionString;
/** 指定了束的创建者，类似于Mac OS 9中的文件创建者代码。该关键字的值包含四字母长的代码，用来确定每一个束。*/
@property(nonatomic,copy)NSString *CFBundleSignature;
/** APP支持版本 */
@property(nonatomic,strong)NSMutableArray *CFBundleSupportedPlatforms;
/**
 *  @Author DT, 14-12-10 14:12:08
 *
 *  @brief  包含了一组描述了应用程序所支持的URL协议的字典。它的用途类似于CFBundleDocumentTypes的作用，但它描述了URL协议而不是文档类型。每一个字典条目对应一个单独的URL协议。
 *
 CFBundleTypeRole       String      该关键字定义了那些与URL类型有关的应用程序的角色（即该应用程序与某种文档类型的关系）。
                                    它的值可以是Editer，Viewer，Printer，Shell或None。有关这些值的详细描述可以参见“ 文档的配置”。该关键字是必须的。
 CFBundleURLIconFile	String      该关键字包含了被用于这种URL类型的图标文件名（不包括扩展名）字符串。
 CFBundleURLName        String      该关键字包含了这种URL类型的抽象名称字符串。为了确保唯一性，建议您使用Java包方式的命名法则。
                                    这个名字作为一个关键字也会在InfoPlist.strings文件中出现，用来提供该类型名的可读性版本。
 CFBundleURLSchemes     Array       该关键字包含了一组可被这种类型处理的URL协议。例如：http,ftp等。
 */
@property(nonatomic,strong)NSArray *CFBundleURLTypes;
/**  这个会设置应用程序版本号，每次部署应用程序的一个新版本时，将会增加这个编号，在app store用的。 */
@property(nonatomic,copy)NSString *CFBundleVersion;
/** 状态栏类型 */
@property(nonatomic,copy)NSString *UIStatusBarStyle;
/** 设备方向 */
@property(nonatomic,copy)NSString *UIInterfaceOrientation;
/** 默认情况下，应用程序被设置了玻璃效果，把这个设置为true可以阻止这么做。*/
@property(nonatomic,copy)NSString *UIPrerenderedIcon;
/** 指定程序适用于哪些设备。*/
@property(nonatomic,strong)NSMutableArray *UIRequiredDeviceCapabilities;
/** 设置是否隐藏状态栏。*/
@property(nonatomic,copy)NSString *UIStatusBarHidden;
/** 支持方向 */
@property(nonatomic,strong)NSMutableArray *UISupportedInterfaceOrientations;

@property(nonatomic,copy)NSString *DTCompiler;
@property(nonatomic,copy)NSString *DTPlatformBuild;
@property(nonatomic,copy)NSString *DTPlatformName;
@property(nonatomic,copy)NSString *DTPlatformVersion;
@property(nonatomic,copy)NSString *DTSDKBuild;
@property(nonatomic,copy)NSString *DTSDKName;
@property(nonatomic,copy)NSString *DTXcode;
@property(nonatomic,copy)NSString *DTXcodeBuild;
@property(nonatomic,copy)NSString *MinimumOSVersion;
@property(nonatomic,strong)NSMutableArray *PrivateURLSchemes;
@property(nonatomic,copy)NSString *SBIconClass;
@property(nonatomic,strong)NSMutableArray *SBMatchingApplicationGenres;
@property(nonatomic,copy)NSString *SBUsesNetwork;
@property(nonatomic,strong)NSMutableArray *UIDeviceFamily;

@end
