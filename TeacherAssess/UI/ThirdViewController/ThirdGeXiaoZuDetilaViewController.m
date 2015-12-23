//
//  ThirdGeXiaoZuDetilaViewController.m
//  Wedding
//
//  Created by qianfeng on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdGeXiaoZuDetilaViewController.h"
#import "ThirdDetilafirstTableViewCell.h"
#import "ThirdDetilaSecondTableViewCell.h"
#import "ThirdNetWork.h"

@interface ThirdGeXiaoZuDetilaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSArray * JuTiDataArray;

@end

@implementation ThirdGeXiaoZuDetilaViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdDetilaPingLunDataReturn:) name:@"thirdDetilaPingLunDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)thirdDetilaPingLunDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    
    self.JuTiDataArray = dic[@"Variables"][@"postlist"];
    
    NSLog(@"%@",self.JuTiDataArray);
    
    [self.myTableview reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@",self.lastDic);
    self.JuTiDataArray = [NSArray array];
    
    [self getData];
    
    //添加头部导航栏
    [self headView];
    [self setmytableView];

}

/*
 
 {
 attachment = 2;
 author = "\U5434\U592b\U4eba";
 authorid = 15417;
 avatar = "http://7kttnj.com2.z0.glb.qiniucdn.com/noavatar.png-middle";
 dateline = "3 \U5929\U524d";
 dbdateline = 1444543928;
 dblastpost = 1444543928;
 digest = 0;
 lastpost = "3 \U5929\U524d";
 lastposter = "\U5434\U592b\U4eba";
 message = "\U8fd8\U6ca1\U6709\U4fee\U7247\U90fd\U662f\U624d\U62ff\U5230\U624b\U7684\U5e95\U7247\U5c0f\U4f19\U4f34\U4eec\U53ef\U4ee5\U968f\U4fbf\U770b\U770b\Ud83d\Ude02";
 readperm = 0;
 replies = 0;
 subject = "\U521a\U62cd\U7684\U5a5a\U7eb1\U7167     \U5e78\U798fing    \U6ee1\U610f";
 tid = 2632;
 type = 0;
 typeid = 0;
 views = 40;
 },

 
 http://circle.halobear.cn/api/mobile/index.php?module=viewthread&charset=utf-8&image=1&ppp=10&version=3&total=1&tid=2546&authorid=0&ordertype=2&mver=3
 
 */

#define thirdDetilaPingLunUrl @"http://circle.halobear.cn/api/mobile/index.php?module=viewthread&charset=utf-8&image=1&ppp=10&version=3&total=1"

-(void)getData{

    [ThirdNetWork getThirdDetilaPingLunDataWithUrl:thirdDetilaPingLunUrl tid:self.lastDic[@"tid"] authorid:@"0" ordertype:@"2" mver:@"3"];

}


/*********************************************/
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 30)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/
-(void)setmytableView{
    
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.backgroundColor = [UIColor colorWithRed:241/256.0 green:241/256.0 blue:241/256.0 alpha:1];
    self.myTableview.delegate = self;
    
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    
    //注册一个cell
    [self.myTableview registerNib:[UINib nibWithNibName:@"ThirdDetilafirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells0"];
    [self.myTableview registerNib:[UINib nibWithNibName:@"ThirdDetilaSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells2"];
}
//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %ld",self.JuTiDataArray.count);
    return self.JuTiDataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
    
        static NSString * idetify = @"cells0";
        ThirdDetilafirstTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell1 == nil) {
            cell1 = [[ThirdDetilafirstTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
        }
    
    [cell1 setWithDic:self.lastDic];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    }else{
        
        static NSString * idetify = @"cells2";
        ThirdDetilaSecondTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell2 == nil) {
            cell2 = [[ThirdDetilaSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
        }
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"%ld",self.JuTiDataArray.count);
        
        if (self.JuTiDataArray.count > 0) {
            [cell2 setCellWithDic:self.JuTiDataArray[indexPath.row]];
            
            cell2.JiLouLable.text = [NSString stringWithFormat:@"%ld楼",indexPath.row + 1];
            
        }
        
        
        cell2.backgroundColor = [UIColor colorWithRed:241/256.0 green:241/256.0 blue:241/256.0 alpha:1];
        
        return cell2;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    }else{
        
        return 100;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
