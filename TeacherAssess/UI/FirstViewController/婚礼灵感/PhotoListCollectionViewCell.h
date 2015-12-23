//
//  PhotoListCollectionViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoListCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

-(void)setPhotoListCellWithDic:(NSDictionary *)dic;


@end
