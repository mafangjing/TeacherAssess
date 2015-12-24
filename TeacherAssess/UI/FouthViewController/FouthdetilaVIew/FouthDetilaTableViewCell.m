//
//  FouthDetilaTableViewCell.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "FouthDetilaTableViewCell.h"

@implementation FouthDetilaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWithDic:(NSDictionary *)dict{

    [self.logoimageView setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:nil];
    self.nameLable.text = dict[@"name"];
    self.nowPriceLable.text = [NSString stringWithFormat:@"¥%@",dict[@"price"]];
    self.oldPriceLable.text = [NSString stringWithFormat:@"¥%@",dict[@"price_yj"]];
self.zuiJinSCLable.text = [NSString stringWithFormat:@"最近售出：%@",dict[@"shiyong"]];
    self.RenQiLable.text = [NSString stringWithFormat:@"人气：%@",dict[@"renqi"]];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
