//
//  FirstViewLocalData.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "FirstViewLocalData.h"

@implementation FirstViewLocalData



+(void)setLocalDataWithDic:(NSDictionary *)dic{
    
    //把新数据存储到本地数据库中
    //********************************************************
    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),YeMianLocallDataBase]];
    
    //创建数据库的list表单
    [myDB createTableWithTableName:Fiest_AdMessageData tableArray:Fiest_AdMessageDataArray];
    
    //再插入之前，先把表单数据清空
    [myDB deleteAllDataWithTableName:Fiest_AdMessageData];
    
    for (NSDictionary * dict in dic[@"list"]) {
        
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        
        [mdict setObject:dict[@"AdUrl"] forKeyedSubscript:@"AdUrl"];
        [myDB insertDataWithTableName:Fiest_AdMessageData insertDictionary:mdict];
    }
    
    //关闭数据库
    [myDB closeDataBase];
    
}



+(NSArray *)GetADLocalDataArray{

    MyFMDataBase *myDB = [[MyFMDataBase alloc]init];
    
    [myDB createDataBaseWithFilePath:[NSString stringWithFormat:@"%@/Documents/%@.sqlite",NSHomeDirectory(),YeMianLocallDataBase]];
    
    //创建数据库的list表单
//    [myDB createTableWithTableName:QiangXianBaoDatatable tableArray:QiangXianBaoDatatableArray];
    
    
    //查询表单中的数据
    NSArray *listArray = [myDB selectDataWithTableName:Fiest_AdMessageData scutureArray:Fiest_AdMessageDataArray];
    
    //    NSLog(@"%@",listArray);
    
    
    return listArray;
}




@end
