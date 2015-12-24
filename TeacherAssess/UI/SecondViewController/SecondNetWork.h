//
//  SecondNetWork.h
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SecondNetWork : NSObject

#pragma mark ---- 首页
+(void)getSecondDataWithUrl:(NSString *)url withPage:(NSString *)page;


#pragma mark ---- 下一页(SecondList）
+(void)getSecondListDatawithUrl:(NSString *)url category:(NSString *)category page:(NSString *)page sort:(NSString *)sort subject:(NSString *)subject;

#pragma mark ==== 具体商品详情页
+(void)GetSecondDetilaDataWithUrl:(NSString *)url idi:(NSString *)idi user_id:(NSString *)user_id;













+(void)getSecondDataWithUrl:(NSString *)Urlpath withPage:(NSString *)page WithBlock:(void(^)(NSDictionary *))block;



@end
