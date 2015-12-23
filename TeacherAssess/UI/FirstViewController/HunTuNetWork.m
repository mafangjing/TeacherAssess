//
//  HunTuNetWork.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunTuNetWork.h"

@implementation HunTuNetWork

+(void)GetHunTuDataWithUrl:(NSString *)url lastid:(NSString *)lastid resolution:(NSString *)resolution pageflag:(NSString *)pageflag ctypeid:(NSString *)ctypeid itypeid:(NSString *)itypeid goodsid:(NSString *)goodsid{


    NSString * urlstring = [NSString stringWithFormat:@"%@?lastid=%@&resolution=%@&pageflag=%@&ctypeid=%@&itypeid=%@&goodsid=%@",url,lastid,resolution,pageflag,ctypeid,itypeid,goodsid];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HunTuDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



@end
