//
//  DTAlbumTool.h
//  DTKitDemo
//
//  Created by DT on 14-12-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

/**
 *  @Author DT, 14-12-02 10:12:28
 *
 *  @brief  相册工具类
 */
@interface DTAlbumTool : NSObject

#pragma mark 判断权限

/**
*  @Author DT, 14-12-02 10:12:06
*
*  @brief  判断是否有相册访问权限
*
*  @return 是的话返回YES,反之返回NO
*/
+ (BOOL)albumsAuthorizationEnabled;

/**
 *  @Author DT, 14-12-01 13:12:37
 *
 *  @brief  判断是否有摄像头访问权限(IOS7新增方法)
 *
 *  @return 是的话返回YES,反之返回NO
 */
+ (BOOL)cameraAuthorizationEnabled;

#pragma mark 相册常用方法

/**
 *  @Author DT, 14-12-01 14:12:13
 *
 *  @brief 获取设备相册信息(默认相册)
 *
 *  @param block 回调函数,返回ALAssetsGroup对象,可以通过下面方法获取属性,如果没有相册访问权限的话不会执行block函数
 *  [group valueForProperty:ALAssetsGroupPropertyName] 获取相册名称
 *  [group posterImage] 获取相册的封面图片
 *  [group setAssetsFilter:[ALAssetsFilter allPhotos]] 对相册设置过滤,设置为只读取图片
 *  [group numberOfAssets] 获取相册中数据数量(默认是图片+视频)
 *  [group valueForProperty:ALAssetsGroupPropertyPersistentID] 获取相册的存储id
 *  [group valueForProperty:ALAssetsGroupPropertyURL] 获取相册的位置地址
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumInfo:(void(^)(ALAssetsGroup *group))block;

/**
 *  @Author DT, 14-12-01 16:12:08
 *
 *  @brief 获取设备相册第一张图片信息(默认相册)
 *
 *  @param block 回调函数,返回ALAsset对象,可以通过下面方法获取属性,如果没有相册访问权限的话不会执行block函数
 *  [asset thumbnail] 获取到相片、视频的缩略图
 *  [asset valueForProperty:ALAssetPropertyDate] 获取拍照时间
 *  [asset valueForProperty:ALAssetPropertyLocation] 获取拍照位置
 *  [asset aspectRatioThumbnail] 获取原始资源长宽比例的缩略图
 *  [[asset defaultRepresentation] metadata] 获取资源图片原数据
 *  [[asset defaultRepresentation] dimensions] 获取资源图片的长宽
 *  [[asset defaultRepresentation] fullResolutionImage] 获取资源图片的高清图
 *  [[asset defaultRepresentation] fullScreenImage] 获取资源图片的全屏图
 *  [[asset defaultRepresentation] filename] 获取资源图片的名字
 *  [[asset defaultRepresentation] scale] 获取资源图片缩放倍数
 *  [[asset defaultRepresentation] size] 获取资源图片容量大小
 *  [[asset defaultRepresentation] orientation] 获取资源图片旋转方向
 *  [[asset defaultRepresentation] url] 获取资资源图片url地址，该地址和ALAsset通过ALAssetPropertyAssetURL获取的url地址是一样的
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumFirstPhoto:(void(^)(ALAsset *asset))block;

/**
 *  @Author DT, 14-12-01 16:12:08
 *
 *  @brief 获取设备相册最后一张图片信息,最新图片信息(默认相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumLastPhoto:(void(^)(ALAsset *asset))block;

/**
 *  @Author DT, 14-12-01 16:12:08
 *
 *  @brief 获取设备相册图片或者视频信息(默认相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumAll:(void(^)(NSArray *assetArray))block;

/**
 *  @Author DT, 14-12-01 16:12:08
 *
 *  @brief 获取设备相册图片信息(默认相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumPhotos:(void(^)(NSArray *assetArray))block;

/**
 *  @Author DT, 14-12-01 16:12:08
 *
 *  @brief 获取设备相册视频信息(默认相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumVideos:(void(^)(NSArray *assetArray))block;

#pragma mark 相册扩展方法

/**
 *  @Author DT, 14-12-01 14:12:59
 *
 *  @brief 获取设备相册信息,只包含图片(可以有多个相册)
 *
 *  @param block 回调函数,返回ALAssetsGroup对象集合,参照getAlbumInfo方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumsInfo:(void(^)(NSArray *groupArray))block;

/**
 *  @Author DT, 14-12-01 14:12:59
 *
 *  @brief 获取设备相册图片或者视频信息(可以有多个相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumsAll:(void(^)(NSArray *assetArray))block;

/**
 *  @Author DT, 14-12-01 14:12:59
 *
 *  @brief 获取设备相册图片信息(可以有多个相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumsPhotos:(void(^)(NSArray *assetArray))block;

/**
 *  @Author DT, 14-12-01 14:12:59
 *
 *  @brief 获取设备相册图片视频信息(可以有多个相册)
 *
 *  @param block 回调函数,返回ALAsset对象,参照getAlbumFirstPhoto方法注释,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)getAlbumsVideos:(void(^)(NSArray *assetArray))block;

#pragma mark 添加方法

/**
 *  @Author DT, 14-12-02 11:12:41
 *
 *  @brief  创建一个相册
 *
 *  @param name  相册名称
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,参照getAlbumInfo方法注释来获取相应属性,group为nil的话表示相册名称重复,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)addAlbumGroupWithName:(NSString*)name block:(void(^)(ALAssetsGroup *group))block;

/**
 *  @Author DT, 14-12-02 13:12:26
 *
 *  @brief  根据一个相册名称获取相册的相应属性
 *
 *  @param name  相册名称
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,参照getAlbumInfo方法注释来获取相应属性,groupArray为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)albumGroupForName:(NSString *)name block:(void (^)(NSArray *groupArray))block;

/**
 *  @Author DT, 14-12-02 13:12:26
 *
 *  @brief  根据一个相册url地址获取相册的相应属性
 *
 *  @param url   url地址
 *  @param block 回调函数,返回创建相册后的ALAssetsGroup对象,参照getAlbumInfo方法注释来获取相应属性,group为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)albumGroupForURL:(NSURL*)url block:(void(^)(ALAssetsGroup *group))block;

/**
 *  @Author DT, 14-12-02 13:12:06
 *
 *  @brief  根据相册图片url地址获取图片的相应属性
 *
 *  @param url   url地址
 *  @param block 回调函数,返回相册图片的ALAsset对象,参照getAlbumFirstPhoto方法注释来获取相应属性,asset为nil的话表示地址错误,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)assetForURL:(NSURL*)url block:(void(^)(ALAsset *asset))block;

/**
 *  @Author DT, 14-12-02 14:12:26
 *
 *  @brief  往默认相册中写入数据
 *
 *  @param date  数据流(图片、gif...)
 *  @param block 回调函数,返回数据的url地址,url为nil的话表示写入不成功,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)writeImageDataToAlbum:(NSData*)date block:(void(^)(NSURL *url))block;

/**
 *  @Author DT, 14-12-02 15:12:09
 *
 *  @brief  往默认相册中写入图片
 *
 *  @param image 图片
 *  @param block 回调函数,返回数据的url地址,url为nil的话表示写入不成功,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)writeImageToAlbum:(UIImage*)image block:(void(^)(NSURL *url))block;

/**
 *  @Author DT, 14-12-03 08:12:42
 *
 *  @brief  往指定相册中写入数据
 *
 *  @param date     数据流(图片、gif...)
 *  @param albumUrl 相薄url地址
 *  @param block    回调函数,返回数据的url地址,url为nil的话表示写入不成功,如果没有相册访问权限的话不会执行block函数
 *
 *  @return 有相册访问权限的话返回YES,反之返回NO
 */
+ (BOOL)writeImageDataToAlbum:(NSData*)date albumUrl:(NSURL*)albumUrl block:(void(^)(NSURL *url))block;

@end
