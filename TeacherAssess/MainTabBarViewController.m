//
//  MainTabBarViewController.m
//  Wedding
//
//  Created by hjh on 15-10-2.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"
#import "FiveViewController.h"
@interface MainTabBarViewController ()

@property(nonatomic,strong)UISegmentedControl * segment;

@property(nonatomic,strong)UIButton *currentSecletedButton;

@property(nonatomic,strong)NSArray *barButtonImageViewArray;

@property(nonatomic,strong)NSArray *barButtonSecletedImageViewArray;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildVC];


    [self setButtons];
}


-(void)addChildVC{
    //把创建好的vc加载到tabBarController上面
    
    FirstViewController *FirstVC = [[FirstViewController alloc]init];
    
    SecondViewController *SecondVC = [[SecondViewController alloc]init];
    
    ThirdViewController *ThirdVC = [[ThirdViewController alloc]init];
    
    FouthViewController *FouthVC = [[FouthViewController alloc]init];
    FiveViewController * FiveVC = [[FiveViewController alloc]init];
    
    self.viewControllers = @[FirstVC,SecondVC,ThirdVC,FouthVC,FiveVC];
    
//    self.tabBar.barTintColor = [UIColor colorWithRed:114/256.0 green:113/256.0 blue:113/256.0 alpha:1];
}






-(void)setButtons{

    //设置title的数组
    NSArray *barButtonTitleArray = @[@"精选",@"发现",@"结婚圈",@"商铺",@"我的"];
    
    //设置没选中图片数组
    self.barButtonImageViewArray = @[@"btn_tab_best_n.png",@"btn_tab_found_n.png",@"btn_tab_bbs_n.png",@"btn_tab_prepare_n.png",@"btn_tab_mine_n.png"];
    
    self.barButtonSecletedImageViewArray = @[@"btn_tab_best_s.png",@"btn_tab_found_s.png",@"btn_tab_bbs_s.png",@"btn_tab_prepare_s.png",@"btn_tab_mine_s.png"];
    
    
    //计算出每个button的宽度
    float buttonWidth = self.view.frame.size.width/5.0;
    
    NSLog(@"%f",buttonWidth);
    
    for (int i = 0; i < barButtonTitleArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 49);
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:self.barButtonImageViewArray[i]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(barButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 100 + i;
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
        
        [self.tabBar addSubview:button];
        
        //创建一个button中的文本显示
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, buttonWidth, 14)];
        
        titleLable.text = barButtonTitleArray[i];
        
        titleLable.font = [UIFont systemFontOfSize:12];
        
        titleLable.textColor = [UIColor grayColor];
        
        titleLable.tag = 1001;
        
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        [button addSubview:titleLable];
        
       
        //设置第一个button选中
        if (i == 0) {
            [self barButtonClick:button];
        }
        
    }
}


#pragma mark - 实现barButton的点击事件
-(void)barButtonClick:(UIButton *)button{
    //实现tabBarButton对于viewController的界面切换
    self.selectedIndex = button.tag%100;
    
    //先还原已经选中的按钮
    if (self.currentSecletedButton) {
        
        NSLog(@"%ld",(long)self.currentSecletedButton.tag);
        [self.currentSecletedButton setImage:[UIImage imageNamed:self.barButtonImageViewArray[self.currentSecletedButton.tag%100]] forState:UIControlStateNormal];
        
        UILabel *textLabel = (UILabel *)[self.currentSecletedButton viewWithTag:1001];
        
        textLabel.textColor = [UIColor grayColor];
    }

    //给现在的button上颜色
    [button setImage:[UIImage imageNamed:self.barButtonSecletedImageViewArray[button.tag%100]] forState:UIControlStateNormal];
    
    UILabel *textLabel = (UILabel *)[button viewWithTag:1001];
    textLabel.textColor = [UIColor colorWithRed:240/256.0 green:52/256.0 blue:113/256.0 alpha:1];
    
    //把新选中的按钮给到当前按钮
    self.currentSecletedButton = button;
    
    //****************************************
    //改变navigation的bar栏目内容
    //获取当前的导航栏(注意强转条件)
//    MainNaviViewController *mainNVC = (MainNaviViewController *)self.navigationController;
//    
//    if (button.tag %100 == 1 || button.tag %100 == 2) {
//        mainNVC.rightButton.hidden = YES;
//    }
//    else{
//        mainNVC.rightButton.hidden = NO;
//    }
//    
//    //需要还原设置过的title或图片
//    if (button.tag %100 == 0) {
//        [mainNVC.rightButton setImage:[UIImage imageNamed:@"expl_found"] forState:UIControlStateNormal];
//        
//        [mainNVC.rightButton setTitle:@"" forState:UIControlStateNormal];
//    }
//    else if(button.tag %100 == 3){
//        [mainNVC.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        
//        [mainNVC.rightButton setTitle:@"登录" forState:UIControlStateNormal];
//        
//        
//    }
    
    
    switch (button.tag) {
        case 100:
        {
        
        
        }
            break;
            
        case 101:
        {
            
            
        }
            break;
        case 102:
        {

            
            
        }
            break;
        case 103:
        {
            
            
        }
            break;
        case 104:
        {
            
            
        }
            break;
        default:
            break;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
