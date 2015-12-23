//
//  HunTuNetWork.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HunTuNetWork : NSObject


+(void)GetHunTuDataWithUrl:(NSString *)url lastid:(NSString *)lastid resolution:(NSString *)resolution pageflag:(NSString *)pageflag ctypeid:(NSString *)ctypeid itypeid:(NSString *)itypeid goodsid:(NSString *)goodsid;



@end
