//
//  WSCurveItemView.h
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCurveItemView : UIView

@property (nonatomic, assign) CGPoint startPoint;//开始的位置
@property (nonatomic, assign) CGPoint endPoint;//结束的位置
@property (nonatomic, assign) CGPoint nearPoint;//最近的距离
@property (nonatomic, assign) CGPoint farPoint;//最远的距离

@end
