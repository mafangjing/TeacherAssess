//
//  SecondMainTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondMainTableViewCell.h"

@implementation SecondMainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellWithBean:(SecondVcModel *)bean{

    [self.mainImageView setImageWithURL:[NSURL URLWithString:bean.cover_path] placeholderImage:nil];
    self.TitleLable.text = bean.title;
    self.DetilaLable.text = bean.desc;
}



@end
