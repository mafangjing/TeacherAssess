//
//  ThirdNetWork.m
//  Wedding
//
//  Created by qianfeng on 15-12-23.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdNetWork.h"
#import "AFNetworking.h"
@implementation ThirdNetWork

#define ThirdDetilaUrl @"http://circle.halobear.cn/api/mobile/index.php?module=forumdisplay&version=3"


+(void)getThirdAdDataWithUrl:(NSString *)AdUrl{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:AdUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ThirdADvertisementDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)getThirdFenZuDataWithUrl:(NSString *)Url{


    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
//        NSLog(@"ThirdDic = %@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"thirdTaoLunZuDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


+(void)getThirdDetilaDataWithfid:(NSString *)fid top:(NSString *)top page:(NSString *)page orderby:(NSString *)orderby mver:(NSString *)mver{
    
    NSString * urlstring = [NSString stringWithFormat:@"%@&fid=%@&top=%@&page=%@&orderby=%@&mver=%@",ThirdDetilaUrl,fid,top,page,orderby,mver];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
//        NSLog(@"ThirdData = %@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"thirdDetilaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

+(void)getThirdDetilaPingLunDataWithUrl:(NSString *)url tid:(NSString *)tid authorid:(NSString *)authorid ordertype:(NSString *)ordertype mver:(NSString *)mver{

    NSString * urlstring = [NSString stringWithFormat:@"%@&tid=%@&authorid=%@&ordertype=%@&mver=%@",url,tid,authorid,ordertype,mver];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //        NSLog(@"ThirdData = %@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"thirdDetilaPingLunDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



@end
