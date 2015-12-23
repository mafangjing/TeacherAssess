//
//  ThirdDetilaScondCellTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdDetilaScondCellTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ThirdDetilaScondCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellWithDict:(NSDictionary *)dict{

    self.useImageView.layer.cornerRadius = 20.0;
    self.useImageView.clipsToBounds = YES;
    [self.useImageView setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:nil];
    self.useNameLable.text = dict[@"author"];
    self.DateLable.text = dict[@"dateline"];
    self.TitleLable.text = dict[@"subject"];
    self.DetilaLable.text = dict[@"message"];
    self.commentCountLable.text = dict[@"replies"];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
