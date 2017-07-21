//
//  ELNetwork.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELNetwork.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#ifdef DEBUG
#   define ELLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define ELLog(...)
#endif

@implementation ELNetwork

+ (ELNetwork *)shareInstance
{
    static ELNetwork *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ELNetwork alloc] init];
    });
    return instance;
}

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ELResponseSuccess)success
              fail:(ELResponseFail)fail{
    
    [self baseRequestType:1 url:url params:params success:success fail:fail];
    
}

+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(ELResponseSuccess)success
               fail:(ELResponseFail)fail{
    [self baseRequestType:2 url:url params:params success:success fail:fail];
}

+(void)baseRequestType:(NSUInteger)type
                   url:(NSString *)url
                params:(NSDictionary *)params
               success:(ELResponseSuccess)success
                  fail:(ELResponseFail)fail{
    //    ELLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return;
    }

    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    ELURLSessionTask *sessionTask=nil;
    
    if (type==1) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            ELLog(@"请求结果=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            ELLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }

        }];
        
    }else{
        
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            ELLog(@"请求成功=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            ELLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }

        }];
        
    }
    
}

+(AFHTTPSessionManager *)getAFManager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    
    return manager;
    
}


#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                ELLog(@"未知网络");
                [ELNetwork shareInstance].networkStats=StatusUnknown;
                
                break;
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                ELLog(@"没有网络");
                [ELNetwork shareInstance].networkStats=StatusNotReachable;
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                ELLog(@"手机自带网络");
                [ELNetwork shareInstance].networkStats=StatusReachableViaWWAN;
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [ELNetwork shareInstance].networkStats=StatusReachableViaWiFi;
                ELLog(@"WIFI--%d",[ELNetwork shareInstance].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}


+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



@end
