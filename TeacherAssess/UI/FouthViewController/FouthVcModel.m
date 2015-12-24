//
//  FouthVcModel.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "FouthVcModel.h"

@implementation FouthVcModel

@synthesize id1 = _id;

+(FouthVcModel *)setBeanWithDictionary:(NSDictionary *)dic{
    
    FouthVcModel *bean = [[FouthVcModel alloc]init];
    
    [bean setValuesForKeysWithDictionary:dic];
    
    return bean;
}

+(NSArray *)setBeanWithArray:(NSArray *)array{
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        FouthVcModel *bean = [FouthVcModel setBeanWithDictionary:dic];
        
        [mArr addObject:bean];
    }
    
    return mArr;
}



@end
