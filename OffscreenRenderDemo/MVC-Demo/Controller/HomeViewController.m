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
#import "FPSViewer.h"
#import "CalculateCellHeightViewController.h"
#import "RadiusViewController.h"

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
    
    FPSViewer *fpsView = [[FPSViewer alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    fpsView.center = CGPointMake(kScreenWidth * 0.5, 40);
    [[UIApplication sharedApplication].keyWindow addSubview:fpsView];
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
    
    // UILabel, UITextField, UITextView实现圆角
    UILabel *cornusLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    cornusLbe.textColor = [UIColor blackColor];
    cornusLbe.text = @"UILabel, UITextField, UITextView圆角";
    cornusLbe.textAlignment = NSTextAlignmentCenter;
    cornusLbe.backgroundColor = [UIColor orangeColor];
    [cornusLbe onTap:self action:@selector(tapCornusLbe)];
    [self.view addSubview:cornusLbe];
    
    [cornusLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(cornusLbe.size);
        make.top.equalTo(needLoadLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // 断点测试
//    UILabel *calculCellHeightLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    calculCellHeightLbe.textColor = [UIColor blackColor];
//    calculCellHeightLbe.text = @"缓存 Cell 高度";
//    calculCellHeightLbe.textAlignment = NSTextAlignmentCenter;
//    calculCellHeightLbe.backgroundColor = [UIColor orangeColor];
//    [calculCellHeightLbe onTap:self action:@selector(tapCalculCellHeightLbe)];
//    [self.view addSubview:calculCellHeightLbe];
//
//    [calculCellHeightLbe mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(calculCellHeightLbe.size);
//        make.top.equalTo(needLoadLbe.mas_bottom).offset(50);
//        make.centerX.equalTo(self.view);
//    }];
}

- (void)tapNormalLbe {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapNeedLoad {
    NeedLoadViewController *vc = [[NeedLoadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapCalculCellHeightLbe {
    CalculateCellHeightViewController *vc = [[CalculateCellHeightViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapCornusLbe {
    RadiusViewController *vc = [[RadiusViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
