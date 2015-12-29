//
//  SSKeyViewController.m
//  SSKeyChainSample
//
//  Created by 黄嘉宏 on 15/12/28.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "SSKeyViewController.h"

#import "SSKeychain.h"

@interface SSKeyViewController ()

@end

@implementation SSKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *userAcountButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2 - 60, 100, 120, 50)];
    
    [userAcountButton setTitle:@"设置用户信息" forState:UIControlStateNormal];
    
    [userAcountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [userAcountButton addTarget:self action:@selector(setUserAcount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:userAcountButton];
    
    
    UIButton *getUserAcountButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2 - 60, 180, 120, 50)];
    
    [getUserAcountButton setTitle:@"获取用户信息" forState:UIControlStateNormal];
    
    [getUserAcountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [getUserAcountButton addTarget:self action:@selector(getUserAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:getUserAcountButton];
    // Do any additional setup after loading the view, typically from a nib.
}

//设置用户和密码
- (IBAction)setUserAcount:(id)sender {
    BOOL isSave = [SSKeychain setPassword:@"hello" forService:@"www.baidu2.com" account:@"world2"];
    
    NSLog(@"%d",isSave);
}

- (IBAction)getUserAccount:(id)sender {
    
    NSArray *array = [SSKeychain accountsForService:@"www.baidu2.com"];
    
    NSLog(@"%@",array);
    
    //如果获取失败，可以用以下方法获取错误信息
    NSError *error = nil;
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = @"www.baidu2.com";
    query.account = @"world2";
    [query fetch:&error];
    
    if ([error code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    }
    else{
        NSLog(@"获取成功");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
