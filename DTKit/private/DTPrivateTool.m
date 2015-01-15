//
//  DTPrivateTool.m
//  DTKitDemo
//
//  Created by DT on 14-12-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTPrivateTool.h"
#import "DTInstalledAppModel.h"

@implementation DTPrivateTool

+(NSArray*)getInstalledApps
{
    NSString *pathOfApplications = @"/var/mobile/Applications";
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    NSArray *arrayOfApplications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplications error:nil];
    for (NSString *applicationDir in arrayOfApplications) {
        NSString *pathOfApplication = [pathOfApplications stringByAppendingPathComponent:applicationDir];
        NSArray *arrayOfSubApplication = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplication error:nil];
        for (NSString *applicationSubDir in arrayOfSubApplication) {
            if ([applicationSubDir hasSuffix:@".app"]) {// *.app
                NSString *path = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                DTInstalledAppModel *model = [[DTInstalledAppModel alloc] initWithPath:path];
                [tableArray addObject:model];
            }
        }
    }
    return tableArray;
}

@end
