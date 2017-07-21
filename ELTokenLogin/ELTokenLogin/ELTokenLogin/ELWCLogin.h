//
//  ELWCLogin.h
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^WCBlock)(id response);

@interface ELWCLogin : NSObject

+ (ELWCLogin *)shareInstance;

@property (nonatomic, copy) WCBlock wcBlock;

/**
 调起微信客户端

 @param wcBlock 传递用户信息
 */
- (void)tuneWCLogin:(WCBlock)wcBlock;


/**
 获取微信用户信息

 @param sendAuth sendAuth
 */
- (void)getWCLoginInfo:(SendAuthResp *)sendAuth;

/**
 用refreshToken获取accessToken
 */
- (void)tokenFromRefreshToken;

@end
