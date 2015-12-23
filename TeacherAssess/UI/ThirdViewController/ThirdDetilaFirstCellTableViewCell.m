//
//  ThirdDetilaFirstCellTableViewCell.m
//  Wedding
//
//  Created by qianfeng on 15-12-22.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdDetilaFirstCellTableViewCell.h"

@implementation ThirdDetilaFirstCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellWithDic:(NSDictionary *)dic index:(NSInteger)index{

    self.mainImageView.layer.cornerRadius = 25.0;
    self.mainImageView.clipsToBounds = YES;
    self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
    self.TitleLable.text = dic[@"name"];
    self.countLable1.text = dic[@"threads"];
    self.countLable2.text = dic[@"posts"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
