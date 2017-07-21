//
//  ELWBLogin.h
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WBBlock)(id response);

@interface ELWBLogin : NSObject

+ (ELWBLogin *)shareInstance;

@property (nonatomic, copy) WBBlock wbBlock;

/**
 调起微博客户端

 @param wbBlock 传递微博用户信息
 */
- (void)tuneWBLogin:(WBBlock)wbBlock;

/**
 用refreshToken获取accessToken
 */
- (void)tokenFromRefreshToken;

@end
