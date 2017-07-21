//
//  ELTokenLogin.h
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ELPlatform){
    ELWeChat,    //微信登录
    ELTencent,   //qq登录
    ELWeiBo       //新浪微博
};

@interface ELTokenLogin : NSObject

+ (ELTokenLogin *)shareInstance;

+ (void)loginGetInfo:(NSInteger)platform userInfo:(void(^)(id response))block;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
