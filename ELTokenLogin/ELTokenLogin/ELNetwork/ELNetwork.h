//
//  ELNetwork.h
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}ELNetworkStatus;

typedef void( ^ ELResponseSuccess)(id response);
typedef void( ^ ELResponseFail)(NSError *error);

typedef NSURLSessionTask ELURLSessionTask;

@interface ELNetwork : NSObject

/**
 单利

 @return ELNetwork
 */
+ (ELNetwork *)shareInstance;


/**
 获取网络
 */
@property (nonatomic, assign) ELNetworkStatus networkStats;


/**
   开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
+(void)getWithUrl:(NSString *)url
           params:(NSDictionary *)params
          success:(ELResponseSuccess)success
             fail:(ELResponseFail)fail;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
+(void)postWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ELResponseSuccess)success
              fail:(ELResponseFail)fail;


@end
