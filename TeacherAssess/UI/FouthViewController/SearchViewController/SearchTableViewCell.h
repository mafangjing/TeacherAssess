//
//  SearchTableViewCell.h
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FouthVcModel.h"

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *FirstLable;
@property (weak, nonatomic) IBOutlet UILabel *SecondLable;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLable;


-(void)setCellWithBean:(FouthVcModel *)bean;

@end
