//
//  HomeViewController.m
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/14.
//  Copyright © 2019年 cs. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "NeedLoadViewController.h"

@interface HomeViewController ()
/** debug */
@property(nonatomic,assign)UILabel *debugLbe;
/** array*/
@property(nonatomic,assign)NSArray *array;  // 注意用assign修饰
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self drawUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.debugLbe.text = @"齐天大圣";
}

- (void)drawUI {
    // 约束布局实现
    UILabel *normalLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    normalLbe.textColor = [UIColor blackColor];
    normalLbe.text = @"约束布局实现";
    normalLbe.textAlignment = NSTextAlignmentCenter;
    normalLbe.backgroundColor = [UIColor orangeColor];
    [normalLbe onTap:self action:@selector(tapNormalLbe)];
    [self.view addSubview:normalLbe];
    
    [normalLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(normalLbe.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    // 按需加载
    UILabel *needLoadLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    needLoadLbe.textColor = [UIColor blackColor];
    needLoadLbe.text = @"按需加载";
    needLoadLbe.textAlignment = NSTextAlignmentCenter;
    needLoadLbe.backgroundColor = [UIColor orangeColor];
    [needLoadLbe onTap:self action:@selector(tapNeedLoad)];
    [self.view addSubview:needLoadLbe];
    
    [needLoadLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(needLoadLbe.size);
        make.top.equalTo(normalLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // 断点测试
    UILabel *debugLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    debugLbe.textColor = [UIColor blackColor];
    debugLbe.text = @"移除 Debug调试测试";
    debugLbe.textAlignment = NSTextAlignmentCenter;
    debugLbe.backgroundColor = [UIColor orangeColor];
    [debugLbe onTap:self action:@selector(tapDebugLbe)];
    [self.view addSubview:debugLbe];
    self.debugLbe = debugLbe;

    [debugLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(debugLbe.size);
        make.top.equalTo(needLoadLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)tapNormalLbe {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapNeedLoad {
    NeedLoadViewController *vc = [[NeedLoadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapDebugLbe {
    NSLog(@"点击了 Debug调试测试 按钮");
    [self.debugLbe removeFromSuperview];
    
    
}

@end
