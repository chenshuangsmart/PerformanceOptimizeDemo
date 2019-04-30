//
//  ShadowViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/29.
//  Copyright © 2019 cs. All rights reserved.
//

#import "ShadowViewController.h"

@interface ShadowViewController ()

@end

@implementation ShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawUI];
}

- (void)drawUI {
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    iconImgV.image = [UIImage imageNamed:@"icon_girl"];
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgV.size);
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    // 设置阴影
    CALayer *imageViewLayer = iconImgV.layer;
    imageViewLayer.shadowColor = [[UIColor blackColor] CGColor];
    imageViewLayer.shadowOpacity = 1.0; //此参数默认为0，即阴影不显示
    imageViewLayer.shadowRadius = 2.0; //给阴影加上圆角，对性能无明显影响
    imageViewLayer.shadowOffset = CGSizeMake(5, 5);
    //设定路径：与视图的边界相同
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:iconImgV.bounds];
    imageViewLayer.shadowPath = path.CGPath;//路径默认为 nil
    
    imageViewLayer.cornerRadius = 10;
    imageViewLayer.masksToBounds = YES;
}


@end
