//
//  ViewController.m
//  WSMenu
//
//  Created by SongLan on 2017/3/12.
//  Copyright © 2017年 Asong. All rights reserved.
//

#import "ViewController.h"
#import "WSCurveMenuView.h"
@interface ViewController ()
@property(nonatomic,strong) WSCurveMenuView  * menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.menuView = [[WSCurveMenuView alloc]initWithFrame:CGRectMake(self.view.center.x - 100/2, self.view.center.y- 100/2, 100, 100)];
    [self.view addSubview:self.menuView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
