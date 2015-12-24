//
//  SecondListModel.h
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondListModel : NSObject

{
    
    NSString * _id;
    
}

@property(nonatomic,copy)NSString *id1;
@property(nonatomic,copy)NSString *photo_path;
@property(nonatomic,copy)NSString *like_account;
@property(nonatomic,copy)NSString *width;
@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *subject_desc;


+(SecondListModel *)setBeanWithDictionary:(NSDictionary *)dic;


+(NSArray *)setBeanWithArray:(NSArray *)array;


@end
