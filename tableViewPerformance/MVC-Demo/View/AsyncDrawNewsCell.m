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
#import "VVeboLabel.h"

static NSString *kNotifyModelUpdate = @"kNotifyModelUpdate";

@interface AsyncDrawNewsCell()
/** icon */
@property(nonatomic, strong)UIImageView *iconImgView;
/** attention */
@property(nonatomic, strong)UILabel *attentionLbe;
/** delete */
@property(nonatomic, strong)UIImageView *deleteImgView;
/** postBGImgView */
@property(nonatomic, weak)UIImageView *contentImgView;
/** img view */
@property(nonatomic, strong)UIView *imgListView;
/** share */
@property(nonatomic, strong)NewsActionView *shareActionView;
/** discuss */
@property(nonatomic, strong)NewsActionView *discussActionView;
/** like */
@property(nonatomic, strong)NewsActionView *likeActionView;
@end

@implementation AsyncDrawNewsCell {
    bool _drawed;   // 是否已经绘制过了
    VVeboLabel *label;
    VVeboLabel *detailLabel;
    NSInteger _drawColorFlag;   // 随机绘制
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
    
    self.deleteImgView.centerY = self.iconImgView.centerY;
    self.deleteImgView.right = kScreenWidth - 10;
    [self.contentView addSubview:self.deleteImgView];
    
    self.attentionLbe.centerY = self.iconImgView.centerY;
    self.attentionLbe.right = self.deleteImgView.x - 10;
    [self.contentView addSubview:self.attentionLbe];
    
    self.imgListView.x = 10;
    self.imgListView.y = 0;
    [self.contentView addSubview:self.imgListView];
    
    self.discussActionView.centerX = self.contentView.width * 0.5;
    self.discussActionView.y = self.imgListView.bottom + 10;
    [self.contentView addSubview:self.discussActionView];
    
    self.shareActionView.right = self.discussActionView.x;
    self.shareActionView.y = self.discussActionView.y;
    [self.contentView addSubview:self.shareActionView];
    
    self.likeActionView.x = self.discussActionView.right;
    self.likeActionView.y = self.discussActionView.y;
    [self.contentView addSubview:self.likeActionView];
}

#pragma mark - 动态绘制

/// 清空视图
- (void)clear {
    if (!_drawed) {
        return;
    }
    self.contentImgView.frame = CGRectZero;
    self.contentImgView.image = nil;
    
    [label clear];
    // 清除图片
    for (UIImageView *imgView in self.imgListView.subviews) {
        [imgView sd_cancelCurrentAnimationImagesLoad];
    }
    self.imgListView.hidden = YES;
    _drawColorFlag = arc4random();
    _drawed = NO;
}

- (void)addLabel{
    if (label) {
        [label removeFromSuperview];
        label = nil;
    }
    if (detailLabel) {
        [detailLabel removeFromSuperview];
        detailLabel = nil;
    }
    label = [[VVeboLabel alloc] initWithFrame:_model.textFrame];
    label.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    label.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [self.contentView addSubview:label];
}

#pragma mark - set

- (void)setModel:(NewsModel *)model {
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    if (_drawed) {
        return;
    }
    NSUInteger flag = _drawColorFlag;
    _drawed = YES;
    
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
        
        // 点赞+评论按钮 - 顶部分割线
        [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] set];
        CGContextFillRect(context, CGRectMake(0, model.contentFrame.origin.y + model.contentFrame.size.height, kScreenWidth, 0.5));
        
        // 点赞+评论按钮 - 底部分割线
        [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] set];
        CGContextFillRect(context, CGRectMake(0, model.contentFrame.origin.y + model.contentFrame.size.height + 43, kScreenWidth, 0.5));
        
        // 生成图片
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (flag == _drawColorFlag) {
                self.contentImgView.frame = model.totalFrame;
                self.contentImgView.image = nil;
                self.contentImgView.image = temp;
            }
        });
    });
    
    [self drawText];
    [self loadThumb];
    [self setData];
}

- (void)drawText {
    if (label == nil) {
        [self addLabel];
    }
    label.frame = _model.textFrame;
    [label setText:[NSString stringWithFormat:@"%@: %@ %@",_model.specialWord,_model.content,_model.link]];
}

- (void)loadThumb {
    if (_model.imgs.count > 0) {
        self.imgListView.hidden = NO;
        self.imgListView.y = _model.contentFrame.origin.y + _model.textFrame.size.height + 2 * SIZE_GAP_BIG;
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imgView = (UIImageView *)[self.imgListView viewWithTag:i + 1]; // 0为自身,从 1 开始才是 imgVie
            if (i < _model.imgs.count) {
                imgView.hidden = NO;
                [imgView sd_setImageWithURL:[NSURL URLWithString:_model.imgs[i]]];
            } else {
                imgView.hidden = YES;
            }
        }
    } else {
        self.imgListView.hidden = YES;
    }
}

- (void)setData {
    // 是否关注
    if (_model.isAttention) {
        self.attentionLbe.text = @"已关注";
        self.attentionLbe.textColor = [UIColor grayColor];
        self.attentionLbe.userInteractionEnabled = NO;
    } else {
        self.attentionLbe.text = @"关注";
        self.attentionLbe.textColor = [UIColor redColor];
        self.attentionLbe.userInteractionEnabled = YES;
    }
    [self.attentionLbe sizeToFit];
    self.attentionLbe.right = self.deleteImgView.x - 10;
    
    // 评论 + 点赞 + 分享按钮
    self.discussActionView.y = _model.contentFrame.origin.y + _model.contentFrame.size.height;
    self.shareActionView.y = self.discussActionView.y;
    self.likeActionView.y = self.discussActionView.y;
    
    if (_model.isLike) {
        [self.likeActionView updateImgName:@"like_red"];
    } else {
        [self.likeActionView updateImgName:@"like"];
    }
    
    [self.discussActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.discussNum]];
    [self.shareActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.shareNum]];
    [self.likeActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.likeNum]];
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

- (UIView *)imgListView {
    if (_imgListView == nil) {
        _imgListView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 0)];
        __block float posX = 0;
        for (int i = 0; i < 4; i++) {   // 先绘制 4 个图片出来
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 0, kImgViewWH, kImgViewWH)];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.layer.cornerRadius = 5;
            imgView.layer.masksToBounds = YES;
            imgView.tag = i + 1;
            
            [_imgListView addSubview:imgView];
            posX += (5 + kImgViewWH);
        }

        _imgListView.height = kImgViewWH;
    }
    return _imgListView;
}

- (NewsActionView *)shareActionView {
    if (_shareActionView == nil) {
        _shareActionView = [[NewsActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.33, 44) imgName:@"share" title:@"转发"];
    }
    return _shareActionView;
}

- (NewsActionView *)discussActionView {
    if (_discussActionView == nil) {
        _discussActionView = [[NewsActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.34, 44) imgName:@"message" title:@"0"];
    }
    return _discussActionView;
}

- (NewsActionView *)likeActionView {
    if (_likeActionView == nil) {
        _likeActionView = [[NewsActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.33, 44) imgName:@"like" title:@"0"];
    }
    return _likeActionView;
}

@end
