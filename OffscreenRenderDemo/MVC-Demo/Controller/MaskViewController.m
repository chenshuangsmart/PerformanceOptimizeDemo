//
//  MaskViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/30.
//  Copyright © 2019 cs. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()

@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Mask 遮罩";
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawUI];
}

- (void)drawUI {
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    iconImgV.image = [UIImage imageNamed:@"icon_girl"];
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgV.size);
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    // 方法一 设置Mask - 使用图片
//    if (@available(iOS 8.0, *)) {
//        iconImgV.maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RoundMask"]];
//    } else {
//        CALayer *maskLayer = [[CALayer alloc] init];
//        maskLayer.frame = iconImgV.bounds;
//        maskLayer.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"RoundMask"] CGImage]);
//        iconImgV.layer.mask = maskLayer;
//    }
    
    // 方法二 使用 CAShapeLayer 来指定混合的路径。
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:iconImgV.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.path = roundedRectPath.CGPath;
    iconImgV.layer.mask = shapLayer;

    
}

@end
