//
//  ViewController.m
//  PerformanceOptimizeDemo
//
//  Created by chenshuang on 2019/4/6.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import <time.h>
#import <sys/stat.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
/** img1*/
@property(nonatomic,strong)UIImageView *imgView1;
/** img2*/
@property(nonatomic,strong)UIImageView *imgView2;
/** datestr*/
@property(nonatomic,strong)NSString *dateStr;
/** date format*/
@property(nonatomic,strong)NSDateFormatter *formatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // drawUI
//    [self drawImgView];
    
    // NSDateFormatter
//    [self convertDateToStringUsingDateFormatter];
//    [self convertDateToStringUsingCLocaltime];
    
    // dateStr -> date
//    [self compareTime];
//    [self compareTime2];
//    [self getTime];
    
    [self getFileAttrByFileManager];
    [self getFileAttrByStat];
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

#pragma mark - dateFromString

#define kTimeInterval0 @"100000"

// 2019-04-06 20:11:13
#define kTimeIntervalStr @"2019-04-06 20:11:13"
#define kTimeInterval @"1554552673"
#define kTimeInterval2 @"1554552999"

- (void)compareTime {
    old = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < TIMES; i++) {
        NSDate* startDate = [self dateFromString:@"1554552673"];
        NSDate* endDate = [self dateFromString:@"1554552999"];
        NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"dateFromString: %f",now - old);
}

- (void)compareTime2 {
    old = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < TIMES; i++) {
        NSDate* startDate = [self strptimeFromString:@"2019-04-06 20:11:13"];
        NSDate* endDate = [self strptimeFromString:@"2019-04-06 20:46:13"];
        NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"dateWithTimeIntervalSince1970: %f",now - old);
}

- (void)getTime {
    NSDate *date = [self strptimeFromString:kTimeIntervalStr];
    NSString *time = [self.formatter stringFromDate:date];
    NSLog(@"time = %@",time);
}

- (NSDate *)dateFromString:(NSString *)timeInterval {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:timeInterval];
    return date;
}

- (NSDate *)strptimeFromString:(NSString *)timeInterval {
    time_t t;
    struct tm tm;
    strptime([timeInterval cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
    return date;
}

#pragma mark - get file attr

- (void)getFileAttrByFileManager {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSError *error;
    NSDictionary *attrDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if (error) {
        NSLog(@"error = %@",error.description);
    } else {
        NSLog(@"attrDict = %@",attrDict);
    }
}

- (void)getFileAttrByStat {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    struct stat statbuf;
    const char *cpath = [filePath fileSystemRepresentation];
    if (cpath && stat(cpath, &statbuf) == 0) {
        NSNumber *fileSize = [NSNumber numberWithUnsignedLongLong:statbuf.st_size];
        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_ctime];
        NSDate *modificationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_mtime];
        NSLog(@"fileSize = %ld, creationDate = %@, modificationDate = %@",(long)[fileSize integerValue],[self.formatter stringFromDate:creationDate],[self.formatter stringFromDate:modificationDate]);
    }
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

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _formatter;
}

@end
