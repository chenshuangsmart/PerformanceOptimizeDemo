//
//  RadiusViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/25.
//  Copyright © 2019 cs. All rights reserved.
//

#import "RadiusViewController.h"

@interface RadiusViewController ()

@end

@implementation RadiusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"裁剪圆角";
    
    // label
//    [self drawLbe];

    // textField
//    [self drawTextF];

    // textView
//    [self drawTextV];
    
    // clips
//    [self clipRoundedCornerImage];
    
    // draw
//    [self drawRoundedCornerImage];
    
    // graphics
    [self drawCircleImageUseGraphics];
    
}

- (void)drawLbe {
    
    UILabel *radiusLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    radiusLbe.textColor = [UIColor blackColor];
    radiusLbe.text = @"裁剪圆角";
    radiusLbe.textAlignment = NSTextAlignmentCenter;
    // a裁剪圆角
    radiusLbe.layer.backgroundColor = [[UIColor orangeColor] CGColor];
    radiusLbe.layer.cornerRadius = 10;
    [self.view addSubview:radiusLbe];
    
    [radiusLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(radiusLbe.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
}

- (void)drawTextF {
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    textF.textColor = [UIColor blackColor];
    textF.text = @"裁剪圆角";
    textF.textAlignment = NSTextAlignmentCenter;
    // a裁剪圆角
    textF.layer.backgroundColor = [[UIColor greenColor] CGColor];
    textF.layer.cornerRadius = 10;
    [self.view addSubview:textF];
    
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(textF.size);
        make.top.equalTo(self.view.mas_top).offset(200);
        make.centerX.equalTo(self.view);
    }];
}

- (void)drawTextV {
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    textV.textColor = [UIColor whiteColor];
    textV.text = @"如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n如何在UITextView视图上实现圆角?\n";
    textV.textAlignment = NSTextAlignmentCenter;
    // a裁剪圆角
    textV.layer.backgroundColor = [[UIColor blueColor] CGColor];
    textV.layer.cornerRadius = 10;
    [self.view addSubview:textV];
    
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(textV.size);
        make.top.equalTo(self.view.mas_top).offset(300);
        make.centerX.equalTo(self.view);
    }];
}

// 裁剪圆角
- (void)clipRoundedCornerImage {
    //  图片
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    iconImgV.image = [UIImage imageNamed:@"icon_girl"];
    iconImgV.layer.cornerRadius = 100;
    iconImgV.layer.masksToBounds = YES;
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgV.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    // 视图
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.cornerRadius = 100;
    redView.layer.masksToBounds = YES;
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(redView.size);
        make.top.equalTo(iconImgV.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)drawRoundedCornerImage {
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    iconImgV.image = [UIImage imageNamed:@"icon_girl"];
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgV.size);
        make.top.equalTo(self.view.mas_top).offset(500);
        make.centerX.equalTo(self.view);
    }];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imgView.size);
        make.top.equalTo(iconImgV.mas_top);
        make.leading.equalTo(iconImgV.mas_leading);
    }];
    
//    imgView.image = [self useUIGraphicsDrawAntiRoundedCornerImageWithRadius:10 outerSize:CGSizeMake(150, 150) innerSize:CGSizeMake(100, 100) fillColor:[UIColor whiteColor]];
    
    // 圆形
//    imgView.image = [self drawCircleRadius:100 outerSize:CGSizeMake(200, 200) fillColor:[UIColor whiteColor]];
    
    // 圆角
    imgView.image = [self drawAntiRoundedCornerImageWithRadius:100 rectSize:CGSizeMake(200, 200) fillColor:[UIColor whiteColor]];
}

- (void)drawCircleImageUseGraphics {
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    iconImgV.image = [self circleImage:[UIImage imageNamed:@"icon_girl"]];
    [self.view addSubview:iconImgV];
    
    [iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgV.size);
        make.top.equalTo(self.view.mas_top).offset(300);
        make.centerX.equalTo(self.view);
    }];
}

- (UIImage *)useUIGraphicsDrawAntiRoundedCornerImageWithRadius:(float)radius outerSize:(CGSize)outerSize innerSize:(CGSize)innerSize fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(outerSize, false, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    CGFloat xOffset = (outerSize.width - innerSize.width) / 2;
    CGFloat yOffset = (outerSize.height - innerSize.height) / 2;
    
    CGPoint hLeftUpPoint = CGPointMake(xOffset + radius, yOffset);
    CGPoint hRightUpPoint = CGPointMake(outerSize.width - xOffset - radius, yOffset);
    CGPoint hLeftDownPoint = CGPointMake(xOffset + radius, outerSize.height - yOffset);
    
    CGPoint vLeftUpPoint = CGPointMake(xOffset, yOffset + radius);
    CGPoint vRightDownPoint = CGPointMake(outerSize.width - xOffset, outerSize.height - yOffset - radius);
    
    CGPoint centerLeftUp = CGPointMake(xOffset + radius, yOffset + radius);
    CGPoint centerRightUp = CGPointMake(outerSize.width - xOffset - radius, yOffset + radius);
    CGPoint centerLeftDown = CGPointMake(xOffset + radius, outerSize.height - yOffset - radius);
    CGPoint centerRightDown = CGPointMake(outerSize.width - xOffset - radius, outerSize.height - yOffset - radius);
    
    [bezierPath moveToPoint:hLeftUpPoint];
    [bezierPath addLineToPoint:hRightUpPoint];
    [bezierPath addArcWithCenter:centerRightUp radius:radius startAngle:(CGFloat)(M_PI * 3 / 2) endAngle:(CGFloat)(M_PI * 2) clockwise: true];
    [bezierPath addLineToPoint:vRightDownPoint];
    [bezierPath addArcWithCenter:centerRightDown radius: radius startAngle: 0 endAngle: (CGFloat)(M_PI / 2) clockwise: true];
    [bezierPath addLineToPoint:hLeftDownPoint];
    [bezierPath addArcWithCenter:centerLeftDown radius: radius startAngle: (CGFloat)(M_PI / 2) endAngle: (CGFloat)(M_PI) clockwise: true];
    [bezierPath addLineToPoint:vLeftUpPoint];
    [bezierPath addArcWithCenter:centerLeftUp radius: radius startAngle: (CGFloat)(M_PI) endAngle: (CGFloat)(M_PI * 3 / 2) clockwise: true];
    [bezierPath addLineToPoint:hLeftUpPoint];
    [bezierPath closePath];
    
    //If draw drection of outer path is same with inner path, final result is just outer path.
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(0, outerSize.height)];
    [bezierPath addLineToPoint:CGPointMake(outerSize.width, outerSize.height)];
    [bezierPath addLineToPoint:CGPointMake(outerSize.width, 0)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath closePath];
    
    [fillColor setFill];
    [bezierPath fill];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *antiRoundedCornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiRoundedCornerImage;
}

// 绘制圆形
- (UIImage *)drawCircleRadius:(float)radius outerSize:(CGSize)outerSize fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(outerSize, false, [UIScreen mainScreen].scale);
    
    // 1、获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    // ArcCenter:中心点 radius:半径 startAngle起始角度 endAngle结束角度 clockwise：是否逆时针
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(outerSize.width * 0.5, outerSize.height * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [bezierPath closePath];
    
    // 3.外边
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(outerSize.width, 0)];
    [bezierPath addLineToPoint:CGPointMake(outerSize.width, outerSize.height)];
    [bezierPath addLineToPoint:CGPointMake(0, outerSize.height)];
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    [bezierPath closePath];
    
    //4.设置颜色
    [fillColor setFill];
    [bezierPath fill];
    
    CGContextDrawPath(contextRef, kCGPathStroke);
    UIImage *antiRoundedCornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiRoundedCornerImage;
}

/**
 绘制裁剪圆角后图片

 @param radius 圆角
 @param rectSize 视图尺寸
 @param fillColor 填充色
 @return 图片
 */
- (UIImage *)drawAntiRoundedCornerImageWithRadius:(float)radius rectSize:(CGSize)rectSize fillColor:(UIColor *)fillColor {
    UIGraphicsBeginImageContextWithOptions(rectSize, false, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    CGPoint hLeftUpPoint = CGPointMake(radius, 0);
    CGPoint hRightUpPoint = CGPointMake(rectSize.width - radius, 0);
    CGPoint hLeftDownPoint = CGPointMake(radius, rectSize.height);
    
    CGPoint vLeftUpPoint = CGPointMake(0, radius);
    CGPoint vRightDownPoint = CGPointMake(rectSize.width, rectSize.height - radius);
    
    CGPoint centerLeftUp = CGPointMake(radius, radius);
    CGPoint centerRightUp = CGPointMake(rectSize.width - radius, radius);
    CGPoint centerLeftDown = CGPointMake(radius, rectSize.height - radius);
    CGPoint centerRightDown = CGPointMake(rectSize.width - radius, rectSize.height - radius);
    
    [bezierPath moveToPoint:hLeftUpPoint];
    [bezierPath addLineToPoint:hRightUpPoint];
    [bezierPath addArcWithCenter:centerRightUp radius:radius startAngle:(CGFloat)(M_PI * 3 / 2) endAngle:(CGFloat)(M_PI * 2) clockwise: true];
    [bezierPath addLineToPoint:vRightDownPoint];
    [bezierPath addArcWithCenter:centerRightDown radius: radius startAngle: 0 endAngle: (CGFloat)(M_PI / 2) clockwise: true];
    [bezierPath addLineToPoint:hLeftDownPoint];
    [bezierPath addArcWithCenter:centerLeftDown radius: radius startAngle: (CGFloat)(M_PI / 2) endAngle: (CGFloat)(M_PI) clockwise: true];
    [bezierPath addLineToPoint:vLeftUpPoint];
    [bezierPath addArcWithCenter:centerLeftUp radius: radius startAngle: (CGFloat)(M_PI) endAngle: (CGFloat)(M_PI * 3 / 2) clockwise: true];
    [bezierPath addLineToPoint:hLeftUpPoint];
    [bezierPath closePath];
    
    //If draw drection of outer path is same with inner path, final result is just outer path.
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(0, rectSize.height)];
    [bezierPath addLineToPoint:CGPointMake(rectSize.width, rectSize.height)];
    [bezierPath addLineToPoint:CGPointMake(rectSize.width, 0)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath closePath];
    
    [fillColor setFill];
    [bezierPath fill];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *antiRoundedCornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiRoundedCornerImage;
}

- (UIImage *)circleImage:(UIImage *)img {
    //1.开启图片图形上下文:注意设置透明度为非透明
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    //2.开启图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //3.绘制圆形区域(此处根据宽度来设置)
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.width);
    CGContextAddEllipseInRect(ref, rect);
    //4.裁剪绘图区域
    CGContextClip(ref);
    
    //5.绘制图片
    [img drawInRect:rect];
    
    //6.获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
