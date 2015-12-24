//
//  FouthVcModel.h
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FouthVcModel : NSObject

{

    NSString * _id;

}

@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * id1;
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * logo;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * operate;


+(FouthVcModel *)setBeanWithDictionary:(NSDictionary *)dic;


+(NSArray *)setBeanWithArray:(NSArray *)array;



@end
