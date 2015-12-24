//
//  SecondMainTableViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondVcModel.h"

@interface SecondMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;

@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;

-(void)setCellWithBean:(SecondVcModel *)bean;


@end
