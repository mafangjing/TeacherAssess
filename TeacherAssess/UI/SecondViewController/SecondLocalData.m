//
//  SecondLocalData.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondLocalData.h"

@implementation SecondLocalData



+(void)setLocalDataWithDic:(NSDictionary *)dic{
    
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:SecondLocalDataTable tableArray:SecondLocalDataTableArray];
    
    //再插入之前，先把表单数据清空
    [myDB deleteAllDataWithTableName:SecondLocalDataTable];
    
    for (NSDictionary * dict in dic[@"list"]) {
        
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        
        [mdict setObject:dict[@"bkg_path"] forKey:@"bkg_path"];
        [mdict setObject:dict[@"cover_path"] forKey:@"cover_path"];
        [mdict setObject:dict[@"desc"] forKey:@"desc"];
        [mdict setObject:dict[@"id"] forKey:@"id1"];
        [mdict setObject:dict[@"title"] forKeyedSubscript:@"title"];
        [myDB insertDataWithTableName:SecondLocalDataTable insertDictionary:mdict];
    }
    
    //关闭数据库
    [myDB closeDataBase];
    
}



+(NSArray *)GetLocalDataArray{
    
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),WeddingCollectDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:SecondLocalDataTable tableArray:SecondLocalDataTableArray];
    
    
    //查询表单中的数据
    NSArray *listArray = [myDB selectDataWithTableName:SecondLocalDataTable scutureArray:SecondLocalDataTableArray];
    
    //    NSLog(@"%@",listArray);
    
    
    return listArray;
}





@end
