//
//  PhotoListCollectionViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "PhotoListCollectionViewCell.h"

@implementation PhotoListCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setPhotoListCellWithDic:(NSDictionary *)dic{

    self.mainImageView.layer.cornerRadius = 8.0;
    self.mainImageView.clipsToBounds = YES;
    self.mainImageView.userInteractionEnabled = YES;
    [self.mainImageView setImageWithURL:[NSURL URLWithString:dic[@"image_url"]] placeholderImage:nil];

}


@end
