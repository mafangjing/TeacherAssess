//
//  FouthNetWork.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "FouthNetWork.h"

@implementation FouthNetWork

+(void)getFouthdataWithUrl:(NSString *)url appkey:(NSString *)appkey page:(NSString *)page pid:(NSString *)pid{

    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&page=%@&pid=%@",url,appkey,page,pid];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //        NSLog(@"ThirdData = %@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FouthDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



+(void)getFouthDetilaDataWithUrl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi{


    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&id=%@",url,appkey,idi];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //        NSLog(@"ThirdData = %@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FouthDetilaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


+(void)getCanPinDataWithUrl:(NSString *)url appkey:(NSString *)appkey pid:(NSString *)pid page:(NSString *)page{


    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&pid=%@&page=%@",url,appkey,pid,page];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CanPinDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)getFouthCanPinDetilaDataWithUrl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi token:(NSString *)token{


    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&id=%@&token=%@",url,appkey,idi,token];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CanPinDetilaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


+(void)getSearchDataWithUrl:(NSString *)url appkey:(NSString *)appkey keyword:(NSString *)keyword{

    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&keyword=%@",url,appkey,keyword];
    NSLog(@"%@",urlstring);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SearchDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}



@end
