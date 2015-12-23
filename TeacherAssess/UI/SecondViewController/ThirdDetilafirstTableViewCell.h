//
//  ThirdDetilafirstTableViewCell.h
//  Wedding
//
//  Created by hjh on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"

@interface ThirdDetilafirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *useImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;

@property (weak, nonatomic) IBOutlet UILabel *useNameLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLable;
@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;

-(void)setWithDic:(NSDictionary *)dict;

@end
