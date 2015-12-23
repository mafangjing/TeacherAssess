//
//  HLSPTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HLSPTableViewCell.h"

@implementation HLSPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellWithDic:(NSDictionary *)dic{

    NSInteger time = [dic[@"jxsp_duration"]integerValue];
    NSInteger fen = time /60;
    NSInteger miao = (time - fen * 60) % 60;
    NSString * timeString = [NSString stringWithFormat:@"%ld分%ld秒",(long)fen,(long)miao];
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"default_image"]] placeholderImage:nil];
    self.nameLable.text = dic[@"hxjx_name"];
    self.dateLable.text = dic[@"jxsp_date"];
    self.teamNameLable.text = dic[@"team_name"];
    self.countLable.text = [NSString stringWithFormat:@"%@ 播放",dic[@"views"]];
    self.TimeLable.text = timeString;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
