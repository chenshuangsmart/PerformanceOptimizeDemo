//
//  AsyncDrawNewsCell.m
//  MVC-Demo
//
//  Created by cs on 2019/5/6.
//  Copyright © 2019 cs. All rights reserved.
//

#import "AsyncDrawNewsCell.h"
#import "NewsModel.h"
#import "NewsActionView.h"

static NSString *kNotifyModelUpdate = @"kNotifyModelUpdate";

@implementation AsyncDrawNewsCell {
    bool _drawed;   // 是否已经绘制过了
}

#define kImgViewWH (kScreenWidth - 20 - 15) / 4.0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawUI];
        //        [self addNotify];
    }
    return self;
}

- (void)drawUI {
}

#pragma mark - 动态绘制

/// 清空视图
- (void)clear {
}

/// 开始绘制
- (void)draw {
}



@end
