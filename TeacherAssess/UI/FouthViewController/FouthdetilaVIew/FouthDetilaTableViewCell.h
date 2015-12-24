//
//  FouthDetilaTableViewCell.h
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FouthDetilaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoimageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLable;

@property (weak, nonatomic) IBOutlet UILabel *oldPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *zuiJinSCLable;
@property (weak, nonatomic) IBOutlet UILabel *RenQiLable;


-(void)setCellWithDic:(NSDictionary *)dict;


@end
