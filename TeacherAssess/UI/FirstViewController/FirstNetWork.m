//
//  FirstNetWork.m
//  Wedding
//
//  Created by hjh on 15-10-4.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "FirstNetWork.h"

@implementation FirstNetWork



+(void)getFirstAdDataWithUrl:(NSString *)AdUrl{

        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        //数据返回形式为NSData类型
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:AdUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
//            NSLog(@"%@",dic);
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"firstADvertisementDataReturn" object:dic];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
}


+(void)GetFirstJingXuanDataWithUrl:(NSString *)url{


    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FirstJingXuanDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

+(void)GetShiPingDetialDataUrlWithUrl:(NSString *)url act:(NSString *)act hxjx:(NSString *)hxjx mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper{

    NSString * urlstring = [NSString stringWithFormat:@"%@?act=%@&&hxjx=%@&mver=%@&page=%@&pageper=%@",url,act,hxjx,mver,page,pageper];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShiPingDetilaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


+(void)getGengDuoShiPingDataWithUrl:(NSString *)url act:(NSString *)act type:(NSString *)type mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper{

    NSString * urlstring = [NSString stringWithFormat:@"%@?act=%@&type=%@&mver=%@&page=%@&pageper=%@",url,act,type,mver,page,pageper];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GengDuoShiPingDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)getGengDuoHunLiDataWithUrl:(NSString *)url act:(NSString *)act type:(NSString *)type mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper{

    NSString * urlstring = [NSString stringWithFormat:@"%@?act=%@&type=%@&mver=%@&page=%@&pageper=%@",url,act,type,mver,page,pageper];
    NSLog(@"%@",urlstring);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GengDuoHunLiDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}









+(void)getHunJiaDataWithUrl:(NSString *)url appkey:(NSString *)appkey pid:(NSString *)pid page:(NSString *)page{
     NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&pid=%@&page=%@",url,appkey,pid,page];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"firsthunJiaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

+(void)getHunJiaDetilaDatawithurl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi{

    NSString * urlstring = [NSString stringWithFormat:@"%@?appkey=%@&id=%@",url,appkey,idi];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //            NSLog(@"%@",dic);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"firsthunJiaDetilaDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)getMusicDataWithUrl:(NSString *)url{

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    //数据返回形式为NSData类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MusicDataReturn" object:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


+(void)getDetilaMusicDataWith:(NSString *)url mtid:(NSString *)mtid pageflag:(NSString *)pageflag lastid:(NSString *)lastid{

    NSString * musicDetilaString = [NSString stringWithFormat:@"%@?mtid=%@&pageflag=%@&lastid=%@",url,mtid,pageflag,lastid];
    NSLog(@"musicDetilaString = %@",musicDetilaString);
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:musicDetilaString parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"musicDetilaDataReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


+(void)GetHUnJiaSearchDataWithUrl:(NSString *)url appkey:(NSString *)appkey keyword:(NSString *)keyword{


    NSString * musicDetilaString = [NSString stringWithFormat:@"%@?appkey=%@&keyword=%@",url,appkey,keyword];
    NSLog(@"musicDetilaString = %@",musicDetilaString);
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:musicDetilaString parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HunJiaSearchDataReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}



+(void)GetJXHunLiDetilaDataWithUrl:(NSString *)url act:(NSString *)act hxjx:(NSString *)hxjx mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper{


    NSString * JXHunLiDetilaString = [NSString stringWithFormat:@"%@?act=%@&&hxjx=%@&mver=%@&page=%@&pageper=%@",url,act,hxjx,mver,page,pageper];
    NSLog(@"%@",JXHunLiDetilaString);
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:JXHunLiDetilaString parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"JXHunLiDetilaDatasReturn" object:dic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


@end
