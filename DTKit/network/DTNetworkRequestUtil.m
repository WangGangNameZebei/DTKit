//
//  DTNetworkRequestUtil.m
//  PharmaceuticalBar
//
//  Created by DT on 14-8-19.
//  Copyright (c) 2014年 DT. All rights reserved.
//
// ┏ ┓　　　┏ ┓
//┏┛ ┻━━━━━┛ ┻┓
//┃　　　　　　 ┃
//┃　　　━　　　┃
//┃　┳┛　  ┗┳　┃
//┃　　　　　　 ┃
//┃　　　┻　　　┃
//┃　　　　　　 ┃
//┗━┓　　　┏━━━┛
//  ┃　　　┃   DT专属
//  ┃　　　┃   神兽镇压
//  ┃　　　┃   代码无BUG！
//  ┃　　　┗━━━━━━━━━┓
//  ┃　　　　　　　    ┣┓
//  ┃　　　　         ┏┛
//  ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛
//    ┃ ┫ ┫   ┃ ┫ ┫
//    ┗━┻━┛   ┗━┻━┛
//

#import "DTNetworkRequestUtil.h"
#import "DTNetworkCache.h"

static DTNetworkRequestUtil * _engine = nil;

@implementation DTNetworkRequestUtil

#pragma mark - 通用方法

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
        self.timeoutInterval = 30;
        self.cachePolicy = CachePolicyNormal;
    }
    return self;
}

/**
 *  获取唯一标识符
 *
 *  @return
 */
+(NSString*)genuuid;
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

/**
 *  @Author DT, 14-11-14 16:11:32
 *
 *  md5加密
 *
 *  @param str 加密前字符串
 *
 *  @return 加密后字符串
 */
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 网络请求方法

-(NSString*)requestWithPath:(NSString*)path
                 parameters:(id)parameters
                    success:(requestSuccess)success
                    failure:(requestFailure)failure
{
    return [self requestPOSTWithPath:path parameters:parameters success:success failure:failure];
}

-(NSString*)requestWithPath:(NSString*)path
                 parameters:(id)parameters
                     method:(method)method
                    success:(requestSuccess)success
                    failure:(requestFailure)failure
{
    if (method == GET) {
        return [self requestGETWithPath:path parameters:parameters success:success failure:failure];
    }else{
        return [self requestPOSTWithPath:path parameters:parameters success:success failure:failure];
    }
}

/**
 *  网络请求POST方法
 *
 *  @param path           路径(带域名的路径)
 *  @param parameters     提交参数
 *  @param success        成功Block
 *  @param failure        失败Block
 *
 *  @return 一次网络操作的唯一序列号,用来取消网络请求
 */
-(NSString*)requestPOSTWithPath:(NSString*)path
                 parameters:(id)parameters
                    success:(requestSuccess)success
                    failure:(requestFailure)failure
{
    __block NSString *requestIdentifier = [[self class] genuuid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    
    NSString *cacheName = [self encryption:path dictionary:parameters];
    //缓存数据类型
    switch (self.cachePolicy) {
        case CachePolicyNormal:{
            [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self path:cacheName operation:operation responseObject:responseObject success:success];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self path:cacheName operation:operation error:error failure:failure];
            }];
            break;
        }case CachePolicyOnlyCache:{
            [self readLocalCache:cacheName success:success failure:failure];
            break;
        }case CachePolicyCacheElseWeb:{
            [self readLocalCache:cacheName success:success failure:^(DTNetworkResultResponse *response) {
                [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }case CachePolicyCacheAndRefresh:{
            [self readLocalCache:cacheName success:^(DTNetworkResultResponse *response) {
                success(response);
                [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:nil];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:nil];
                }];
            } failure:^(DTNetworkResultResponse *response) {
                [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }case CachePolicyCacheAndWeb:{
            [self readLocalCache:cacheName success:^(DTNetworkResultResponse *response) {
                success(response);
                [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            } failure:^(DTNetworkResultResponse *response) {
                [self method:POST path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }
    }
    return requestIdentifier;
}

/**
 *  网络请求GET方法
 *
 *  @param path           路径(带域名的路径)
 *  @param parameters     提交参数
 *  @param success        成功Block
 *  @param failure        失败Block
 *
 *  @return 一次网络操作的唯一序列号,用来取消网络请求
 */
-(NSString*)requestGETWithPath:(NSString*)path
                     parameters:(id)parameters
                        success:(requestSuccess)success
                        failure:(requestFailure)failure
{
    __block NSString *requestIdentifier = [[self class] genuuid];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    
    NSString *cacheName = [self encryption:path dictionary:parameters];
    //缓存数据类型
    switch (self.cachePolicy) {
        case CachePolicyNormal:{
            [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self path:cacheName operation:operation responseObject:responseObject success:success];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self path:cacheName operation:operation error:error failure:failure];
            }];
            break;
        }case CachePolicyOnlyCache:{
            [self readLocalCache:cacheName success:success failure:failure];
            break;
        }case CachePolicyCacheElseWeb:{
            [self readLocalCache:cacheName success:success failure:^(DTNetworkResultResponse *response) {
                [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }case CachePolicyCacheAndRefresh:{
            [self readLocalCache:cacheName success:^(DTNetworkResultResponse *response) {
                success(response);
                [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:nil];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:nil];
                }];
            } failure:^(DTNetworkResultResponse *response) {
                [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }case CachePolicyCacheAndWeb:{
            [self readLocalCache:cacheName success:^(DTNetworkResultResponse *response) {
                success(response);
                [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            } failure:^(DTNetworkResultResponse *response) {
                [self method:GET path:path parameters:parameters requestIdentifier:requestIdentifier AFHTTPRequestOperationManager:manager success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self path:cacheName operation:operation responseObject:responseObject success:success];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self path:cacheName operation:operation error:error failure:failure];
                }];
            }];
            break;
        }
    }
    return requestIdentifier;
}

#pragma mark - 数据封装方法

/*!
 *  @Author DT
 *
 *  @brief  请求加密
 *
 *  @param path       请求url
 *  @param dictionary 请求参数
 *
 *  @return md5加密后的字符串
 */
-(NSString*)encryption:(NSString*)path dictionary:(NSDictionary*)dictionary
{
    
    NSString *string = @"";
    if (dictionary) {
        for(id key in [dictionary allKeys]){
            id obj=[dictionary objectForKey:key];
            NSString *value = [NSString stringWithFormat:@"%@=%@",key,obj];
            if ([string isEqualToString:@""]) {
                string = value;
            }else{
                string = [NSString stringWithFormat:@"%@&%@",string,value];
            }
        }
        string = [NSString stringWithFormat:@"%@?%@",path,string];
    }else{
        string = path;
    }
    return [self md5:string];
}

/*!
 *  @Author DT
 *
 *  @brief  读取本地缓存数据
 *
 *  @param cacheName    缓存文件名
 *  @param success 成功的回调函数
 *  @param failure 失败的回调函数
 *
 */
-(void)readLocalCache:(NSString*)cacheName
                       success:(requestSuccess)success
                       failure:(requestFailure)failure
{
    NSDictionary *dictionary = [[DTNetworkCache shareInstance] readLocalCache:cacheName];
    DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
    response.dictionary = dictionary;
    if (dictionary) {
        response.cacheUrl = [[DTNetworkCache shareInstance] getLocalCachePath:cacheName];
        success(response);
    }else{
        failure(response);
    }
}

/*!
 *  @Author DT
 *
 *  @brief  网络请求成功的数据封装
 *
 *  @param cacheName      缓存文件名
 *  @param operation      请求对象
 *  @param responseObject 返回数据
 *  @param success        回调函数
 */
-(void)path:(NSString*)cacheName
  operation:(AFHTTPRequestOperation *)operation
responseObject:(id)responseObject
    success:(requestSuccess)success
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
        //保存缓存数据
        NSString *cacheUrl = [[DTNetworkCache shareInstance] saveLocalCache:cacheName json:dictionary];
        DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
        response.url = [operation.request.URL absoluteString];
        response.cacheUrl = cacheUrl;
        response.dictionary = dictionary;
        if (success) {
            success(response);
        }
    }
}

/*!
 *  @Author DT
 *
 *  @brief  网络请求失败的数据封装
 *
 *  @param cacheName 缓存文件名
 *  @param operation 请求对象
 *  @param error     请求失败的对象
 *  @param failure   回调函数
 */
-(void)path:(NSString*)cacheName
  operation:(AFHTTPRequestOperation *)operation
      error:(NSError *)error
    failure:(requestFailure)failure
{
    //读取缓存数据
    NSDictionary *dictionary = [[DTNetworkCache shareInstance] readLocalCache:cacheName];
    DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
    response.url = [operation.request.URL absoluteString];
    response.cacheUrl = [[DTNetworkCache shareInstance] getLocalCachePath:cacheName];
    response.dictionary = dictionary;
    if (failure) {
        failure(response);
    }
}

/*!
 *  @Author DT
 *
 *  @brief  网络请求方法,返回原始数据
 *
 *  @param method            请求方式 GET or POST
 *  @param path              请求路径
 *  @param parameters        请求参数
 *  @param requestIdentifier 唯一标识符
 *  @param manager           AFHTTPRequestOperationManager对象
 *  @param success           请求成功返回函数
 *  @param failure           请求失败返回函数
 */
- (void)method:(method)method
          path:(NSString*)path
    parameters:(id)parameters
requestIdentifier:(NSString*)requestIdentifier
AFHTTPRequestOperationManager:(AFHTTPRequestOperationManager*)manager
       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (method ==GET) {
        AFHTTPRequestOperation *requestOperation = [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(operation,responseObject);
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(operation,error);
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }];
        if (requestOperation) {
            [[[DTNetworkRequestUtil shareInstance] operations] setObject:requestOperation forKey:requestIdentifier];
        }else{
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }
    }else if (method ==POST){
        AFHTTPRequestOperation *requestOperation = [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(operation,responseObject);
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(operation,error);
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }];
        if (requestOperation) {
            [[[DTNetworkRequestUtil shareInstance] operations] setObject:requestOperation forKey:requestIdentifier];
        }else{
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }
    }
}

-(void)cancelRequests:(NSArray*)identifiers canceled:(requestSuccess)canceled
{
    for (NSString *identifier in identifiers) {
        AFHTTPRequestOperation *requestOperation = [[[DTNetworkRequestUtil shareInstance] operations] objectForKey:identifier];
        requestOperation.completionBlock = nil;
        [requestOperation cancel];
        [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:identifier];
    }
    if (canceled) {
        DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
        canceled(response);
    }
}

-(void)cancelRequest:(NSString*)identifier canceled:(requestSuccess)canceled
{
    AFHTTPRequestOperation *requestOperation = [[[DTNetworkRequestUtil shareInstance] operations] objectForKey:identifier];
    requestOperation.completionBlock = nil;
    [requestOperation cancel];
    [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:identifier];
    
    if (canceled) {
        DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
        canceled(response);
    }
}

@end
