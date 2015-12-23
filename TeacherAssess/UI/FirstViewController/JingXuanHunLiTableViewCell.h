//
//  JingXuanHunLiTableViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingXuanHunLiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MainImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *ReadCountLable;
@property (weak, nonatomic) IBOutlet UILabel *ShareCountLable;
@property (weak, nonatomic) IBOutlet UILabel *AuthorLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;


-(void)setJXHLCellWithDic:(NSDictionary *)dic;


@end
