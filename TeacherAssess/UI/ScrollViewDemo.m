//
//  ScrollViewDemo.m
//  TeacherAssess
//
//  Created by ma on 15/12/21.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import "ScrollViewDemo.h"

@interface ScrollViewDemo ()<UIScrollViewDelegate>
//记录当天页
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation ScrollViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 设置一个scrollView
-(void)setScrollView{
    self.scrollView = [[UIScrollView alloc]init];
    
    NSLog(@"%f",self.scrollViewFrame.size.width);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.frame = CGRectMake(0, 0, self.scrollViewFrame.size.width, self.scrollViewFrame.size.height);
    
    self.scrollView.contentSize = CGSizeMake(self.scrollViewFrame.size.width * (self.photoArray.count + 2), self.scrollViewFrame.size.height);
    
    //使用回调
    self.scrollView.delegate = self;
    
    NSMutableArray *mPhotoArray = [[NSMutableArray alloc]initWithArray:self.photoArray];
    
    //防止数组中没有图片
    if (mPhotoArray.count > 0) {
        //在头部插入最后一个图片
        [mPhotoArray insertObject:mPhotoArray.lastObject atIndex:0];
        //在尾部插入第一张图片
        [mPhotoArray addObject:mPhotoArray[1]];
    }
    
    //创建7张图片在scrollView中
    for (int i = 0; i < mPhotoArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        if (self.isNotLocalImage == NO) {
            imageView.image = [UIImage imageNamed:[mPhotoArray objectAtIndex:i]];
        }
        else{
            [imageView setImageWithURL:[NSURL URLWithString:mPhotoArray[i]]];
        }
        
        imageView.frame = CGRectMake(i * self.scrollViewFrame.size.width, 0, self.scrollViewFrame.size.width, self.scrollViewFrame.size.height);
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.pagingEnabled = YES;
    
    //设置显示第一张的scrollView位置
    self.scrollView.contentOffset = CGPointMake(self.scrollViewFrame.size.width, 0);
    
    self.currentPage = 1;
    
    [self.view addSubview:self.scrollView];
    
    //做一个计时器去改变scrollView
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    
    //制作一个pageControl
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = self.photoArray.count;
    
    self.pageControl.currentPage = self.currentPage - 1;
    
    self.pageControl.frame = CGRectMake(self.scrollViewFrame.size.width/2 - 200/2, self.scrollViewFrame.size.height - self.pageControlHeight, 200, self.pageControlHeight);
    
    [self.view addSubview:self.pageControl];
    
    
}

//改变scrollView的位置
-(void)changeScrollContentOffSet{
    if (self.currentPage == 0) {
        self.scrollView.contentOffset = CGPointMake(self.scrollViewFrame.size.width * self.photoArray.count, 0);
        self.currentPage = self.scrollView.contentOffset.x/self.scrollViewFrame.size.width;
        
        self.pageControl.currentPage = self.currentPage - 1;
    }
    else if(self.currentPage == (self.photoArray.count + 1)){
        self.scrollView.contentOffset = CGPointMake(self.scrollViewFrame.size.width * 1, 0);
        
        self.currentPage = self.scrollView.contentOffset.x/self.scrollViewFrame.size.width;
        
        self.pageControl.currentPage = self.currentPage - 1;
    }
}

-(void)timerChange{
    //每隔一定时间加滚动一页
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentOffset.x + self.scrollViewFrame.size.width, 0, self.scrollViewFrame.size.width, self.scrollViewFrame.size.height) animated:YES];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.currentPage = scrollView.contentOffset.x/self.scrollViewFrame.size.width;
    
    self.pageControl.currentPage = self.currentPage - 1;
    
    [self changeScrollContentOffSet];
    
    if (self.timer == nil) {
        //做一个计时器去改变scrollView
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //在滚动完以后设置页码
    self.currentPage = self.scrollView.contentOffset.x/self.scrollViewFrame.size.width;
    self.pageControl.currentPage = self.currentPage - 1;
    [self changeScrollContentOffSet];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
