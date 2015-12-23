//
//  HunliLingGanCollectionViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HunliLingGanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;


-(void)setCollectionCellWithDic:(NSDictionary *)dic;


@end
