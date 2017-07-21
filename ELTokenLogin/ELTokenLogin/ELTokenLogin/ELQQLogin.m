//
//  ELQQLogin.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELQQLogin.h"

@implementation ELQQLogin

+ (ELQQLogin *)shareInstance
{
    static ELQQLogin *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ELQQLogin alloc] init];
    });
    return instance;
}


- (void)tuneQQLogin:(QQBlock)qqBlock
{
    qqUserInfos = [NSMutableDictionary dictionary];
    //3,初始化TencentOAuth 对象 appid来自应用宝创建的应用， deletegate设置为self  一定记得实现代理方法
    
    //这里的appid填写应用宝得到的id  记得修改 “TARGETS”一栏，在“info”标签栏的“URL type”添加 的“URL scheme”，新的scheme。有问题家QQ群414319235提问
    tencentOAuth =[[TencentOAuth alloc] initWithAppId:ELQQAppid andDelegate:self];
    
    //4，设置需要的权限列表，此处尽量使用什么取什么。
    permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    
    [tencentOAuth authorize:permissions inSafari:NO];
    self.qqBlock = qqBlock;
}

// TencentSessionDelegate
- (void)tencentDidLogin
{
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        NSDictionary *tokenInfo = tencentOAuth.mj_keyValues;
        //        NSLog(@"tencentOAuth---------> %@", tokenInfo);
        [qqUserInfos setValue:tokenInfo forKey:@"tokenInfo"];
        [tencentOAuth getUserInfo];
    }
    else
    {
        NSLog(@"登录失败");
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        NSLog(@"取消登录");
    }else{
        NSLog(@"登录失败");
    }
}

// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    [qqUserInfos setValue:response.jsonResponse forKey:@"qqUserInfo"];
    if (self.qqBlock != nil) {
        self.qqBlock(qqUserInfos);
    }
    //    NSLog(@"respons:%@",response.jsonResponse);
}



@end
