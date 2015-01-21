//
//  DTNetworkCache.m
//  GameCenterDemo
//
//  Created by DT on 14-11-14.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTNetworkCache.h"

@interface DTNetworkCache()
@property(nonatomic,copy,readonly)NSString *cachesDir;

@end

@implementation DTNetworkCache

+(instancetype)shareInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken = 0L;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        _cachesDir = @"cn.com.dt.DTNetworkCache";
        _cachesPaths = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)createSharedCache
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *imageDir=[path stringByAppendingPathComponent:self.cachesDir];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _cachesDirPath = imageDir;
}

-(void)deleteSharedCache
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *imageDir=[path stringByAppendingPathComponent:self.cachesDir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageDir error:nil];
}

- (float)checkLocalCacheSize
{
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:self.cachesDirPath];
    for (NSString *fileName in fileEnumerator){
        NSString *filePath = [self.cachesDirPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
//        totalSize += length / 1024.0;
        totalSize += length / 1000.0;
    }
    
    return totalSize;
}

-(NSString*)saveLocalCache:(NSString*)fileName json:(NSDictionary*)json
{
    NSString *diskCachePath = [_cachesDirPath stringByAppendingPathComponent:fileName];
    if (!diskCachePath) {
        return nil;
    }
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:diskCachePath contents:nil attributes:nil];
    [json writeToFile:diskCachePath atomically:YES];
    [_cachesPaths addObject:diskCachePath];
    return diskCachePath;
}

-(NSDictionary*)readLocalCache:(NSString*)path
{
    NSString *diskCachePath = [_cachesDirPath stringByAppendingPathComponent:path];
    return [NSDictionary dictionaryWithContentsOfFile:diskCachePath];
}

-(NSString*)getLocalCachePath:(NSString*)path
{
    return [_cachesDirPath stringByAppendingPathComponent:path];
}

@end
