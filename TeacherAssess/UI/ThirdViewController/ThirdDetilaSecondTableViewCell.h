//
//  ThirdDetilaSecondTableViewCell.h
//  Wedding
//
//  Created by qianfeng on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdDetilaSecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLable;
@property (weak, nonatomic) IBOutlet UILabel *DateLable;
@property (weak, nonatomic) IBOutlet UILabel *JiLouLable;
@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;



-(void)setCellWithDic:(NSDictionary *)dict;

@end
