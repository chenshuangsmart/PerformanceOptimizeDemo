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
        //        [self addNotify];
    }
    return self;
}

- (void)drawUI {
    self.contentView.width = kScreenWidth;
    self.iconImgView.y = 10;
    self.iconImgView.x = 10;
    [self.contentView addSubview:self.iconImgView];
    
    self.titleLbe.x = self.iconImgView.right + 10;
    self.titleLbe.bottom = self.iconImgView.centerY - 2;
    [self.contentView addSubview:self.titleLbe];
    
    self.subTitleLbe.x = self.titleLbe.x;
    self.subTitleLbe.y = self.iconImgView.centerY + 2;
    [self.contentView addSubview:self.subTitleLbe];
    
    self.deleteImgView.centerY = self.iconImgView.centerY;
    self.deleteImgView.right = kScreenWidth - 10;
    [self.contentView addSubview:self.deleteImgView];
    
    self.attentionLbe.centerY = self.iconImgView.centerY;
    self.attentionLbe.right = self.deleteImgView.x - 10;
    [self.contentView addSubview:self.attentionLbe];
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
    
    self.titleLbe.text = _model.title;
    [self.titleLbe sizeToFit];
    
    self.subTitleLbe.text = _model.subTitle;
    [self.subTitleLbe sizeToFit];
    
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
