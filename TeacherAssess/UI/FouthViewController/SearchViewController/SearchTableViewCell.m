//
//  SearchTableViewCell.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWithBean:(FouthVcModel *)bean{
    
    self.FirstLable.text = bean.name;
    self.SecondLable.text = bean.address;
    self.ThirdLable.text = bean.operate;
    [self.mainImageView setImageWithURL:[NSURL URLWithString:bean.logo] placeholderImage:nil];
}


//-(void)setSearchCellWithdic:(NSDictionary *)dic{
//
//    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:nil];
//    self.FirstLable.text = dic[@"name"];
//    self.SecondLable.text = dic[@"address"];
//    self.ThirdLable.text = dic[@"operate"];
//    
//
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
