//
//  ThirdDetilafirstTableViewCell.m
//  Wedding
//
//  Created by hjh on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdDetilafirstTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ThirdDetilafirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}






-(void)setWithDic:(NSDictionary *)dict{

    self.useImageView.layer.cornerRadius = 20.0;
    self.useImageView.clipsToBounds = YES;
    [self.useImageView setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:nil];
    self.TitleLable.text = dict[@"subject"];
    self.useNameLable.text = dict[@"author"];
    self.dateLable.text = dict[@"lastpost"];
    self.commentCountLable.text = dict[@"replies"];
    self.DetilaLable.text = dict[@"message"];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
