//
//  FouthLocalData.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "FouthLocalData.h"

@implementation FouthLocalData




+(void)setLocalDataWithDic:(NSDictionary *)dic{
    
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:FouthLocalDataTable tableArray:FouthLocalDataTableArray];
    
    //再插入之前，先把表单数据清空
    [myDB deleteAllDataWithTableName:FouthLocalDataTable];
    
    for (NSDictionary * dict in dic[@"list"]) {
        
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        
        [mdict setObject:dict[@"address"] forKey:@"address"];
        [mdict setObject:dict[@"level"] forKey:@"level"];
        [mdict setObject:dict[@"logo"] forKey:@"logo"];
        [mdict setObject:dict[@"id"] forKey:@"id1"];
        [mdict setObject:dict[@"name"] forKeyedSubscript:@"name"];
        [mdict setObject:dict[@"operate"] forKey:@"operate"];
        
        [myDB insertDataWithTableName:FouthLocalDataTable insertDictionary:mdict];
    }
    
    //关闭数据库
    [myDB closeDataBase];
    
}



+(NSArray *)GetLocalDataArray{
    
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:FouthLocalDataTable tableArray:FouthLocalDataTableArray];
    
    
    //查询表单中的数据
    NSArray *listArray = [myDB selectDataWithTableName:FouthLocalDataTable scutureArray:FouthLocalDataTableArray];
    
    //    NSLog(@"%@",listArray);
    
    
    return listArray;
}


@end
