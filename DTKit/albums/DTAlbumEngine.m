//
//  DTAlbumEngine.m
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlbumEngine.h"

@interface DTAlbumEngine()

@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;
@end

@implementation DTAlbumEngine

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
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void)getAlbumInfoWithTypes:(ALAssetsGroupType)type block:(void(^)(NSArray *groupArray))block;
{
    NSMutableArray *groupArray=[[NSMutableArray alloc] init];
    [self.assetsLibrary enumerateGroupsWithTypes:type usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groupArray addObject:group];
        }else{
            block([[groupArray reverseObjectEnumerator] allObjects]);
        }
    } failureBlock:^(NSError *error) {
        block(nil);
    }];
}

- (void)getAlbumWithGroup:(ALAssetsGroup*)group type:(AssetsType)assetType block:(void(^)(NSArray *assetArray))block
{
    if (assetType == AssetTypePhoto){//相片
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
    }else if (assetType == AssetTypeVideo){//视频
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
    }
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [assetArray addObject:result];
        }else{
            block([NSArray arrayWithArray:assetArray]);
        }
    }];
}

- (void)addAlbumGroupWithName:(NSString*)name block:(void(^)(ALAssetsGroup *group))block
{
    typeof(self) __weak weakSelf = self;
    [self.assetsLibrary addAssetsGroupAlbumWithName:name resultBlock:^(ALAssetsGroup *group) {
        if (group) {
            block(group);
        }else{
            [weakSelf albumGroupForName:name block:^(NSArray *groupArray) {
                block([groupArray lastObject]);
            }];
        }
    } failureBlock:^(NSError *error) {
        block(nil);
    }];
}

- (void)albumGroupForName:(NSString *)name block:(void (^)(NSArray *groupArray))block;
{
    [self getAlbumInfoWithTypes:ALAssetsGroupAll block:^(NSArray *groupArray) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (ALAssetsGroup *group in groupArray) {
            if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:name]) {
                [array addObject:group];
            }
        }
        block(array);
    }];
}

- (void)albumGroupForURL:(NSURL*)url block:(void(^)(ALAssetsGroup *group))block
{
    [self.assetsLibrary groupForURL:url resultBlock:^(ALAssetsGroup *group) {
        block(group);
    } failureBlock:^(NSError *error) {
        block(nil);
    }];
}

- (void)assetForURL:(NSURL*)url block:(void(^)(ALAsset *asset))block
{
    [self.assetsLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
        block(asset);
    } failureBlock:^(NSError *error) {
        block(nil);
    }];
}

- (void)writeImageDataToAlbum:(NSData*)date block:(void(^)(NSURL *url))block
{
    [self.assetsLibrary writeImageDataToSavedPhotosAlbum:date metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if (assetURL) {
            block(assetURL);
        }else{
            block(nil);
        }
    }];
}

- (void)writeImageToAlbum:(UIImage*)image block:(void(^)(NSURL *url))block;
{
    [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if (assetURL) {
            block(assetURL);
        }else{
            block(nil);
        }
    }];
    
}

@end
