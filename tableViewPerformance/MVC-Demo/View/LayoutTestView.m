//
//  LayoutTestView.m
//  MVC-Demo
//
//  Created by cs on 2019/6/12.
//  Copyright © 2019 cs. All rights reserved.
//

#import "LayoutTestView.h"

@implementation LayoutTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self drawUI];
    }
    return self;
}

- (void)drawUI {
    // 父控件
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    superView.backgroundColor = [UIColor redColor];
    [self addSubview:superView];
    
    // green
    UIView *greenVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    greenVeiw.backgroundColor = [UIColor greenColor];
    [superView addSubview:greenVeiw];
    
    // blue
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    blueView.backgroundColor = [UIColor blueColor];
    [superView addSubview:blueView];
    
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(superView.width);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [greenVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(greenVeiw.size);
        make.top.equalTo(superView).offset(50);
        make.leading.equalTo(superView).offset(50);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(blueView.size);
        make.leading.equalTo(superView).offset(50);
        make.top.equalTo(greenVeiw.mas_bottom).offset(50);
        make.bottom.equalTo(superView).offset(-50);
    }];
}
@end
