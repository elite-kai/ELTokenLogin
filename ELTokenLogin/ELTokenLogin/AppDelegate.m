//
//  AppDelegate.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "AppDelegate.h"
#import "ELTokenLogin.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [WXApi registerApp:ELWCAppid];
    [WeiboSDK registerApp:ELWBAppid];
    
    return YES;
}


//iOS9 之后使用这个回调方法。
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    return [[ELTokenLogin shareInstance] handleOpenURL:url];
}

//看到每个开放平台都写了这个方法，但是通过回调发现，不会走这个方法，不知道什么原因，所以没办法分辨是哪个平台的回调
#pragma mark -
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return  YES;
}


/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[ELTokenLogin shareInstance] handleOpenURL:url];
}

@end
