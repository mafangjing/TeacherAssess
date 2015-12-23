//
//  FirstNetWork.h
//  Wedding
//
//  Created by hjh on 15-10-4.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstNetWork : NSObject

+(void)getFirstAdDataWithUrl:(NSString *)AdUrl;



+(void)GetFirstJingXuanDataWithUrl:(NSString *)url;


+(void)GetShiPingDetialDataUrlWithUrl:(NSString *)url act:(NSString *)act hxjx:(NSString *)hxjx mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper;
#pragma mark ==== 更多视屏网络请求
+(void)getGengDuoShiPingDataWithUrl:(NSString *)url act:(NSString *)act type:(NSString *)type mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper;
#pragma mark ==== 更多婚礼网络请求

+(void)getGengDuoHunLiDataWithUrl:(NSString *)url act:(NSString *)act type:(NSString *)type mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper;




+(void)getHunJiaDataWithUrl:(NSString *)url appkey:(NSString *)appkey pid:(NSString *)pid page:(NSString *)page;

+(void)getHunJiaDetilaDatawithurl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi;


#pragma mark === 获得音乐列表
+(void)getMusicDataWithUrl:(NSString *)url;

#pragma mark === 获得每种音乐的详细列表
+(void)getDetilaMusicDataWith:(NSString *)url mtid:(NSString *)mtid pageflag:(NSString *)pageflag lastid:(NSString *)lastid;



//*******************************************
#pragma mark === 婚嫁搜索

+(void)GetHUnJiaSearchDataWithUrl:(NSString *)url appkey:(NSString *)appkey keyword:(NSString *)keyword;


//*******************************************

//精选婚礼详细
+(void)GetJXHunLiDetilaDataWithUrl:(NSString *)url act:(NSString *)act hxjx:(NSString *)hxjx mver:(NSString *)mver page:(NSString *)page pageper:(NSString *)pageper;



@end
