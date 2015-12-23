//
//  ScrollViewDemo.h
//  TeacherAssess
//
//  Created by ma on 15/12/21.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface ScrollViewDemo : UIViewController
@property(nonatomic,strong)NSArray *photoArray;

@property(nonatomic,assign)CGRect scrollViewFrame;

@property(nonatomic,assign)CGFloat pageControlHeight;

@property(nonatomic,assign)BOOL isNotLocalImage;
@end
