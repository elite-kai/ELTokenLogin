//
//  ELQQLogin.h
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^QQBlock)(id response);

@class SendAuthResp;

@interface ELQQLogin : NSObject<TencentSessionDelegate>
{
    TencentOAuth *tencentOAuth;
    NSArray *permissions;
    NSMutableDictionary *qqUserInfos;
}

+ (ELQQLogin *)shareInstance;

@property (nonatomic, copy) QQBlock qqBlock;

/**
 调起QQ客户端

 @param qqBlock 传递QQ用户信息
 */
- (void)tuneQQLogin:(QQBlock)qqBlock;

@end
