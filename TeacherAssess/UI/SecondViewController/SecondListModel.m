//
//  SecondListModel.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondListModel.h"

@implementation SecondListModel

@synthesize id1 = _id;

+(SecondListModel *)setBeanWithDictionary:(NSDictionary *)dic{
    
    SecondListModel *bean = [[SecondListModel alloc]init];
    
    [bean setValuesForKeysWithDictionary:dic];
    
    return bean;
}

+(NSArray *)setBeanWithArray:(NSArray *)array{
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        SecondListModel *bean = [SecondListModel setBeanWithDictionary:dic];
        
        [mArr addObject:bean];
    }
    
    return mArr;
}



@end
