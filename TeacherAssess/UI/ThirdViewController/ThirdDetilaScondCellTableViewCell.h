//
//  ThirdDetilaScondCellTableViewCell.h
//  Wedding
//
//  Created by qianfeng on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdDetilaScondCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *useImageView;
@property (weak, nonatomic) IBOutlet UILabel *useNameLable;
@property (weak, nonatomic) IBOutlet UILabel *DateLable;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLable;


-(void)setCellWithDict:(NSDictionary *)dict;



@end
