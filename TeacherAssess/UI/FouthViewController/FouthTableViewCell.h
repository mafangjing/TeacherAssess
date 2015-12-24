//
//  FouthTableViewCell.h
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FouthVcModel.h"
@interface FouthTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *numberLable;


-(void)setCellWithBean:(FouthVcModel *)bean;

@end
