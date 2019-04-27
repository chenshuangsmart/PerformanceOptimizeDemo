//
//  FPSViewer.m
//  MVC-Demo
//
//  Created by cs on 2019/4/15.
//  Copyright © 2019 cs. All rights reserved.
//

#import "FPSViewer.h"
#import "FPSHandler.h"

@interface FPSViewer()
/** fps */
@property(nonatomic, weak)UILabel *fpsLbe;
@end

@implementation FPSViewer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self drawUI];
        
        [[FPSHandler shareInstance] startMonitor:^(float fps) {
            self.fpsLbe.text = [NSString stringWithFormat:@"FPS:%0.0f",fps];
        }];
    }
    return self;
}

- (void)drawUI {
    UILabel *fpsLbe = [[UILabel alloc] initWithFrame:self.bounds];
    fpsLbe.textColor = [UIColor blackColor];
    fpsLbe.text = @"";
    fpsLbe.textAlignment = NSTextAlignmentCenter;
    [self addSubview:fpsLbe];
    self.fpsLbe = fpsLbe;
}

@end
