//
//  LianXiTableViewCell.m
//  Wedding
//
//  Created by ma on 15-12-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "LianXiTableViewCell.h"

@implementation LianXiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setLianXiCellWithstring:(NSString *)string photostring:(NSString *)photostring{
    self.mainlable.text = string;
    self.RightImage.image = [UIImage imageNamed:photostring];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
