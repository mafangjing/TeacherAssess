//
//  FouthLocalData.h
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FouthLocalData : NSObject


//插入数据
+(void)setLocalDataWithDic:(NSDictionary *)dic;
//读取本地数据
+(NSArray *)GetLocalDataArray;


@end
