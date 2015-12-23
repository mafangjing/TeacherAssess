//
//  HunJiaMusicCollectionViewCell.h
//  Wedding
//
//  Created by hjh on 15-10-9.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HunJiaMusicCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;

-(void)setCellWithDic:(NSDictionary *)dic;


@end
