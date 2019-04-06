//
//  ViewController.m
//  PerformanceOptimizeDemo
//
//  Created by chenshuang on 2019/4/6.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
/** img1*/
@property(nonatomic,strong)UIImageView *imgView1;
/** img2*/
@property(nonatomic,strong)UIImageView *imgView2;
/** datestr*/
@property(nonatomic,strong)NSString *dateStr;
/** timeLbe*/
@property(nonatomic,strong)UILabel *timeLbe;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // drawUI
//    [self drawImgView];
    
    // NSDateFormatter
    [self convertDateToStringUsingDateFormatter];
    [self convertDateToStringUsingCLocaltime];
}

#pragma mark - imageNamed 与 imageWithContentsOfFile对比

- (void)drawImgView {
    self.imgView1.center = CGPointMake(kScreenWidth * 0.25, kScreenHeight * 0.5);
    self.imgView1.image = [UIImage imageNamed:@"gir2"];
    [self.view addSubview:self.imgView1];
    
    self.imgView2.center = CGPointMake(kScreenWidth * 0.75, kScreenHeight * 0.5);
    NSString *imgUrl = [[NSBundle mainBundle] pathForResource:@"gir1" ofType:@"jpg"];
    self.imgView2.image = [UIImage imageWithContentsOfFile:imgUrl];
    [self.view addSubview:self.imgView2];
}

#pragma mark - NSDateFormatter 第替代

#define TIMES (1024*10)
static double old, now;

/// use NSDateFormatter
- (void)convertDateToStringUsingDateFormatter {
    old = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < TIMES; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.dateStr = [formatter stringFromDate:[NSDate date]];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"convertDateToStringUsingDateFormatter: %f",now - old);
}

/// use struct tm
- (void)convertDateToStringUsingCLocaltime {
    old = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < TIMES; i++) {
        time_t timeInterval = [NSDate date].timeIntervalSince1970;
        struct tm *cTime = localtime(&timeInterval);
        self.dateStr = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d", cTime->tm_year + 1900, cTime->tm_mon + 1, cTime->tm_mday,cTime->tm_hour, cTime->tm_min, cTime->tm_sec];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"convertDateToStringUsingDateFormatter: %f",now - old);
}

#pragma mark - lazy

- (UIImageView *)imgView1 {
    if (_imgView1 == nil) {
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imgView1.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView1;
}

- (UIImageView *)imgView2 {
    if (_imgView2 == nil) {
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imgView2.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView2;
}

- (UILabel *)timeLbe {
    if (_timeLbe == nil) {
        _timeLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 40)];
        _timeLbe.textColor = [UIColor blackColor];
        _timeLbe.textAlignment = NSTextAlignmentCenter;
        _timeLbe.center = self.view.center;
        [self.view addSubview:_timeLbe];
    }
    return _timeLbe;
}

@end
