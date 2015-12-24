//
//  SecondVcModel.h
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondVcModel : NSObject

{

    NSString * _id;

}

@property(nonatomic,copy)NSString *id1;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *cover_path;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *bkg_path;


+(SecondVcModel *)setBeanWithDictionary:(NSDictionary *)dic;


+(NSArray *)setBeanWithArray:(NSArray *)array;


@end
