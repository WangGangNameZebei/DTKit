//
//  DTAlbumTool.m
//  DTKitDemo
//
//  Created by DT on 14-12-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlbumTool.h"
#import "DTAlbumEngine.h"

@implementation DTAlbumTool

+ (BOOL)albumsAuthorizationEnabled
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}

+ (BOOL)cameraAuthorizationEnabled
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus ==ALAuthorizationStatusDenied){
            return NO;
        }
        return YES;
    }
    return YES;
}

+ (BOOL)getAlbumInfo:(void(^)(ALAssetsGroup *group))block;
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] getAlbumInfoWithTypes:ALAssetsGroupSavedPhotos block:^(NSArray *groupArray) {
            block([groupArray objectAtIndex:0]);
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumFirstPhoto:(void(^)(ALAsset *asset))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumInfo:^(ALAssetsGroup *group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                block(result);
            }];
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumLastPhoto:(void(^)(ALAsset *asset))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumInfo:^(ALAssetsGroup *group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:[group numberOfAssets]-1] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                block(result);
            }];
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumAll:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumInfo:^(ALAssetsGroup *group) {
            [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypeAll block:block];
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumPhotos:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumInfo:^(ALAssetsGroup *group) {
            [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypePhoto block:block];
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumVideos:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumInfo:^(ALAssetsGroup *group) {
            [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypeVideo block:block];
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumsInfo:(void(^)(NSArray *groupArray))block;
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] getAlbumInfoWithTypes:ALAssetsGroupAll block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumsAll:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumsInfo:^(NSArray *groupArray) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (ALAssetsGroup *group in groupArray) {
                [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypeAll block:^(NSArray *assetArray) {
                    [array addObjectsFromArray:assetArray];
                }];
            }
            block([NSArray arrayWithArray:array]);
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumsPhotos:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumsInfo:^(NSArray *groupArray) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (ALAssetsGroup *group in groupArray) {
                [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypePhoto block:^(NSArray *assetArray) {
                    [array addObjectsFromArray:assetArray];
                }];
            }
            block([NSArray arrayWithArray:array]);
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)getAlbumsVideos:(void(^)(NSArray *assetArray))block
{
    if ([self albumsAuthorizationEnabled]) {
        [self getAlbumsInfo:^(NSArray *groupArray) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (ALAssetsGroup *group in groupArray) {
                [[DTAlbumEngine shareInstance] getAlbumWithGroup:group type:AssetTypeVideo block:^(NSArray *assetArray) {
                    [array addObjectsFromArray:assetArray];
                }];
            }
            block([NSArray arrayWithArray:array]);
        }];
        return YES;
    }
    return NO;
}

+ (BOOL)addAlbumGroupWithName:(NSString*)name block:(void(^)(ALAssetsGroup *group))block
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] addAlbumGroupWithName:name block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)albumGroupForName:(NSString *)name block:(void (^)(NSArray *groupArray))block;
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] albumGroupForName:name block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)albumGroupForURL:(NSURL*)url block:(void(^)(ALAssetsGroup *group))block
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] albumGroupForURL:url block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)assetForURL:(NSURL*)url block:(void(^)(ALAsset *asset))block
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] assetForURL:url block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)writeImageDataToAlbum:(NSData*)date block:(void(^)(NSURL *url))block
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] writeImageDataToAlbum:date block:block];
        return YES;
    }
    return NO;
}

+ (BOOL)writeImageToAlbum:(UIImage*)image block:(void(^)(NSURL *url))block;
{
    if ([self albumsAuthorizationEnabled]) {
        [[DTAlbumEngine shareInstance] writeImageToAlbum:image block:block];
        return YES;
    }
    return NO;
    
}

+ (BOOL)writeImageDataToAlbum:(NSData*)date albumUrl:(NSURL*)albumUrl block:(void(^)(NSURL *url))block;
{
    if ([self albumsAuthorizationEnabled]) {//相册权限检查
        [self writeImageDataToAlbum:date block:^(NSURL *url) {//保存图片到系统默认相册
            [self assetForURL:url block:^(ALAsset *asset) {//根据图片url获取图片ALAsset对象
                [self albumGroupForURL:albumUrl block:^(ALAssetsGroup *group) {//根据相薄url获取相薄ALAssetsGroup对象
                    BOOL state = [group addAsset:asset];//把图片保存到指定相薄
                    if (state) {
                        block(url);
                    }else{
                        block(nil);
                    }
                }];
            }];
        }];
        return YES;
    }
    return NO;
}

@end
