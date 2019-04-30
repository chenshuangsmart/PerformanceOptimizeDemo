//
//  EdgeAntialiasingViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/30.
//  Copyright © 2019 cs. All rights reserved.
//

#import "EdgeAntialiasingViewController.h"

@interface EdgeAntialiasingViewController ()

@end

@implementation EdgeAntialiasingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"EdgeAntialiasing";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawUI];
}

- (void)drawUI {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    redView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:redView];
    
    // EdgeAntialiasing
    redView.layer.allowsEdgeAntialiasing = YES;
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(redView.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
}

@end
