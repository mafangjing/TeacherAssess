//
//  HunliLingGanNetwork.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HunliLingGanNetwork : NSObject

#pragma mark === 获取分组图片
+(void)GetHunliLingGanDataUrl:(NSString *)url act:(NSString *)act cate:(NSString *)cate mver:(NSString *)mver;

#pragma mark ==== 获取具体列表图片
+(void)GetHunliLingGanPhotoListDataWithUrl:(NSString *)url act:(NSString *)act cate:(NSString *)cate page:(NSString *)page pageper:(NSString *)pageper color:(NSString *)color mver:(NSString *)mver;

@end
