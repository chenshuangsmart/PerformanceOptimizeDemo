//
//  CalculateNewsCell.m
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/16.
//  Copyright © 2019年 cs. All rights reserved.
//

#import "CalculateNewsCell.h"
#import "NewsModel.h"
#import "NewsActionView.h"

@interface CalculateNewsCell()
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
/** content */
@property(nonatomic, strong)UILabel *contentLbe;
/** img view */
@property(nonatomic, strong)UIView *imgListView;
/** share */
@property(nonatomic, strong)NewsActionView *shareActionView;
/** discuss */
@property(nonatomic, strong)NewsActionView *discussActionView;
/** like */
@property(nonatomic, strong)NewsActionView *likeActionView;
/** divide line */
@property(nonatomic, strong)UIView *divideLineView;
@end

@implementation CalculateNewsCell

#define kImgViewWH (kScreenWidth - 20 - 15) / 4.0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark - drawUI

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
    
    self.contentLbe.x = 10;
    self.contentLbe.y = self.iconImgView.bottom + 10;
    [self.contentView addSubview:self.contentLbe];
    
    self.imgListView.x = 10;
    self.imgListView.y = self.contentLbe.bottom + 10;
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
    
    self.divideLineView.y = self.discussActionView.bottom;
    [self.contentView addSubview:self.divideLineView];
}

#pragma mark - set

- (void)setModel:(NewsModel *)model {
    _model = model;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    self.titleLbe.text = model.title;
    [self.titleLbe sizeToFit];
    self.titleLbe.bottom = self.iconImgView.centerY - 2;
    
    self.subTitleLbe.text = model.subTitle;
    [self.subTitleLbe sizeToFit];
    self.subTitleLbe.y = self.iconImgView.centerY + 2;
    
    self.contentLbe.text = model.content;
    [self.contentLbe sizeToFit];
    
    if (model.isAttention) {
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
    
    float discussActionViewPosY = self.contentLbe.bottom + 10;
    self.imgListView.y = self.contentLbe.bottom + 10;
    [self.imgListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imgListView.height = 0;
    
    if (model.imgs.count > 0) {
        __block float posX = 0;
        [model.imgs enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 0, kImgViewWH, kImgViewWH)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:obj]];
            imgView.layer.cornerRadius = 5;
            imgView.layer.masksToBounds = YES;
            
            [self.imgListView addSubview:imgView];
            posX += (5 + kImgViewWH);
            if (idx >= 3) {
                *stop = YES;
            }
        }];
        self.imgListView.height = kImgViewWH;
        discussActionViewPosY = self.imgListView.bottom + 10;
    }

    self.discussActionView.y = discussActionViewPosY;
    self.shareActionView.y = self.discussActionView.y;
    self.likeActionView.y = self.discussActionView.y;
    
    if (model.isLike) {
        [self.likeActionView updateImgName:@"like_red"];
    } else {
        [self.likeActionView updateImgName:@"like"];
    }
    
    [self.discussActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)model.discussNum]];
    [self.shareActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)model.shareNum]];
    [self.likeActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)model.likeNum]];
    
    self.divideLineView.y = self.discussActionView.bottom;
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

- (UILabel *)contentLbe {
    if (_contentLbe == nil) {
        _contentLbe = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 0)];
        _contentLbe.font = [UIFont systemFontOfSize:16];
        _contentLbe.textColor = [UIColor grayColor];
        _contentLbe.numberOfLines = 0;
    }
    return _contentLbe;
}

- (UIView *)imgListView {
    if (_imgListView == nil) {
        _imgListView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 0)];
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

- (UIView *)divideLineView {
    if (_divideLineView == nil) {
        _divideLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _divideLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    return _divideLineView;
}

@end
