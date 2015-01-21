//
//  NetworkRequestUtil.h
//  PharmaceuticalBar
//
//  Created by DT on 14-8-19.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DTNetworkResultResponse.h"

typedef void (^requestSuccess) (DTNetworkResultResponse* response);

typedef void (^requestFailure) (DTNetworkResultResponse* response);

typedef enum {
    POST,
    GET,
}method;//请求方法

/*!
 网络缓存类型
 @constant CachePolicyNormal
 基本请求,有网络的话请求网络数据,没有网络的话请求缓存数据
 @constant CachePolicyOnlyCache
 只取本地的数据,如果本地缓存数据为空也不访问网络
 @constant CachePolicyCacheElseWeb
 查看本地是否有缓存,如果有就使用,没有的话就请求网络数据
 @constant CachePolicyCacheAndRefresh
 如果本地有数据,网络获取不回调,如果本地没有数据,网络获取会回调
 @constant CachePolicyCacheAndWeb
 本地获取一次，网络获取一次，都会回调。
 注意：这种情况非常少见，只有调用网页的时候可能会用得到。
 */
typedef enum {
    CachePolicyNormal,
    CachePolicyOnlyCache,
    CachePolicyCacheElseWeb,
    CachePolicyCacheAndRefresh,
    CachePolicyCacheAndWeb
}CachePolicy;

/**
 *  网络请求类
 */
@interface DTNetworkRequestUtil : NSObject
/** 网络操作集合 */
@property (nonatomic,strong) NSMutableDictionary *operations;

/** 超时时间间隔，以秒为单位创建的请求。默认的超时时间间隔为30秒。 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/** 网络缓存类型,如需使用缓存功能得先调用[[DTNetworkCache shareInstance] createSharedCache]方法,默认类型为CachePolicyNormal */
@property (nonatomic, assign) CachePolicy cachePolicy;

/**
 *  初始化方法
 *
 *  @return 返回NetworkRequestUtil对象
 */
+(DTNetworkRequestUtil*)shareInstance;


/**
 *  网络请求,默认POST方法
 *
 *  @param path           路径(带域名的路径)
 *  @param parameters     请求参数
 *  @param success        成功Block
 *  @param failure        失败Block
 *
 *  @return 一次网络操作的唯一序列号,用来取消网络请求
 */
-(NSString*)requestWithPath:(NSString*)path
                 parameters:(id)parameters
                    success:(requestSuccess)success
                    failure:(requestFailure)failure;

/**
 *  请求网络
 *
 *  @param path           路径(带域名的路径)
 *  @param parameters     请求参数
 *  @param method         POST/GET
 *  @param useAccessTicke 带有票据
 *  @param success        成功Block
 *  @param failure        失败Block (如果服务器有错误信息,包括密码错误之类的也在这里返回)
 *
 *  @return 一次网络操作的唯一序列号,用来取消网络请求
 */
-(NSString*)requestWithPath:(NSString*)path
                 parameters:(id)parameters
                     method:(method)method
                    success:(requestSuccess)success
                    failure:(requestFailure)failure;

/**
 *  批量取消网络请求
 *
 *  @param identifiers 网络操作的唯一序列号集合
 *  @param canceled    取消Block
 */
-(void)cancelRequests:(NSArray*)identifiers canceled:(requestSuccess)canceled;

/**
 *  取消一个网络请求
 *
 *  @param identifier 网络操作的唯一序列号
 *  @param canceled   取消Block
 */
-(void)cancelRequest:(NSString*)identifier canceled:(requestSuccess)canceled;

@end
