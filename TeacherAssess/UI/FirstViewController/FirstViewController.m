//
//  FirstViewController.m
//  Wedding
//
//  Created by qianfeng on 15-12-21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

-(void)viewWillAppear:(BOOL)animated{
    //设置导航栏
    [self headView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.tabBarController.navigationItem.title = @"精选";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
