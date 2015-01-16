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
        self.timeoutInterval = 60;
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    AFHTTPRequestOperation *requestOperation = [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
            //缓存数据
            NSString *cacheUrl = [[DTNetworkCache shareInstance] saveLocalCache:[self md5:[operation.request.URL absoluteString]] json:dictionary];
            DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
            response.url = [operation.request.URL absoluteString];
            response.cacheUrl = cacheUrl;
            response.dictionary = dictionary;
            if (success) {
                success(response);
            }
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //读取缓存数据
        NSDictionary *dictionary = [[DTNetworkCache shareInstance] readLocalCache:[self md5:[operation.request.URL absoluteString]]];
        DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
        response.url = [operation.request.URL absoluteString];
        response.dictionary = dictionary;
        response.error = error;
        if (failure) {
            failure(response);
        }
        [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
    }];
    if (requestOperation) {
        [[[DTNetworkRequestUtil shareInstance] operations] setObject:requestOperation forKey:requestIdentifier];
    }else{
        [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = self.timeoutInterval;
    AFHTTPRequestOperation *requestOperation = [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
            //缓存数据
            NSString *cacheUrl = [[DTNetworkCache shareInstance] saveLocalCache:[self md5:[operation.request.URL absoluteString]] json:dictionary];
            DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
            response.url = [operation.request.URL absoluteString];
            response.cacheUrl = cacheUrl;
            response.dictionary = dictionary;
            if (success) {
                success(response);
            }
            [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //读取缓存数据
        NSDictionary *dictionary = [[DTNetworkCache shareInstance] readLocalCache:[self md5:[operation.request.URL absoluteString]]];
        DTNetworkResultResponse *response = [[DTNetworkResultResponse alloc] init];
        response.url = [operation.request.URL absoluteString];
        response.dictionary = dictionary;
        if (failure) {
            failure(response);
        }
        [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
    }];
    if (requestOperation) {
        [[[DTNetworkRequestUtil shareInstance] operations] setObject:requestOperation forKey:requestIdentifier];
    }else{
        [[[DTNetworkRequestUtil shareInstance] operations] removeObjectForKey:requestIdentifier];
    }
    return requestIdentifier;
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
