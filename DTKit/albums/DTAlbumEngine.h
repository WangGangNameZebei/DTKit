//
//  DTAlbumEngine.h
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef enum {
    AssetTypeAll,//获取相薄是全部类型
    AssetTypePhoto,//获取相薄的相片
    AssetTypeVideo,//获取相薄的视频
}AssetsType;

/**
 *  @Author DT, 14-12-03 10:12:03
 *
 *  @brief  设备相册引擎类
 */
@interface DTAlbumEngine : NSObject

/**
 *  @Author DT, 14-12-03 10:12:34
 *
 *  @brief  初始化方法
 *
 *  @return 返回DTAlbumEngine对象
 */
+(DTAlbumEngine*)shareInstance;

/**
 *  @Author DT, 14-12-03 10:12:27
 *
 *  @brief  获取设备相薄信息
 *
 *  @param type  相薄类型 ALAssetsGroupAll:表示全部相薄 ALAssetsGroupSavedPhotos:表示相机胶卷相薄
 *  @param block 回调函数,返回ALAssetsGroup对象集合,如果没有相册访问权限的话不会执行block函数
 */
- (void)getAlbumInfoWithTypes:(ALAssetsGroupType)type block:(void(^)(NSArray *groupArray))block;

/**
 *  @Author DT, 14-12-03 13:12:47
 *
 *  @brief  获取设备相册中信息内容
 *
 *  @param group     相薄的ALAssetsGroup对象
 *  @param assetType 相薄中的数据的类型 AssetTypePhoto:表示只获取图片 AssetTypeVideo:表示只获取视频
 *  @param block 回调函数,返回ALAsset对象集合,如果没有相册访问权限的话不会执行block函数
 */
- (void)getAlbumWithGroup:(ALAssetsGroup*)group type:(AssetsType)assetType block:(void(^)(NSArray *assetArray))block;

/**
 *  @Author DT, 14-12-02 11:12:41
 *
 *  @brief  创建一个相册
 *
 *  @param name  相册名称
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,group为nil的话表示相册名称重复,如果没有相册访问权限的话不会执行block函数
 */
- (void)addAlbumGroupWithName:(NSString*)name block:(void(^)(ALAssetsGroup *group))block;

/**
 *  @Author DT, 14-12-02 13:12:26
 *
 *  @brief  根据一个相册名称获取相册的相应属性
 *
 *  @param name  相册名称
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,groupArray为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 */
- (void)albumGroupForName:(NSString *)name block:(void (^)(NSArray *groupArray))block;

/**
 *  @Author DT, 14-12-02 13:12:26
 *
 *  @brief  根据一个相册url地址获取相册的相应属性
 *
 *  @param url   url地址
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,group为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 */
- (void)albumGroupForURL:(NSURL*)url block:(void(^)(ALAssetsGroup *group))block;

/**
 *  @Author DT, 14-12-02 13:12:06
 *
 *  @brief  根据相册图片url地址获取图片的相应属性
 *
 *  @param url   url地址
 *  @param block 回调函数,返回相册图片的ALAsset对象,asset为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
- (void)assetForURL:(NSURL*)url block:(void(^)(ALAsset *asset))block;

/**
 *  @Author DT, 14-12-02 14:12:26
 *
 *  @brief  往默认相册中写入数据
 *
 *  @param date  数据流(图片、gif...)
 *  @param block 回调函数,返回数据的url地址,url为nil的话表示写入不成功,如果没有相册访问权限的话不会执行block函数
 */
- (void)writeImageDataToAlbum:(NSData*)date block:(void(^)(NSURL *url))block;

/**
 *  @Author DT, 14-12-02 15:12:09
 *
 *  @brief  往默认相册中写入图片
 *
 *  @param image 图片
 *  @param block 回调函数,返回数据的url地址,url为nil的话表示写入不成功,如果没有相册访问权限的话不会执行block函数
 */
- (void)writeImageToAlbum:(UIImage*)image block:(void(^)(NSURL *url))block;

@end
