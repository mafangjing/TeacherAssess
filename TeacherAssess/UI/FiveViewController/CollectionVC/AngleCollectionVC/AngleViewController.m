//
//  AngleViewController.m
//  CollectionViewAngleSample
//
//  Created by 黄嘉宏 on 15/12/25.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "AngleViewController.h"
#import "AWCollectionViewDialLayout.h"

@interface AngleViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *items;

@end

static NSString *cellId = @"cellId";

@implementation AngleViewController{
    NSMutableDictionary *thumbnailCache;
    AWCollectionViewDialLayout *dialLayout;
    
    int type;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //从json文件获取数据
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"players" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"jsonString:%@",jsonString);
    self.items = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //需要填写的参数
    CGFloat radius = 400;
    CGFloat angularSpacing = 15;
    CGFloat xOffset = 200;
    CGFloat cell_width = 240;
    CGFloat cell_height = 100;
    
    //使用第三方文件进行item角度变化
    
    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:radius andAngularSpacing:angularSpacing andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:xOffset];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:dialLayout];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    //注册collectionViewCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.item];
    
    NSString *playerName = [item valueForKey:@"name"];
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:101];
    [nameLabel setText:playerName];
    
    NSString *imgURL = [item valueForKey:@"picture"];
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:100];
    imgView.image = [UIImage imageNamed:imgURL];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
