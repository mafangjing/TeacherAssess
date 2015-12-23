//
//  ThirdDetilaSecondTableViewCell.m
//  Wedding
//
//  Created by qianfeng on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdDetilaSecondTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ThirdDetilaSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWithDic:(NSDictionary *)dict{

    self.logoImageView.layer.cornerRadius = 20.0;
    self.logoImageView.clipsToBounds = YES;
    [self.logoImageView setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:nil];
    self.NameLable.text = dict[@"author"];
    self.DateLable.text = dict[@"dateline"];
    self.DetilaLable.text = dict[@"message"];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
