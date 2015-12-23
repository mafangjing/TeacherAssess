//
//  HunJiaTableViewCell.h
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HunJiaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *FirstLable;
@property (weak, nonatomic) IBOutlet UILabel *SecondLable;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLable;

-(void)setcellwithDic:(NSDictionary *)dic;


@end
