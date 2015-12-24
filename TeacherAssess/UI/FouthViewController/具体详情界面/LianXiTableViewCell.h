//
//  LianXiTableViewCell.h
//  Wedding
//
//  Created by ma on 15-12-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LianXiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *RightImage;
@property (weak, nonatomic) IBOutlet UILabel *mainlable;

-(void)setLianXiCellWithstring:(NSString *)string photostring:(NSString *)photostring;

@end
