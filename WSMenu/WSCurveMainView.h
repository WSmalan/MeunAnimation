//
//  WSCurveMainView.h
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCurveMainView : UIView

@property (nonatomic, strong) CAShapeLayer * outLayer;
@property (nonatomic, strong) CAShapeLayer * progressLayer;//最近的距离
@property(nonatomic,strong) UILabel * percentLabel;//进度的显示

@property(nonatomic,assign) id taget;
@property(nonatomic,assign) SEL action;
- (void)updateProgressWithNumber:(NSUInteger)number;
- (void)addTaget:(id)taget action:(SEL)action;

@end
