//
//  ThirdDetilaFirstCellTableViewCell.h
//  Wedding
//
//  Created by qianfeng on 15-12-22.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdDetilaFirstCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable1;
@property (weak, nonatomic) IBOutlet UILabel *countLable2;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

-(void)setCellWithDic:(NSDictionary *)dic index:(NSInteger)index;



@end
