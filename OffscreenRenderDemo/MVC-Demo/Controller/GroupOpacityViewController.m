//
//  GroupOpacityViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/30.
//  Copyright © 2019 cs. All rights reserved.
//

#import "GroupOpacityViewController.h"

@interface GroupOpacityViewController ()

@end

@implementation GroupOpacityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"GroupOpacity";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawRedView];
    [self drawGreenView];
    [self drawBlueView];
}

- (void)drawRedView {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    redView.alpha = 0.5;
    redView.backgroundColor = [UIColor grayColor];
    redView.layer.allowsGroupOpacity = NO;
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(redView.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    // 子视图
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    subView.backgroundColor = [UIColor whiteColor];
    [redView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(subView.size);
        make.centerX.centerY.equalTo(redView);
    }];
}

- (void)drawGreenView {
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    greenView.alpha = 0.5;
    greenView.backgroundColor = [UIColor grayColor];
    greenView.layer.allowsGroupOpacity = YES;
    [self.view addSubview:greenView];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(greenView.size);
        make.top.equalTo(self.view.mas_top).offset(200);
        make.centerX.equalTo(self.view);
    }];
    
    // 子视图
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    subView.backgroundColor = [UIColor whiteColor];
    [greenView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(subView.size);
        make.centerX.centerY.equalTo(greenView);
    }];
}

- (void)drawBlueView {
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    blueView.alpha = 0.5;
    blueView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:blueView];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(blueView.size);
        make.top.equalTo(self.view.mas_top).offset(300);
        make.centerX.equalTo(self.view);
    }];
    
    // 子视图
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    subView.backgroundColor = [UIColor whiteColor];
    [blueView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(subView.size);
        make.centerX.centerY.equalTo(blueView);
    }];
}

@end
