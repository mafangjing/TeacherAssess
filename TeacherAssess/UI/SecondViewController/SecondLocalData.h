//
//  SecondLocalData.h
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondLocalData : NSObject


//插入数据
+(void)setLocalDataWithDic:(NSDictionary *)dic;
//读取本地数据
+(NSArray *)GetLocalDataArray;


@end
