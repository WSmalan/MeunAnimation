//
//  WSCurveItemView.m
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import "WSCurveItemView.h"
@interface WSCurveItemView()

@property(nonatomic,strong) UIImageView * bgImageView;

@end
@implementation WSCurveItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        UIImage * image = [UIImage imageNamed:@"snow.jpeg"];
        self.layer.contents = (__bridge id _Nullable)(image.CGImage);
        
//        [self initData];
//        [self configUI:frame];
    }
    return self;
}

//布局
- (void)configUI: (CGRect)frame{
    self.bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ss"]];
    self.bgImageView.frame = frame;
    [self addSubview:self.bgImageView];
}
#pragma mark - 数据初始化
- (void)initData{
    self.startPoint = self.center;


}
@end
