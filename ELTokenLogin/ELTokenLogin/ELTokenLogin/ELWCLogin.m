//
//  ELWCLogin.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELWCLogin.h"



@implementation ELWCLogin

+ (ELWCLogin *)shareInstance
{
    static ELWCLogin *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ELWCLogin alloc] init];
    });
    return instance;
}

- (void)tuneWCLogin:(WCBlock)wcBlock
{
    
    NSInteger random = (arc4random() % (int)pow(10, 10)) + (int)pow(10, 10);
    SendAuthReq* req = [[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = [NSString stringWithFormat:@"%ld", (long)random];
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
    
    self.wcBlock = wcBlock;
}

- (void)getWCLoginInfo:(SendAuthResp *)sendAuth
{
    NSDictionary *params = @{@"appid" : ELWCAppid,
                             @"secret" : ELWCAppSecret,
                             @"code" : sendAuth.code,
                             @"grant_type" : @"authorization_code"};
    NSString *url = [NSString stringWithFormat:@"%@%@", ELWeChatURL, ELWCAccessToken];
    //通过code获取到access_token和refresh_token
    [ELNetwork postWithUrl:url params:params success:^(id response) {
        
        NSDictionary *tokenContent = response;
        NSDictionary *params = @{@"access_token" : response[@"access_token"],
                                   @"openid" : response[@"openid"]};
        NSString *url = [NSString stringWithFormat:@"%@%@", ELWeChatURL, ELWCUserInfo];
        
        [ELNetwork postWithUrl:url params:params success:^(id response) {
            
            //用字典创建字典
            NSMutableDictionary *userInfoContent = [NSMutableDictionary dictionaryWithDictionary:response];
            [userInfoContent setValue:tokenContent forKey:@"tokenContent"];
            
            if (self.wcBlock != nil) {
                self.wcBlock(userInfoContent);
            }
            
        } fail:^(NSError *error) {
            
        }];

        
    } fail:^(NSError *error) {
        
    }];
}

- (void)tokenFromRefreshToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *refreshToken = [defaults valueForKey:@"refreshToken"];
    
    NSDictionary *params = @{@"appid" : ELWCAppid,
                             @"grant_type" : @"refresh_token",
                             @"refresh_token" : refreshToken};
    NSString *url = [NSString stringWithFormat:@"%@%@", ELWeChatURL, ELWCRefreshToken];
    //通过code获取到access_token和refresh_token
    [ELNetwork postWithUrl:url params:params success:^(id response) {
        ELLog(@"response ---  %@", response)
        
        
    } fail:^(NSError *error) {
        
    }];

}

@end
