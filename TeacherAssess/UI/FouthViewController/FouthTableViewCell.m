//
//  FouthTableViewCell.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "FouthTableViewCell.h"

@implementation FouthTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWithBean:(FouthVcModel *)bean{

    self.TitleLable.text = bean.name;
    self.addressLable.text = bean.address;
    self.numberLable.text = bean.operate;
    [self.mainImageView setImageWithURL:[NSURL URLWithString:bean.logo] placeholderImage:nil];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
