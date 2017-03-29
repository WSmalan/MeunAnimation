//
//  WSCurveMainView.m
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import "WSCurveMainView.h"
#define kLineWidth  5
@implementation WSCurveMainView
- (void)addTaget:(id)taget action:(SEL)action{
    self.userInteractionEnabled = YES;
    self.taget = taget;
    self.action = action;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.taget != nil&&[self.taget  respondsToSelector:self.action]) {
        [self.taget  performSelector:self.action withObject:self];
    }else{
        NSLog(@"没有实现方法");
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.layer.cornerRadius = frame.size.height/2;
        [self configUI:frame];
    }
    return self;
}

- (void)configUI:(CGRect)frame {
    //初始化label
    _percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.width/2 - 20/2, frame.size.width, 20)];
    _percentLabel.backgroundColor = [UIColor clearColor];
    _percentLabel.text = @"0%";
    _percentLabel.textAlignment = NSTextAlignmentCenter;
//    _percentLabel.center = self.center;
    [self addSubview:_percentLabel];
    
    //默认的白色底部
    self.outLayer = [CAShapeLayer layer];
    CGRect rect = {kLineWidth / 2, kLineWidth / 2, frame.size.width - kLineWidth, frame.size.height - kLineWidth};
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.outLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.outLayer.lineWidth = kLineWidth;
    self.outLayer.fillColor =  [UIColor clearColor].CGColor;
    self.outLayer.lineCap = kCALineCapRound;
    self.outLayer.path = path.CGPath;
    [self.layer addSublayer:self.outLayer];
    
    
    //进度条的实现
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineWidth = kLineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeEnd = 0;
    self.progressLayer.path = path.CGPath;
    
    
    
    //实现渐变图层
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    //实现渐变图层
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, width / 2, height);
    CGColorRef red = [UIColor redColor].CGColor;
    CGColorRef purple = [UIColor purpleColor].CGColor;
    CGColorRef yellow = [UIColor yellowColor].CGColor;
    CGColorRef orange = [UIColor orangeColor].CGColor;
    [gradientLayer1 setColors:@[(__bridge id)red, (__bridge id)purple, (__bridge id)yellow, (__bridge id)orange]];
    [gradientLayer1 setLocations:@[@0.3, @0.6, @0.8, @1.0]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(width / 2, 0, width / 2, height);
    CGColorRef blue = [UIColor brownColor].CGColor;
    CGColorRef purple1 = [UIColor purpleColor].CGColor;
    CGColorRef r1 = [UIColor yellowColor].CGColor;
    CGColorRef o1 = [UIColor orangeColor].CGColor;
    [gradientLayer2 setColors:@[(__bridge id)blue, (__bridge id)purple1, (__bridge id)r1, (__bridge id)o1]];
    [gradientLayer2 setLocations:@[@0.3, @0.6, @0.8, @1.0]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer addSublayer:gradientLayer1];
    [gradientLayer addSublayer:gradientLayer2];
    gradientLayer.mask = self.progressLayer;
    [self.layer addSublayer:gradientLayer];
}

- (void)updateProgressWithNumber:(NSUInteger)number {
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.progressLayer.strokeEnd =  number / 100.0;
    self.percentLabel.text = [NSString stringWithFormat:@"%@%%", @(number)];
    [CATransaction commit];
}

@end
