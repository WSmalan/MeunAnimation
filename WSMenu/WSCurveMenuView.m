//
//  WSCurveMenuView.m
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import "WSCurveMenuView.h"
#import "WSCurveItemView.h"
#import "WSCurveMainView.h"
@interface WSCurveMenuView()
{
    WSCurveMainView * _mainView;
    BOOL _isExpend;
}
@property(nonatomic,assign) BOOL scale;


@end

@implementation WSCurveMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self configUI:frame];
        
    }
    return self;
}
//创建UI
- (void)configUI:(CGRect)frame{
    _mainView = [[WSCurveMainView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_mainView addTaget:self action:@selector(showOrShrink)];
    
    [self addSubview:_mainView ];
}
- (void)showOrShrink{
    if (_isExpend == NO) {
        [self expend:YES];
        [_mainView updateProgressWithNumber:80];
    }else{
        [self expend:NO];
        [_mainView updateProgressWithNumber:0];
    }
}
- (void)expend:(BOOL)isExpend{
    _isExpend = isExpend;
    
    [self.menuItems enumerateObjectsUsingBlock:^(WSCurveItemView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.scale) {
            if (isExpend) {
                obj.transform = CGAffineTransformIdentity;
            } else {
                obj.transform = CGAffineTransformMakeScale(0.001, 0.001);
            }
        }
        
        [self addRotateAndPostisionForItem:obj toShow:isExpend];
    }];
}

- (void)addRotateAndPostisionForItem:(WSCurveItemView * )item toShow:(BOOL)show{
   
        if (show) {
            CABasicAnimation *scaleAnimation = nil;
            if (self.scale) {
                scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                scaleAnimation.fromValue = [NSNumber numberWithFloat:0.2];
                scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
                scaleAnimation.duration = 0.5f;
                scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            }
            
            CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotateAnimation.values = @[@(M_PI), @(0.0)];
            rotateAnimation.duration = 0.5f;
            rotateAnimation.keyTimes = @[@(0.3), @(0.4)];
            
            CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            positionAnimation.duration = 0.5f;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
            CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
            CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y);
            CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
            positionAnimation.path = path;
            CGPathRelease(path);
            
            CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
            if (self.scale) {
                animationgroup.animations = @[scaleAnimation, positionAnimation, rotateAnimation];
            } else {
                animationgroup.animations = @[positionAnimation, rotateAnimation];
            }
            animationgroup.duration = 0.5f;
            animationgroup.fillMode = kCAFillModeForwards;
            animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [item.layer addAnimation:animationgroup forKey:@"Expand"];
            item.center = item.endPoint;
        } else {
            CABasicAnimation *scaleAnimation = nil;
            if (self.scale) {
                scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
                scaleAnimation.toValue = [NSNumber numberWithFloat:0.2];
                scaleAnimation.duration = 0.5f;
                scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            }
            
            CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotateAnimation.values = @[@0, @(M_PI * 2), @(0)];
            rotateAnimation.duration = 0.5f;
            rotateAnimation.keyTimes = @[@0, @(0.4), @(0.5)];
            CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            positionAnimation.duration = 0.5f;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
            CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
            CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
            positionAnimation.path = path;
            CGPathRelease(path);
            
            CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
            if (self.scale) {
                animationgroup.animations = @[scaleAnimation, positionAnimation, rotateAnimation];
            } else {
                animationgroup.animations = @[positionAnimation, rotateAnimation];
            }
            
            animationgroup.duration = 0.5f;
            animationgroup.fillMode = kCAFillModeForwards;
            animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [item.layer addAnimation:animationgroup forKey:@"Close"];
            item.center = item.startPoint;
    }
}
#pragma mark - 初始化数据
- (void)initData{
    self.scale = YES;
    _isExpend = NO;
    self.startPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    // 修改这时的参数来调整大圆与圆之间的距离
    self.nearDistance = 80;
    self.farDistance = 100;
    self.endDistance = 80;
    
    WSCurveItemView * v1 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    WSCurveItemView * v2 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    WSCurveItemView * v3 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    WSCurveItemView * v4 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    WSCurveItemView * v5 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    WSCurveItemView * v6 = [[WSCurveItemView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];

    NSArray * arr = @[v1,v2,v3,v4,v5,v6];
    self.menuItems = arr;
}
- (void)setMenuItems:(NSArray *)menuItems {
    if (_menuItems != menuItems) {
        _menuItems = menuItems;
        
        for (UIView *v in self.subviews) {
            if (v.tag >= 1000) {
                [v removeFromSuperview];
            }
        }
        // add the menu buttons
        int count = (int)[menuItems count];
        CGFloat cnt = 1;
        for (int i = 0; i < count; i ++) {
            WSCurveItemView *item = [menuItems objectAtIndex:i];
            item.tag = 1000 + i;
            item.startPoint = self.startPoint;
            CGFloat pi =  M_PI / count;
            CGFloat endRadius = item.bounds.size.width / 2 + self.endDistance + _mainView.bounds.size.width / 2;
            CGFloat nearRadius = item.bounds.size.width / 2 + self.nearDistance + _mainView.bounds.size.width / 2;
            CGFloat farRadius = item.bounds.size.width / 2 + self.farDistance + _mainView.bounds.size.width / 2;
            item.endPoint = CGPointMake(self.startPoint.x + endRadius * sinf(pi * cnt),
                                        self.startPoint.y - endRadius * cosf(pi * cnt));
            item.nearPoint = CGPointMake(self.startPoint.x + nearRadius * sinf(pi * cnt),
                                         self.startPoint.y - nearRadius * cosf(pi * cnt));
            item.farPoint = CGPointMake(self.startPoint.x + farRadius * sinf(pi * cnt),
                                        self.startPoint.y - farRadius * cosf(pi * cnt));
            item.center = item.startPoint;
            [self addSubview:item];
            
            cnt += 2;
        }
        
        [self bringSubviewToFront:_mainView];
    }
}




@end
