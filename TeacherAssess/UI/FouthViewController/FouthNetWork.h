//
//  FouthNetWork.h
//  Wedding
//
//  Created by ma on 15-12-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FouthNetWork : NSObject

+(void)getFouthdataWithUrl:(NSString *)url appkey:(NSString *)appkey page:(NSString *)page pid:(NSString *)pid;




+(void)getFouthDetilaDataWithUrl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi;



+(void)getCanPinDataWithUrl:(NSString *)url appkey:(NSString *)appkey pid:(NSString *)pid page:(NSString *)page;


+(void)getFouthCanPinDetilaDataWithUrl:(NSString *)url appkey:(NSString *)appkey idi:(NSString *)idi token:(NSString *)token;


+(void)getSearchDataWithUrl:(NSString *)url appkey:(NSString *)appkey keyword:(NSString *)keyword;


@end
