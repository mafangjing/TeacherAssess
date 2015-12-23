//
//  thirdLocalData.m
//  Wedding
//
//  Created by hjh on 15-12-22.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "thirdLocalData.h"
#import "FMDatabase.h"
#import "MyFMDataBase.h"
@implementation thirdLocalData

#define ThirdLocalDataTable @"ThirdLocalDataTable"
#define WeddingCollectDataBase @"WeddingCollectDataBase"
#define ThirdLocalDataTableArray @[@"description",@"fid",@"name",@"todayposts"]
+(void)setLocalDataWithDic:(NSDictionary *)dic{
    
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:ThirdLocalDataTable tableArray:ThirdLocalDataTableArray];
    
    //再插入之前，先把表单数据清空
    [myDB deleteAllDataWithTableName:ThirdLocalDataTable];
    
    for (NSDictionary * dict in dic[@"list"]) {
        
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        
        [mdict setObject:dict[@"description"] forKey:@"description"];
        [mdict setObject:dict[@"fid"] forKey:@"fid"];
        [mdict setObject:dict[@"name"] forKey:@"name"];
        [mdict setObject:dict[@"todayposts"] forKey:@"todayposts"];
        [myDB insertDataWithTableName:ThirdLocalDataTable insertDictionary:mdict];
    }
    
    //关闭数据库
    [myDB closeDataBase];
    
}



+(NSArray *)GetLocalDataArray{
    
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
//    [myDB createTableWithTableName:ThirdLocalDataTable tableArray:ThirdLocalDataTableArray];
    
    
    //查询表单中的数据
    NSArray *listArray = [myDB selectDataWithTableName:ThirdLocalDataTable scutureArray:ThirdLocalDataTableArray];
    
    //    NSLog(@"%@",listArray);
    
    
    return listArray;
}



@end
