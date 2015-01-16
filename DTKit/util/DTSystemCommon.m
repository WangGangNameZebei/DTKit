//
//  DTSystemCommon.m
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTSystemCommon.h"
#import"sys/utsname.h"
#import "IOPSKeys.h"
#import "IOPowerSources.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

double systemBrightnessValue()
{
    return [[UIScreen mainScreen] brightness];
}

void systemBrightness(double value)
{
    [UIScreen mainScreen].brightness = value;
}

void systemOpenFlashlight()
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}

void systemOffFlashlight()
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

void systemFlashlightLevel(double level)
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && level>0 && level <=1.0) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device setTorchModeOnWithLevel:level error:nil];
        [device unlockForConfiguration];
    }else if([device hasTorch] && level == 0){
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

void systemFlashlightFlashing(BOOL flashed)
{
    if (!flashed) {
        systemOffFlashlight();
    }else{
        while (true) {
            systemOpenFlashlight();
            sleep(1);
            systemOffFlashlight();
            sleep(1);
        }
    }
}

void systemTimerDisabled(BOOL enabled)
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:enabled];
}

BOOL systemConnectedToNetwork()
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

NSString* systemFetchSSIDInfo()
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) {
            //            [info objectForKey:@"BSSID"];//mac地址
            return [info objectForKey:@"SSID"];
            break;
        }
    }
    return @"";
}

NSString* systemMacAddress()
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

NSString* systemIPAddress()
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

UIImage* systemFuzzyPicture(UIView *view)
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage* systemHQPicture(UIView *view)
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage* systemTranslucenceHQPicture(UIView *view)
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

void systemStartVibrate()
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

void systemRingingSound(int soundID)
{
    //1000-2000 是系统自带的 soundID
    AudioServicesPlaySystemSound(soundID);
}

double systemTotalDiskSpace()
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] floatValue ]/ 1024.0f / 1024.0f / 1024.0f;
}

double systemFreeDiskSpace()
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] floatValue ]/ 1024.0 / 1024.0 ;
}

double systemAvailableMemory()
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

double systemUsedMemory()
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

double systemBatteryLevel()
{
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    long numOfSources = CFArrayGetCount(sources);
    if (numOfSources == 0) {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }
    pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, 0));
    if (!pSource) {
        NSLog(@"Error in IOPSGetPowerSourceDescription");
        return -1.0f;
    }
    psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
    int curCapacity = 0;
    int maxCapacity = 0;
    double percent;
    psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
    CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
    psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
    CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
    percent = ((double)curCapacity/(double)maxCapacity * 100.0f);
    return percent+1.0f;
}

double systemOSBatteryLevel()
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    return deviceLevel;
}

NSString* systemPhoneNumber()
{
    extern NSString *CTSettingCopyMyPhoneNumber();
    return CTSettingCopyMyPhoneNumber();
}

CTCarrier* systemCarrierInfo()
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    //当sim卡更换时弹出此窗口
    info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier * carrier){
        NSLog(@"Sim card changed...");
    };
    CTCarrier *carrier = info.subscriberCellularProvider;
    return carrier;
}

BOOL systemJailBreak()
{
    NSString *path = @"/User/Applications/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        //        NSLog(@"applist = %@", applist);
        return YES;
    }
    return NO;
}


BOOL systemDeviceIsPad()
{
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ) {
        return YES;
    }
    return NO;
}

CGSize systemScreenSize()
{
    return [UIScreen mainScreen].bounds.size;
}

CGSize systemAppFrameSize()
{
    return [UIScreen mainScreen].applicationFrame.size;
}

CGRect systemAppFrameRect()
{
    CGSize size = systemAppFrameSize();
    return CGRectMake(0, 0,size.width, size.height);
}

CGRect systemFrameForOrientation(UIInterfaceOrientation interfaceOrientation)
{
    CGSize size = systemAppFrameSize();
    if( UIInterfaceOrientationIsLandscape(interfaceOrientation) ){
        return CGRectMake(0, 0,size.height, size.width);
    }
    
    return CGRectMake(0, 0,size.width, size.height);
}

NSString* systemName()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *displayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (displayName == nil || [displayName isEqualToString:@""]) {
        return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    }
    return displayName;
}

NSString* systemProjectName()
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
}

NSString* systemBundleName()
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}

NSString* systemIdentifier()
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

NSString* systemVersion()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

NSString* systemBuild()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:@"CFBundleVersion"];
}

NSString* systemDeviceSize()
{
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
    if (width == 320 && height == 480) {
        return @"3.5";
    }else if (width == 320 && height == 568){
        return @"4.0";
    }else if (width == 375 && height == 667){
        return @"4.7";
    }else if (width == 414 && height == 736){
        return @"5.5";
    }
    return nil;
}

NSString* systemCheckCurrentDeviceInformation()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"Simulator";
    return platform;
}

NSString* systemDeviceName()
{
    return [[UIDevice currentDevice] name];
}

NSString* systemDeviceSystemName()
{
    return [[UIDevice currentDevice] systemName];
}

NSString* systemDeviceVersion()
{
    return [[UIDevice currentDevice] systemVersion];
}

NSString* systemDeviceModel()
{
    return [[UIDevice currentDevice] model];
}

NSString* systemDeviceLanguage()
{
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

NSString* systemDeviceCountry()
{
    return [[NSLocale currentLocale] localeIdentifier];
}

float systemX(UIView *view)
{
    return view.frame.origin.x;
}

float systemY(UIView *view)
{
    return view.frame.origin.y;
}

int systemWidth(UIView *view)
{
    return view.frame.size.width;
}

int systemHeight(UIView *view)
{
    return view.frame.size.height;
}

int systemScreenWidth()
{
    return [UIScreen mainScreen].bounds.size.width;
}

int systemScreenHeight()
{
    return [UIScreen mainScreen].bounds.size.height;
}

float systemRight(UIView *view)
{
    return systemX(view)+systemWidth(view);
}

float systemBottom(UIView *view)
{
    return systemY(view)+systemHeight(view);
}

UIColor* systemRGBCOLOR(int r, int g, int b)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];
}

UIColor* systemRGBACOLOR(int r, int g, int b, float a)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a];
}