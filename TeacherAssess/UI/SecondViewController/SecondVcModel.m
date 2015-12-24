//
//  SecondVcModel.m
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondVcModel.h"

@implementation SecondVcModel

@synthesize id1 = _id;

+(SecondVcModel *)setBeanWithDictionary:(NSDictionary *)dic{
    
    SecondVcModel *bean = [[SecondVcModel alloc]init];
    
    [bean setValuesForKeysWithDictionary:dic];
    
    return bean;
}

+(NSArray *)setBeanWithArray:(NSArray *)array{
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        SecondVcModel *bean = [SecondVcModel setBeanWithDictionary:dic];
        
        [mArr addObject:bean];
    }
    
    return mArr;
}


@end
