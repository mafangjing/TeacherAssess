//
//  ShareViewController.m
//  ShareSDKTextDemo
//
//  Created by 黄嘉宏 on 15/9/24.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "ShareViewController.h"

#import <ShareSDK/ShareSDK.h>

#import <Parse/Parse.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *userAcountButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2 - 60, 100, 120, 50)];
    
    [userAcountButton setTitle:@"分享" forState:UIControlStateNormal];
    
    [userAcountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [userAcountButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:userAcountButton];
    
    
    UIButton *getUserAcountButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2 - 60, 180, 120, 50)];
    
    [getUserAcountButton setTitle:@"第三方登陆" forState:UIControlStateNormal];
    
    [getUserAcountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [getUserAcountButton addTarget:self action:@selector(dengluButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:getUserAcountButton];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)dengluButtonClcik:(id)sender {
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        
        if (result)
        {
            PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
            [query whereKey:@"uid" equalTo:[userInfo uid]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                if ([objects count] == 0)
                {
                    PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                    [newUser setObject:[userInfo uid] forKey:@"uid"];
                    [newUser setObject:[userInfo nickname] forKey:@"name"];
                    [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                    [newUser saveInBackground];
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                    [alertView show];
                    
                }
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎回来" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                    [alertView show];
                    
                    
                }
            }];
        }
    }];
}



- (IBAction)shareButtonClick:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"jpg"];
    
    //1、构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"要分享的内容"
                                       defaultContent:@"默认内容"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条演示信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //1+创建弹出菜单容器（iPad必要）
    id<ISSContainer> container = [ShareSDK container];
    
    //2、弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                    message:nil
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                    message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                            }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
