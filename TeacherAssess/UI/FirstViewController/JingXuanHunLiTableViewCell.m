//
//  JingXuanHunLiTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "JingXuanHunLiTableViewCell.h"

@implementation JingXuanHunLiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setJXHLCellWithDic:(NSDictionary *)dic{

    [self.MainImageView setImageWithURL:[NSURL URLWithString:dic[@"default_image"]] placeholderImage:nil];
    self.TitleLable.text = dic[@"hxjx_name"];
    self.AuthorLable.text = dic[@"company_name"];

    self.ReadCountLable.text = [NSString stringWithFormat:@"%@ 阅读",dic[@"views"]];
    self.ShareCountLable.text = [NSString stringWithFormat:@"%@ 分享",dic[@"points"]];

}


@end
