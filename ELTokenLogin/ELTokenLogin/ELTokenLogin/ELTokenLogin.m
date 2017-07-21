//
//  ELTokenLogin.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELTokenLogin.h"
#import "ELQQLogin.h"
#import "ELWCLogin.h"
#import "ELWBLogin.h"

@interface ELTokenLogin ()<WeiboSDKDelegate, WXApiDelegate>

@end

@implementation ELTokenLogin

+ (ELTokenLogin *)shareInstance
{
    static ELTokenLogin *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ELTokenLogin alloc] init];
    });
    
    return instance;
}


+ (void)loginGetInfo:(NSInteger)platform userInfo:(void(^)(id response))block
{

    if (platform == ELWeChat)
    {
        [[ELWCLogin shareInstance] tuneWCLogin:^(id response) {
            block(response);
        }];
        
    }
    else if (platform == ELTencent)
    {
        [[ELQQLogin shareInstance] tuneQQLogin:^(id response) {
            block(response);
        }];
    }
    else if (platform == ELWeiBo)
    {
        [[ELWBLogin shareInstance] tuneWBLogin:^(id response) {
            block(response);
        }];
    }
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    if ([[NSString stringWithFormat:@"%@", url] hasPrefix:[NSString stringWithFormat:@"%@://oauth", ELWCAppid]]) {
    return  [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([[NSString stringWithFormat:@"%@", url] hasPrefix:[NSString stringWithFormat:@"tencent%@://qzapp/mqzone", ELQQAppid]]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    if ([[NSString stringWithFormat:@"%@", url] hasPrefix:[NSString stringWithFormat:@"wb%@://response", ELWBAppid]]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    return YES;
}

#pragma mark - 微信
-(void)onResp:(BaseResp*)resp
{

    if ([resp isMemberOfClass:[SendAuthResp class]]) {
        SendAuthResp *sendAuth = (SendAuthResp *)resp;
        //        NSLog(@"resp.code  %@", sendAuth.code);
        [[ELWCLogin shareInstance] getWCLoginInfo:sendAuth];
        
    }
}

//新浪微博
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

//新浪微博获取用户信息回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            if ([ELWBLogin shareInstance].wbBlock != nil) {
                [ELWBLogin shareInstance].wbBlock(response.userInfo);
            }
        }
    }
}



@end
