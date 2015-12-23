//
//  HunJiaTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunJiaTableViewCell.h"

@implementation HunJiaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setcellwithDic:(NSDictionary *)dic{

    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:nil];
    self.FirstLable.text = dic[@"name"];
    self.SecondLable.text = dic[@"digest"];
    self.ThirdLable.text = dic[@"time"];


}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
