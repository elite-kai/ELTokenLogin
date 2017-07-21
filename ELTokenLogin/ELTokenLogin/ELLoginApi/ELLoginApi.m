//
//  ELLoginApi.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELLoginApi.h"

NSString *const ELWBRedirectURL = @"http://sns.whalecloud.com/sina2/callback";

//微信Api
NSString *const ELWeChatURL = @"https://api.weixin.qq.com/sns/";
//通过code获取access_token
NSString *const ELWCAccessToken = @"oauth2/access_token";
//获取第一步的code后，请求以下链接进行refresh_token
NSString *const ELWCRefreshToken = @"oauth2/refresh_token";
//获取用户个人信息
NSString *const ELWCUserInfo =  @"userinfo";

//QQApi
NSString *const ELQQURL = @"http://openapi.tencentyun.com/";
//获取用户基本资料
NSString *const ELQQUserGetInfo = @"v3/user/get_info";

//微博Api
NSString *const ELWBUrl = @"https://api.weibo.com/";
//获取微博用户资料
NSString *const ELWBUserShow = @"2/users/show.json";
NSString *const ELWBRefreshToken = @"oauth2/access_token";

//大家需要把这些信息换成自己从开放平台中申请下来的信息
NSString *const ELWCAppid = @"";
NSString *const ELWCAppSecret = @"";
NSString *const ELQQAppid = @"";
NSString *const ELQQAppSecret = @"";
NSString *const ELWBAppid = @"";
NSString *const ELWBAppSecret = @"";

