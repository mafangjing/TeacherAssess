//
//  LocalizableViewController.m
//  LocalizableSmaple
//
//  Created by 黄嘉宏 on 15/12/25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "LocalizableViewController.h"

@interface LocalizableViewController ()

@end

@implementation LocalizableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //输出label的值
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(10, 100, 100, 40);
    
    NSString *strPlay = NSLocalizedString(@"play", @"");
    
    label.text = strPlay;
    
    [self.view addSubview:label];
    
    //获取系统语言
    // 取得用户默认信息
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults];
    
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages"];
    NSLog (@"%@",languages);
    
    // 获得当前iPhone使用的语言
    NSString* currentLanguage = [languages objectAtIndex:0];
    NSLog(@"当前使用的语言：%@",currentLanguage);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
