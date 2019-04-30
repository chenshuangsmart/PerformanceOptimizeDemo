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
#import "ShadowViewController.h"
#import "MaskViewController.h"
#import "GroupOpacityViewController.h"
#import "EdgeAntialiasingViewController.h"

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
    normalLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    normalLbe.layer.borderWidth = 0.5;
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
    needLoadLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    needLoadLbe.layer.borderWidth = 0.5;
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
    cornusLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    cornusLbe.layer.borderWidth = 0.5;
    [cornusLbe onTap:self action:@selector(tapCornusLbe)];
    [self.view addSubview:cornusLbe];
    
    [cornusLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(cornusLbe.size);
        make.top.equalTo(needLoadLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // shadow
    UILabel *shadowLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    shadowLbe.textColor = [UIColor blackColor];
    shadowLbe.text = @"shadow 阴影";
    shadowLbe.textAlignment = NSTextAlignmentCenter;
    shadowLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    shadowLbe.layer.borderWidth = 0.5;
    [shadowLbe onTap:self action:@selector(tapShadowLbe)];
    [self.view addSubview:shadowLbe];

    [shadowLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(shadowLbe.size);
        make.top.equalTo(cornusLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // mask
    UILabel *maskLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    maskLbe.textColor = [UIColor blackColor];
    maskLbe.text = @"Mask 遮罩";
    maskLbe.textAlignment = NSTextAlignmentCenter;
    maskLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    maskLbe.layer.borderWidth = 0.5;
    [maskLbe onTap:self action:@selector(tapMaskLbe)];
    [self.view addSubview:maskLbe];
    
    [maskLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(maskLbe.size);
        make.top.equalTo(shadowLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // GroupOpacity
    UILabel *groupOpacityLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    groupOpacityLbe.textColor = [UIColor blackColor];
    groupOpacityLbe.text = @"GroupOpacity";
    groupOpacityLbe.textAlignment = NSTextAlignmentCenter;
    groupOpacityLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    groupOpacityLbe.layer.borderWidth = 0.5;
    [groupOpacityLbe onTap:self action:@selector(tapGroupOpacityLbe)];
    [self.view addSubview:groupOpacityLbe];
    
    [groupOpacityLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(groupOpacityLbe.size);
        make.top.equalTo(maskLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // EdgeAntialiasing
    UILabel *edgeAntialiasingLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    edgeAntialiasingLbe.textColor = [UIColor blackColor];
    edgeAntialiasingLbe.text = @"EdgeAntialiasing";
    edgeAntialiasingLbe.textAlignment = NSTextAlignmentCenter;
    edgeAntialiasingLbe.layer.borderColor = [[UIColor grayColor] CGColor];
    edgeAntialiasingLbe.layer.borderWidth = 0.5;
    [edgeAntialiasingLbe onTap:self action:@selector(tapEdgeAntialiasingLbe)];
    [self.view addSubview:edgeAntialiasingLbe];
    
    [edgeAntialiasingLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(edgeAntialiasingLbe.size);
        make.top.equalTo(groupOpacityLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - action

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

- (void)tapShadowLbe {
    ShadowViewController *vc = [[ShadowViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapMaskLbe {
    MaskViewController *vc = [[MaskViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapGroupOpacityLbe {
    GroupOpacityViewController *vc = [[GroupOpacityViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapEdgeAntialiasingLbe {
    EdgeAntialiasingViewController *vc = [[EdgeAntialiasingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
