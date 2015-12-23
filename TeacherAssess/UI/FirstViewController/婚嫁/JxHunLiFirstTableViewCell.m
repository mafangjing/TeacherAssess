//
//  JxHunLiFirstTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "JxHunLiFirstTableViewCell.h"

@implementation JxHunLiFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellwithDic:(NSDictionary *)dic{

    NSLog(@"%@",dic);
    
    self.BGImageView.layer.cornerRadius = 5.0;
    self.BGImageView.clipsToBounds = YES;
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"default_image"]] placeholderImage:nil];
    self.jxhlNameLable.text = dic[@"hxjx_name"];
    self.CompanyLable.text = dic[@"company_name"];
    self.DetilaLable.text = dic[@"description"];
}



@end
