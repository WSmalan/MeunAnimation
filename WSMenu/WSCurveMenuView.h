//
//  WSCurveMenuView.h
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCurveMenuView : UIView

@property(nonatomic,strong) NSArray * menuItems;
@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic,assign) CGFloat nearDistance;
@property(nonatomic,assign) CGFloat farDistance;
@property(nonatomic,assign) CGFloat endDistance;

- (void)expend:(BOOL)isExpend;

- (void)setMenuItems:(NSArray *)menuItems;

@end
