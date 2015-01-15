//
//  DTNetworkCache.h
//  GameCenterDemo
//
//  Created by DT on 14-11-14.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @Author DT, 14-11-14 11:11:18
 *
 *  @brief 网络请求缓存类
 */
@interface DTNetworkCache : NSObject

/**
 *  @Author DT, 14-11-14 15:11:07
 *
 *  @brief 缓存文件夹路径
 */
@property(nonatomic,copy,readonly)NSString *cachesDirPath;
/**
 *  @Author DT, 14-11-14 15:11:20
 *
 *  @brief 缓存文件集合
 */
@property(nonatomic,strong,readonly)NSMutableArray *cachesPaths;

/**
 *  @brief 初始化方法
 *
 *  @return 返回DTNetworkCache对象
 */
+(DTNetworkCache*)shareInstance;

/**
 *  @Author DT, 14-11-14 14:11:17
 *
 *  @brief 创建缓存文件夹
 */
-(void)createLocalCacheDir;

/**
 *  @Author DT, 14-11-14 14:11:02
 *
 *  @brief 删除缓存文件夹(清理缓存)
 */
-(void)deleteLocalCacheDir;

/**
 *  @Author DT, 14-11-14 15:11:08
 *
 *  @brief 检查本地缓存大小
 *
 *  @return 返回float,单位K
 */
- (float)checkLocalCacheSize;

/**
 *  @Author DT, 14-11-14 14:11:14
 *
 *  @brief 保存缓存数据
 *
 *  @param fileName 缓存文件名
 *  @param json     缓存文件内容,NSDictionary类型
 *
 *  @return 缓存文件路径
 */
-(NSString*)saveLocalCache:(NSString*)fileName json:(NSDictionary*)json;

/**
 *  @Author DT, 14-11-14 14:11:03
 *
 *  @brief 读取缓存数据
 *
 *  @param path 缓存文件路径
 *
 *  @return 缓存文件内容
 */
-(NSDictionary*)readLocalCache:(NSString*)path;

@end
