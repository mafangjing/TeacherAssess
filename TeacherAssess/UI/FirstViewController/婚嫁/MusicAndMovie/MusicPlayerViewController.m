//
//  MusicPlayerViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface MusicPlayerViewController ()

@property(nonatomic,strong)MPMoviePlayerViewController * mpPlayVc;

@end

@implementation MusicPlayerViewController

-(void)viewWillAppear:(BOOL)animated{

[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playStop) name:MPMovieDurationAvailableNotification object:nil];

}

//播放结束后通知的回调
-(void)playStop{
    //销毁界面
    [self.mpPlayVc.view removeFromSuperview];
    //销毁vc
    [self.mpPlayVc removeFromParentViewController];
    self.mpPlayVc = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.musicUrl);
    
    [self setVidoplay];
    
    
}

-(void)setVidoplay{

self.mpPlayVc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.musicUrl]];
    //加载子vc的方式加载播放器界面
    self.mpPlayVc.view.frame = self.view.bounds;
    
    [self.view addSubview:self.mpPlayVc.view];
    [self addChildViewController:self.mpPlayVc];

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
