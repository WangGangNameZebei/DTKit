//
//  DTInstalledAppModel.m
//  DTKitDemo
//
//  Created by DT on 14-12-10.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTInstalledAppModel.h"

@implementation DTInstalledAppModel

-(id)initWithPath:(NSString*)path
{
    self = [super init];
    if (self) {
        self.path = path;
        self.dictionary = [NSDictionary dictionaryWithContentsOfFile:[path stringByAppendingPathComponent:@"Info.plist"]];
        self.BuildMachineOSBuild = [self.dictionary objectForKey:@"BuildMachineOSBuild"];
        self.CFBundleDevelopmentRegion = [self.dictionary objectForKey:@"CFBundleDevelopmentRegion"];
        self.CFBundleDisplayName = [self.dictionary objectForKey:@"CFBundleDisplayName"];
        self.CFBundleExecutable = [self.dictionary objectForKey:@"CFBundleExecutable"];
        self.CFBundleIconFiles = [[NSMutableArray alloc] init];
        for (NSString *CFBundleIconFile in [self.dictionary objectForKey:@"CFBundleIconFiles"]) {
            [self.CFBundleIconFiles addObject:CFBundleIconFile];
        }
        self.CFBundleIcons = [self.dictionary objectForKey:@"CFBundleIcons"];
        self.UILaunchImages = [self.dictionary objectForKey:@"UILaunchImages"];
        self.CFBundleIdentifier = [self.dictionary objectForKey:@"CFBundleIdentifier"];
        self.CFBundleInfoDictionaryVersion = [self.dictionary objectForKey:@"CFBundleInfoDictionaryVersion"];
        self.CFBundleName = [self.dictionary objectForKey:@"CFBundleName"];
        self.CFBundlePackageType = [self.dictionary objectForKey:@"CFBundlePackageType"];
        self.CFBundleResourceSpecification = [self.dictionary objectForKey:@"CFBundleResourceSpecification"];
        self.CFBundleShortVersionString = [self.dictionary objectForKey:@"CFBundleShortVersionString"];
        self.CFBundleSignature = [self.dictionary objectForKey:@"CFBundleSignature"];
        self.CFBundleSupportedPlatforms = [[NSMutableArray alloc] init];
        for (NSString *CFBundleSupportedPlatform in [self.dictionary objectForKey:@"CFBundleSupportedPlatforms"]) {
            [self.CFBundleSupportedPlatforms addObject:CFBundleSupportedPlatform];
        }
        self.CFBundleURLTypes = [self.dictionary objectForKey:@"CFBundleURLTypes"];
        self.CFBundleVersion = [self.dictionary objectForKey:@"CFBundleVersion"];
        self.DTCompiler = [self.dictionary objectForKey:@"DTCompiler"];
        self.DTPlatformBuild = [self.dictionary objectForKey:@"DTPlatformBuild"];
        self.DTPlatformName = [self.dictionary objectForKey:@"DTPlatformName"];
        self.DTPlatformVersion = [self.dictionary objectForKey:@"DTPlatformVersion"];
        self.DTSDKBuild = [self.dictionary objectForKey:@"DTSDKBuild"];
        self.DTSDKName = [self.dictionary objectForKey:@"DTSDKName"];
        self.DTXcode = [self.dictionary objectForKey:@"DTXcode"];
        self.DTXcodeBuild = [self.dictionary objectForKey:@"DTXcodeBuild"];
        self.MinimumOSVersion = [self.dictionary objectForKey:@"MinimumOSVersion"];
        self.UIInterfaceOrientation = [self.dictionary objectForKey:@"UIInterfaceOrientation"];
        self.UIStatusBarHidden = [self.dictionary objectForKey:@"UIStatusBarHidden"];
        self.UISupportedInterfaceOrientations = [[NSMutableArray alloc] init];
        for (NSString *UISupportedInterfaceOrientation in [self.dictionary objectForKey:@"UISupportedInterfaceOrientations"]) {
            [self.UISupportedInterfaceOrientations addObject:UISupportedInterfaceOrientation];
        }
        
    }
    return self;
}

-(UIImage*)imageWithIcon
{
    NSArray *iconFilesArray = [self.dictionary objectForKey:@"CFBundleIconFiles"];
    if (iconFilesArray !=nil && iconFilesArray.count >0) {
        UIImage *image = [UIImage imageWithContentsOfFile:[self.path stringByAppendingPathComponent:[iconFilesArray objectAtIndex:0]]];
        return image;
    }else{
        NSArray *iconssArray = [[[self.dictionary objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"];
        if (iconssArray !=nil && iconssArray.count >0) {
            UIImage *image = [UIImage imageWithContentsOfFile:[self.path stringByAppendingPathComponent:[iconssArray objectAtIndex:0]]];
            return image;
        }
    }
    
    return nil;
}

-(double)appSize
{
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:self.path];
    for (NSString *fileName in fileEnumerator){
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1924.0;
    }
    return totalSize;
}


@end
