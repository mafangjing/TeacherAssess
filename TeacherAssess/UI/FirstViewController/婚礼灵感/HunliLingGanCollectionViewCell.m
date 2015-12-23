//
//  HunliLingGanCollectionViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunliLingGanCollectionViewCell.h"

@implementation HunliLingGanCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCollectionCellWithDic:(NSDictionary *)dic{

    self.countLable.layer.cornerRadius = 5.0;
    self.countLable.clipsToBounds = YES;
    self.mainImageView.userInteractionEnabled = YES;
    self.nameLable.font = [UIFont boldSystemFontOfSize:13];
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"color_logo"]] placeholderImage:nil];
    self.nameLable.text = dic[@"color_name"];
    self.countLable.text = [NSString stringWithFormat:@"%@图",dic[@"count"]];



}


@end
