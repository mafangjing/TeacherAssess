//
//  thirdLocalData.h
//  Wedding
//
//  Created by hjh on 15-12-22.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface thirdLocalData : NSObject


//插入数据
+(void)setLocalDataWithDic:(NSDictionary *)dic;
//读取本地数据
+(NSArray *)GetLocalDataArray;


@end
