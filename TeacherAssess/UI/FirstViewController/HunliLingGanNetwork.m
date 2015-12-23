//
//  HunliLingGanNetwork.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunliLingGanNetwork.h"

@implementation HunliLingGanNetwork

+(void)GetHunliLingGanDataUrl:(NSString *)url act:(NSString *)act cate:(NSString *)cate mver:(NSString *)mver{

    NSString * urlstring = [NSString stringWithFormat:@"%@?act=%@&cate=%@&mver=%@",url,act,cate,mver];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HunliLingGanDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



+(void)GetHunliLingGanPhotoListDataWithUrl:(NSString *)url act:(NSString *)act cate:(NSString *)cate page:(NSString *)page pageper:(NSString *)pageper color:(NSString *)color mver:(NSString *)mver{


    NSString * urlstring = [NSString stringWithFormat:@"%@?act=%@&cate=%@&page=%@&pageper=%@&color=%@&mver=%@",url,act,cate,page,pageper,color,mver];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HunliLingGanPhotoListDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}




@end
