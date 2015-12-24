//
//  SecondNetWork.m
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondNetWork.h"

@implementation SecondNetWork

{
//    NSDictionary * _dic;

}

+(void)getSecondDataWithUrl:(NSString *)url withPage:(NSString *)page{
    
    NSString * urlString = [NSString stringWithFormat:@"%@?page=%@",url,page];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SecondDataReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)getSecondListDatawithUrl:(NSString *)url category:(NSString *)category page:(NSString *)page sort:(NSString *)sort subject:(NSString *)subject{

    NSString * urlString = [NSString stringWithFormat:@"%@?category=%@&page=%@&sort=%@&subject=%@",url,category,page,sort,subject];
    
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SecondListDataReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}


+(void)GetSecondDetilaDataWithUrl:(NSString *)url idi:(NSString *)idi user_id:(NSString *)user_id{


    NSString * urlString = [NSString stringWithFormat:@"%@%@?user_id=%@",url,idi,user_id];
    
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SecondDetilaDataReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];




}







+(void)getSecondDataWithUrl:(NSString *)Urlpath withPage:(NSString *)page WithBlock:(void(^)(NSDictionary *))block{

    NSString * urlPathString = [NSString stringWithFormat:@"%@?page=%@",Urlpath,page];
    
    NSLog(@"%@",urlPathString);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlPathString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"%@",dic);
        
        block(dic);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


@end
