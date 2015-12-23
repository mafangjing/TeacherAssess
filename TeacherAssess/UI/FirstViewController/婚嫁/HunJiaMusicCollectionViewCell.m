//
//  HunJiaMusicCollectionViewCell.m
//  Wedding
//
//  Created by hjh on 15-10-9.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunJiaMusicCollectionViewCell.h"

@implementation HunJiaMusicCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWithDic:(NSDictionary *)dic{
    
//    self.mainImageView.layer.cornerRadius = 10.0;
//    self.mainImageView.clipsToBounds = YES;
    self.TitleLable.text = dic[@"name"];
    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:nil];
    
}




@end
