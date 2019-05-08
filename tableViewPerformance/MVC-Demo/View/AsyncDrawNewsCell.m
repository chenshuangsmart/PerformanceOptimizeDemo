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
#import "NSString+Additions.h"
#import "NSString+Additions.h"

static NSString *kNotifyModelUpdate = @"kNotifyModelUpdate";

@interface AsyncDrawNewsCell()
/** icon */
@property(nonatomic, strong)UIImageView *iconImgView;
/** title */
@property(nonatomic, strong)UILabel *titleLbe;
/** subTitle */
@property(nonatomic, strong)UILabel *subTitleLbe;
/** attention */
@property(nonatomic, strong)UILabel *attentionLbe;
/** delete */
@property(nonatomic, strong)UIImageView *deleteImgView;
/** postBGImgView */
@property(nonatomic, weak)UIImageView *contentImgView;
@end

@implementation AsyncDrawNewsCell {
    bool _drawed;   // 是否已经绘制过了
}

#define kImgViewWH (kScreenWidth - 20 - 15) / 4.0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

- (void)drawUI {
    self.clipsToBounds = YES;
    UIImageView *contentImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView insertSubview:contentImgView atIndex:0];
    self.contentImgView = contentImgView;
    
    self.contentView.width = kScreenWidth;
    self.iconImgView.y = 10;
    self.iconImgView.x = 10;
    [self.contentView addSubview:self.iconImgView];
}

#pragma mark - 动态绘制

/// 清空视图
- (void)clear {
}

/// 开始绘制
- (void)draw {
}

#pragma mark - set

- (void)setModel:(NewsModel *)model {
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    
    // 开始异步绘制
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 先开启一个上下文
        UIGraphicsBeginImageContextWithOptions(model.totalFrame.size, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // 整个 cell区域
        [[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] set];
        CGContextFillRect(context, model.totalFrame);
        
        // 先绘制内容的背景视图
        [[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1] set];
        CGContextFillRect(context, model.contentFrame);
        
        // 内容视图上方分割线
        [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] set];
        CGContextFillRect(context, CGRectMake(0, model.contentFrame.origin.y, model.contentFrame.size.width, 0.5));
        
        // title + subTitle
        {
            // title
            float leftX = SIZE_GAP_LEFT + SIZE_AVATAR + SIZE_GAP_BIG;
            float x = leftX;
            float y = (SIZE_AVATAR - (SIZE_FONT_NAME + SIZE_FONT_SUBTITLE + 6)) * 0.5 - 2 + SIZE_GAP_TOP + SIZE_GAP_SMALL - 5;
            [model.title drawInContext:context
                          withPosition:CGPointMake(x, y)
                               andFont:FontWithSize(SIZE_FONT_NAME)
                          andTextColor:[UIColor colorWithRed:106/255.0 green:140/255.0 blue:181/255.0 alpha:1]
                             andHeight:model.totalFrame.size.height];
            
            // subTitle
            y += (SIZE_FONT_NAME + 5);
            float fromX = leftX;
            float titleWidth = kScreenWidth - leftX;
            [model.subTitle drawInContext:context
                             withPosition:CGPointMake(fromX, y)
                                  andFont:FontWithSize(SIZE_FONT_SUBTITLE)
                             andTextColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]
                                andHeight:model.totalFrame.size.height
                                 andWidth:titleWidth];
        }
        
        // 是否关注
        
        // 删除图标
        
        // 内容
        
        // 点赞+评论按钮 - 顶部分割线
        [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] set];
        CGContextFillRect(context, CGRectMake(0, model.contentFrame.origin.y + model.contentFrame.size.height, kScreenWidth, 0.5));
        
        // 生成图片
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contentImgView.frame = model.totalFrame;
            self.contentImgView.image = nil;
            self.contentImgView.image = temp;
        });

    });
}

#pragma mark - private

- (UILabel *)getLbeWithFont:(float)font textColor:(UIColor *)textColor {
    UILabel *lbe = [[UILabel alloc] init];
    lbe.font = [UIFont systemFontOfSize:font];
    lbe.textColor = textColor;
    [lbe sizeToFit];
    return lbe;
}

#pragma mark - lazy

- (UIImageView *)iconImgView {
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _iconImgView.layer.cornerRadius = 22;
        _iconImgView.layer.masksToBounds = YES;
    }
    return _iconImgView;
}

- (UILabel *)titleLbe {
    if (_titleLbe == nil) {
        _titleLbe = [self getLbeWithFont:16 textColor:[UIColor blackColor]];
    }
    return _titleLbe;
}

- (UILabel *)subTitleLbe {
    if (_subTitleLbe == nil) {
        _subTitleLbe = [self getLbeWithFont:14 textColor:[UIColor grayColor]];
    }
    return _subTitleLbe;
}

- (UILabel *)attentionLbe {
    if (_attentionLbe == nil) {
        _attentionLbe = [self getLbeWithFont:16 textColor:[UIColor redColor]];
        _attentionLbe.text = @"关注";
        [_attentionLbe sizeToFit];
    }
    return _attentionLbe;
}

- (UIImageView *)deleteImgView {
    if (_deleteImgView == nil) {
        _deleteImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
    }
    return _deleteImgView;
}


@end
