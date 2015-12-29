//
//  WaterViewController.m
//  CollectionView_WaterFSmaple
//
//  Created by 黄嘉宏 on 15/12/25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "WaterViewController.h"
#import "WaterF.h"

@interface WaterViewController ()
@property (nonatomic,strong) WaterF* waterfall;
@property (nonatomic,strong) NSMutableArray* images;
@property (nonatomic,strong) NSArray* texts;
@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self prepareForData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForData{
    //设置collectionView需要显示的数据储备
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"dataList" ofType:@"plist"];
    NSDictionary *dataDic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
    
    NSArray *photoArray = dataDic[@"photoArray"];
    
    NSArray *textArray = dataDic[@"textArray"];
    
    NSMutableArray* URLS = [NSMutableArray array];
    
    for (int i = 0; i<photoArray.count; i++)
    {
        [URLS addObject:[NSURL URLWithString:photoArray[i]]];
    }
    
    
    self.images = [[NSMutableArray alloc]initWithCapacity:30];
    for (int i = 0; i<photoArray.count; i++)
    {
        NSData* data = [[NSData alloc]initWithContentsOfURL:URLS[i]];
        if ([data isKindOfClass:[NSData class]]) {
            [self.images addObject:[UIImage imageWithData:data]];
        }
        
    }
    
    self.texts = textArray;

    //设置显示collectionView的点击按钮
    UIButton* collectionViewAdd = [UIButton buttonWithType:UIButtonTypeSystem];
    
    collectionViewAdd.frame = CGRectMake(50, 120, 100, 40);
    
    [collectionViewAdd setTitle:@"CollectionBtn" forState:UIControlStateNormal];
    
    [collectionViewAdd addTarget:self action:@selector(addWaterFollow:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:collectionViewAdd];
}

//点击按钮显示collectionView
- (void)addWaterFollow:(UIButton*)btn
{
    WaterFLayout* flowLayout = [[WaterFLayout alloc]init];
    
    self.waterfall = [[WaterF alloc]initWithCollectionViewLayout:flowLayout];
    
    self.waterfall.imagesArr = self.images;
    
    self.waterfall.textsArr = self.texts;
    
    self.waterfall.sectionNum = 1;
    
    self.waterfall.imagewidth = 150;
    
    [self.view addSubview:self.waterfall.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
