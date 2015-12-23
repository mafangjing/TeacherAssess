//
//  BigPhotopViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "BigPhotopViewController.h"

#define screenWidth 320

#define screenHight 568

@interface BigPhotopViewController ()

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;


@end

@implementation BigPhotopViewController

-(void)viewWillAppear:(BOOL)animated{

    
}

-(void)viewWillDisappear:(BOOL)animated{



}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    NSLog(@"photosArray = %@",self.photosArray);
    NSLog(@"currentPhotoPage = %@",self.currentPhotoPage);


    //添加头部导航栏
    [self headView];
    
    [self setScrollView];

}

/*********************************************/
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor blackColor];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 25)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
}
-(void)leftbutClick{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/



-(void)setScrollView{


    UIScrollView *sV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    [sV setContentSize:CGSizeMake(self.view.frame.size.width * self.photosArray.count, self.view.frame.size.height - 64)];
    
    sV.pagingEnabled = YES;
    
    [sV setContentOffset:CGPointMake(self.view.frame.size.width * [self.currentPhotoPage integerValue], 0)];
    
    sV.bounces = NO;
    
    [self.view addSubview:sV];
    
    for (int i = 0; i < self.photosArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake( 10 + i*self.view.frame.size.width, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64)];
        
        [imageView setImageWithURL:[NSURL URLWithString:self.photosArray[i][@"image_url"]] placeholderImage:nil];
        
        [sV addSubview:imageView];
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
