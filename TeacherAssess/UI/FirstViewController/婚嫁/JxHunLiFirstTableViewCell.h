//
//  JxHunLiFirstTableViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JxHunLiFirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *jxhlNameLable;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLable;
@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;
@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;


-(void)setcellwithDic:(NSDictionary *)dic;


@end
