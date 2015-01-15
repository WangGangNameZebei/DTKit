//
//  DTNetworkResultResponse.h
//  PharmaceuticalBar
//
//  Created by DT on 14-8-19.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求结果类
 */
@interface DTNetworkResultResponse : NSObject

/**
 *  网络请求url
 */
@property(nonatomic,strong)NSString *url;

/**
 *  缓存url
 */
@property(nonatomic,strong)NSString *cacheUrl;

/**
 *  网络请求失败的错误提示类
 */
@property(nonatomic,strong)NSError *error;

/**
 *  服务器返回的json数据
 */
@property(nonatomic,strong)NSDictionary *dictionary;

/**
 *  返回的具体对象(多条数据)
 */
@property(nonatomic,strong)NSMutableArray *objects;

/**
 *  返回的具体对象(一条数据)
 */
@property(nonatomic,strong)id object;


@end
