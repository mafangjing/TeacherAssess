//
//  bofangViewController.m
//  Amuse
//
//  Created by kangxin on 15/9/30.
//  Copyright (c) 2015年 kangxin. All rights reserved.
//

#import "bofangViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface bofangViewController ()

@property(nonatomic,strong)MPMoviePlayerViewController * playerViewControl;

@property (nonatomic, strong) UIView * headerView;

@property (nonatomic, strong) UIView * fontClickView;

@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)UISlider *movieSlider;

@property(nonatomic,strong)NSTimer *time;

@property(nonatomic,assign)BOOL isChange;

@property(nonatomic,strong)NSMutableArray *changeTimeArray;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) UIButton *playerButton;

@property (nonatomic, strong) NSTimer * timer1;

@end

@implementation bofangViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    //当视频播放结束时返回的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerStop) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    self.changeTimeArray = [NSMutableArray array];

//    self.playerViewControl.view.frame = self.view.frame;//全屏播放（全屏播放不可缺）
//    self.playerViewControl.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;//全屏播放（全屏播放不可缺）

    [self video];
    
}

//-(BOOL)shouldAutorotate
//{
//    //让该页面屏幕自动旋转
//    return YES;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft;
//}


-(void)video
{
    //带有播放功能的vc
    //创建一个playerViewController对象
    //给该vc设置一个播放视频的url
    //通过[NSURL URLWithString:网络地址]网络视频播放
    self.playerViewControl = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://imagedaren.xishiwang.com/music/2014-08//2014-0853fef4e1927c6.mp3"]];
    
//    [self presentViewController:playerViewControl animated:YES completion:nil];
    
    // 加载子vc的方式加载播放器界面
    self.playerViewControl.view.frame = self.view.bounds;
    
    [self.view addSubview:self.playerViewControl.view];
    
    [self addChildViewController:self.playerViewControl];
    
    //播放模式设置MPMovieControlStyleEmbedded
    self.playerViewControl.moviePlayer.controlStyle = MPMovieControlStyleNone;
    
    //添加点击层
    [self setTapGesture];
    
    //设置头
    [self setHeaderAndFootView];
    
    //设置playerViewControl的属性(制作一个延时操作)
//    [self performSelector:@selector(setPlayerObject) withObject:nil afterDelay:5];
}

-(void)setHeaderAndFootView
{
    //设置头部栏目
    self.headerView = [[UIView alloc]init];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick2)];
    
    [self.headerView addGestureRecognizer:tap3];
    
    self.headerView.userInteractionEnabled = YES;
    
    self.headerView.backgroundColor = [UIColor grayColor];
    
    self.headerView.alpha = 0.9;
    
    self.view.clipsToBounds = YES;
    
    [self.fontClickView addSubview:self.headerView];
    
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * array1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headerView]-0-|" options:0 metrics:nil views:@{@"headerView":self.headerView}];
    [self.fontClickView addConstraints:array1];
    NSArray * array2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headerView(64)]" options:0 metrics:nil views:@{@"headerView":self.headerView}];
    [self.fontClickView addConstraints:array2];
    
    //显示总时间
    UILabel * label = [[UILabel alloc]init];
    label.tag = 123;
    label.text = @"0:0";
    label.textColor = [UIColor whiteColor];
    [self.headerView addSubview:label];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * labelArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[label(70)]-20-|" options:0 metrics:nil views:@{@"label":label}];
    [self.headerView addConstraints:labelArray1];
    NSArray * labelArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[label(20)]" options:0 metrics:nil views:@{@"label":label}];
    [self.headerView addConstraints:labelArray2];
    
    //显示当前时间
    UILabel * label2 = [[UILabel alloc]init];
    label2.tag = 124;
    label2.text = @"0:0";
    label2.textColor = [UIColor whiteColor];
    [self.headerView addSubview:label2];
    
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * label2Array1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[label2(70)]" options:0 metrics:nil views:@{@"label2":label2}];
    [self.headerView addConstraints:label2Array1];
    NSArray * label2Array2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[label2(20)]" options:0 metrics:nil views:@{@"label2":label2}];
    [self.headerView addConstraints:label2Array2];
    
    if (self.playerViewControl.moviePlayer.duration == 0) {
    
        self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setPlayerObject) userInfo:nil repeats:YES];
        
    }
    
    //********************************************************
    //设置结束按钮
    UIButton *doneButton = [[UIButton alloc]init];
    
    //    doneButton.backgroundColor = [UIColor redColor];
    
    [doneButton setTitle:@"返回" forState:UIControlStateNormal];
    
    doneButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:doneButton];
    
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * doneButtonArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[doneButton(60)]" options:0 metrics:nil views:@{@"doneButton":doneButton}];
    [self.headerView addConstraints:doneButtonArray1];
    NSArray * doneButtonArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[doneButton(40)]" options:0 metrics:nil views:@{@"doneButton":doneButton}];
    [self.headerView addConstraints:doneButtonArray2];
    
    //创建视频进度条
    self.movieSlider = [[UISlider alloc]init];

    //获取进度条改变
    [self.movieSlider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    
    [self.headerView addSubview:self.movieSlider];

    self.movieSlider.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * movieSliderArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[movieSlider]-100-|" options:0 metrics:nil views:@{@"movieSlider":self.movieSlider}];
    [self.headerView addConstraints:movieSliderArray1];
    NSArray * movieSliderArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[movieSlider(44)]" options:0 metrics:nil views:@{@"movieSlider":self.movieSlider}];
    [self.headerView addConstraints:movieSliderArray2];
    
    //制作一个时间轮询（改变进度条）
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGetTime) userInfo:nil repeats:YES];

    //********************************************************
    
    
    //设置底部栏目
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 568 - 64, 320, 64)];
    
    self.footView.backgroundColor = [UIColor grayColor];
    
    self.footView.alpha = 0.9;
    
    [self.fontClickView addSubview:self.footView];
    
    self.footView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * footArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[footView]-0-|" options:0 metrics:nil views:@{@"footView":self.footView}];
    [self.fontClickView addConstraints:footArray1];
    NSArray * footArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[footView(64)]-0-|" options:0 metrics:nil views:@{@"footView":self.footView}];
    [self.fontClickView addConstraints:footArray2];
    
    //*****************************************************
    //设置播放按钮
    self.playerButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40/2, 64/2 - 40/2, 40, 40)];
    
    [self.playerButton setImage:[UIImage imageNamed:@"play-lan_stop.png"] forState:UIControlStateNormal];
    
    [self.playerButton setImage:[UIImage imageNamed:@"play-lan_play.png"] forState:UIControlStateSelected];
    
    [self.playerButton addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footView addSubview:self.playerButton];
    
//    playerButton.translatesAutoresizingMaskIntoConstraints = NO;
//    NSArray * playerButtonArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[playerButton]-0-|" options:0 metrics:nil views:@{@"playerButton":playerButton}];
//    [self.footView addConstraints:playerButtonArray1];
//    NSArray * playerButtonArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[playerButton(64)]-0-|" options:0 metrics:nil views:@{@"playerButton":playerButton}];
//    [self.footView addConstraints:playerButtonArray2];
    
}

#pragma mark - 添加一个点击手势隐藏和显示栏目
-(void)setTapGesture{
    //添加手势点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    
    self.fontClickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    //透明的点击层
    self.fontClickView.backgroundColor = [UIColor clearColor];
    
    [self.fontClickView addGestureRecognizer:tap];
    
    [self.view addSubview:self.fontClickView];
    
    self.fontClickView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray * array1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[fontClickView]-0-|" options:0 metrics:nil views:@{@"fontClickView":self.fontClickView}];
    [self.view addConstraints:array1];
    NSArray * array2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[fontClickView]-0-|" options:0 metrics:nil views:@{@"fontClickView":self.fontClickView}];
    [self.view addConstraints:array2];
}

-(void)tapClick{
    //制作隐藏操作
    if (self.headerView.hidden == YES) {
        self.headerView.hidden = NO;
    }
    else{
        self.headerView.hidden = YES;
    }
    //制作隐藏操作
    if (self.footView.hidden == YES) {
        self.footView.hidden = NO;
    }
    else{
        self.footView.hidden = YES;
    }
}

-(void)tapClick2{
    
}

#pragma mark - 播放按钮设置
-(void)playBtnClick{
    //暂停和播放功能设置
    if (self.playerButton.selected == YES) {
        self.playerButton.selected = NO;
        [self.playerViewControl.moviePlayer play];
    }
    else{
        self.playerButton.selected = YES;
        [self.playerViewControl.moviePlayer pause];
    }
}

#pragma mark - 结束播放按钮
-(void)doneButtonClick{
    
    [self.playerViewControl.moviePlayer stop];
    
}

#pragma mark - 通过滑动条改变当前播放时间
-(void)sliderChange{
    
    //暂定时间
    self.time.fireDate = [NSDate distantFuture];
    
    //设置总时间长度
    self.movieSlider.maximumValue = self.playerViewControl.moviePlayer.duration;
    
    //设置最小时间长度
    self.movieSlider.minimumValue = 0;
    
//    NSLog(@"%f",self.movieSlider.value);
    
    //    self.playerControl.moviePlayer.currentPlaybackTime = self.movieSlider.value;
    
    //设定改变的最小间隔为1秒
    if (self.isChange == NO) {
        [self performSelector:@selector(changeMovieTime) withObject:nil afterDelay:0.5];
        
        self.isChange = YES;
    }
    
    [self.changeTimeArray addObject:[NSString stringWithFormat:@"%f",self.movieSlider.value]];
}

-(void)changeMovieTime{
    
//    NSLog(@"%@",[self.changeTimeArray lastObject]);
    //设置电影播放时间
    self.playerViewControl.moviePlayer.currentPlaybackTime = [[self.changeTimeArray lastObject]floatValue];
    
    //清空数组
    [self.changeTimeArray removeAllObjects];
    
    //开启时间
    self.time.fireDate = [NSDate distantPast];
    
    self.isChange = NO;
}

-(void)setPlayerObject
{
    UILabel * lable = (UILabel *)[self.headerView viewWithTag:123];
    
    NSInteger k = self.playerViewControl.moviePlayer.duration;//视频总时间
    
//    NSLog(@"%.1ld", k);
    
    NSInteger m, s;
    
    m = k / 60;//转化分钟数
    
    s = k % 60;//转化秒数
    
    lable.text = [NSString stringWithFormat:@"%ld:%ld", m, s];
    
    UILabel * lable2 = (UILabel *)[self.headerView viewWithTag:124];
    
    NSInteger k2 = self.playerViewControl.moviePlayer.currentPlaybackTime;//当前播放时间
    
//    NSLog(@"%.1ld", k2);
    
    if (k2 > 0) {
        
        NSInteger m2, s2;
        //
        m2 = k2 / 60;//转化分钟数
        //
        s2 = k2 % 60;//转化秒数
        //
        lable2.text = [NSString stringWithFormat:@"%ld:%ld", m2, s2];
        
    }
    
//    [lable setText:[NSString stringWithFormat:@"%.1f", self.playerViewControl.moviePlayer.duration]];
    
//    lable.text = [NSString stringWithFormat:@"%.1f", self.playerViewControl.moviePlayer.duration];
    
    //当前播放时间
//    NSTimeInterval f = self.playerViewControl.moviePlayer.currentPlaybackTime;
//    
//    //播放视频的总播放时间
//    NSTimeInterval k = self.playerViewControl.moviePlayer.duration;
//    
//    NSLog(@"播放总时间 = %f,当前播放时间 = %f",k,f);
    
    //播放器的暂停停止和播放
    //    [self.playerViewControl.moviePlayer play];
    //
    //    [self.playerViewControl.moviePlayer stop];
    
    //    [self.playerViewControl.moviePlayer pause];
}

#pragma mark - 时间进度条
-(void)timeGetTime{
    //设置总时间长度
    self.movieSlider.maximumValue = self.playerViewControl.moviePlayer.duration;
    
    //设置最小时间长度
    self.movieSlider.minimumValue = 0;
    
    //设置当前时间长度
    self.movieSlider.value = self.playerViewControl.moviePlayer.currentPlaybackTime;
}

//当播放结束后控制器销毁
-(void)playerStop
{
    if (self.Y) {
        
        [self.timer1 invalidate];//销毁定时器
        
        [self.time invalidate];
        
        [self.timer invalidate];
        
        //销毁界面
        [self.playerViewControl.view removeFromSuperview];
        
        //销毁vc
        [self.playerViewControl removeFromParentViewController];
        
        self.playerViewControl = nil;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
    
        [self.timer1 invalidate];//销毁定时器
        
        [self.time invalidate];
        
        [self.timer invalidate];
        
        //销毁界面
        [self.playerViewControl.view removeFromSuperview];
        
        //销毁vc
        [self.playerViewControl removeFromParentViewController];
        
        self.playerViewControl = nil;
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
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
