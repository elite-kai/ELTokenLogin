//
//  ELWBLogin.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELWBLogin.h"


@implementation ELWBLogin

+ (ELWBLogin *)shareInstance
{
    static ELWBLogin *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ELWBLogin alloc] init];
    });
    return instance;
}

#pragma mark - 微博
//调起微博
- (void)tuneWBLogin:(WBBlock)wbBlock
{
    //scope 文档地址 http://open.weibo.com/wiki/Scope
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = ELWBRedirectURL;
    request.scope = @"all";
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
    
    self.wbBlock = wbBlock;
}


- (void)tokenFromRefreshToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *refreshToken = [defaults valueForKey:@"refreshToken"];
    NSDictionary *params = @{@"client_id" : ELWBAppid,
                            @"client_secret" : ELWBAppSecret,
                            @"grant_type" : @"refresh_token",
                            @"redirect_uri" : ELWBRedirectURL,
                            @"refresh_token" : refreshToken};
    NSString *url = [NSString stringWithFormat:@"%@%@", ELWBUrl, ELWBRefreshToken];
    [ELNetwork postWithUrl:url params:params success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
}

@end
