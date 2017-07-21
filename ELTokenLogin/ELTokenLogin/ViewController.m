//
//  ViewController.m
//  ELTokenLogin
//
//  Created by Parkin on 2017/7/20.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ViewController.h"

#import "ELTokenLogin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *weixin = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 100, 60)];
    weixin.backgroundColor = [UIColor redColor];
    weixin.titleLabel.text = @"weixin";
    [weixin addTarget:self action:@selector(weixin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixin];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *qq = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 60)];
    qq.backgroundColor = [UIColor redColor];
    qq.titleLabel.text = @"qq";
    [qq addTarget:self action:@selector(qq) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qq];
    
    UIButton *sina = [[UIButton alloc] initWithFrame:CGRectMake(100, 240, 100, 60)];
    sina.backgroundColor = [UIColor redColor];
    sina.titleLabel.text = @"sina";
    [sina addTarget:self action:@selector(sina) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sina];
    


}

- (void)weixin
{
    [ELTokenLogin loginGetInfo:ELWeChat userInfo:^(id response) {
        ELLog(@"微信  %@", response);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:response[@"tokenContent"][@"refresh_token"] forKey:@"refreshToken"];
        [defaults synchronize];
    }];
}

- (void)qq
{
    
    [ELTokenLogin loginGetInfo:ELTencent userInfo:^(id response) {
        ELLog(@"QQ  %@", response);
    }];
    
}

- (void)sina
{
    
    [ELTokenLogin loginGetInfo:ELWeiBo userInfo:^(id response) {
        ELLog(@"新浪  %@", response);
        NSDictionary *params = @{@"access_token" : response[@"access_token"],
                                   @"uid" : response[@"uid"]};
        NSString *url = [NSString stringWithFormat:@"%@%@", ELWBUrl, ELWBUserShow];
        [ELNetwork getWithUrl:url params:params success:^(id response) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:response[@"refresh_token"] forKey:@"refreshToken"];
            [defaults synchronize];
            
        } fail:^(NSError *error) {
            
        }];
        
    }];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
