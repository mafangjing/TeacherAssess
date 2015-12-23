//
//  ThirdNetWork.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdNetWork : NSObject


+(void)getThirdAdDataWithUrl:(NSString *)AdUrl;

+(void)getThirdFenZuDataWithUrl:(NSString *)Url;



+(void)getThirdDetilaDataWithfid:(NSString *)fid top:(NSString *)top page:(NSString *)page orderby:(NSString *)orderby mver:(NSString *)mver;

+(void)getThirdDetilaPingLunDataWithUrl:(NSString *)url tid:(NSString *)tid authorid:(NSString *)authorid ordertype:(NSString *)ordertype mver:(NSString *)mver;

@end
