//
//  CollectionViewController.m
//  Wedding
//
//  Created by hjh on 15-12-21.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "CollectionViewController.h"

#import "AngleViewController.h"

#import "WaterViewController.h"


@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

//创建一个给tableView装载数据的数组
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation CollectionViewController

-(void)viewWillAppear:(BOOL)animated{
    //设置导航栏
    [self headView];
    
    self.tabBarController.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    [self setMyTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.tabBarController.navigationItem.title = @"我的";
    
    
}

#pragma mark - 设置数据
-(void)getData{
    
    
}

-(void)setMyTableView{
    
    self.myTableView = [[UITableView alloc]init];
    
    self.myTableView.frame = CGRectMake(0, 0, screenWidth,screenHeight);
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
}




#pragma mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        //cell创建区域
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"旋转collect显示";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"瀑布流显示";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"国际化示例";
        }
        default:
        {
            cell.textLabel.text = @"";
        }
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            AngleViewController *aVC = [[AngleViewController alloc]init];
            
            [self.navigationController pushViewController:aVC animated:YES];
        }
            break;
        case 1:
        {
            WaterViewController *wVC = [[WaterViewController alloc]init];
            
            [self.navigationController pushViewController:wVC animated:YES];
        }
            break;
        default:
        {
            
        }
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
