//
//  NeedLoadNewsCell.m
//  MVC-Demo
//
//  Created by cs on 2019/5/5.
//  Copyright © 2019 cs. All rights reserved.
//

#import "NeedLoadNewsCell.h"
#import "NewsModel.h"
#import "NewsActionView.h"

static NSString *kNotifyModelUpdate = @"kNotifyModelUpdate";

@interface NeedLoadNewsCell()
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

@implementation NeedLoadNewsCell {
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

#pragma mark - drawUI

- (void)drawUI {
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.titleLbe];
    [self.contentView addSubview:self.subTitleLbe];
    [self.contentView addSubview:self.deleteImgView];
    [self.contentView addSubview:self.attentionLbe];
    [self.contentView addSubview:self.contentLbe];
    [self.contentView addSubview:self.imgListView];
    [self.contentView addSubview:self.discussActionView];
    [self.contentView addSubview:self.shareActionView];
    [self.contentView addSubview:self.likeActionView];
    [self.contentView addSubview:self.divideLineView];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
    }];
    
    [self.titleLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.bottom.equalTo(self.iconImgView.mas_centerY).offset(-2);
    }];
    
    [self.subTitleLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLbe.mas_leading);
        make.top.equalTo(self.iconImgView.mas_centerY).offset(2);
    }];
    
    [self.deleteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.deleteImgView.size);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
    }];
    
    [self.attentionLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-40);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
    }];
    
    [self.contentLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10);
        make.top.equalTo(self.iconImgView.mas_bottom).offset(10);
    }];
    
    [self.imgListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10);
        make.top.equalTo(self.contentLbe.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    
    [self.discussActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgListView.mas_bottom).offset(10);
        make.size.mas_equalTo(self.discussActionView.size);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [self.shareActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discussActionView.mas_top);
        make.size.mas_equalTo(self.shareActionView.size);
        make.trailing.equalTo(self.discussActionView.mas_leading);
    }];
    
    [self.likeActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discussActionView.mas_top);
        make.size.mas_equalTo(self.likeActionView.size);
        make.leading.equalTo(self.discussActionView.mas_trailing);
    }];
    
    [self.divideLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(5);
        make.top.equalTo(self.discussActionView.mas_bottom);
        //===== 底部对齐是撑开cell的关键点 =====//
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 动态绘制

/// 开始绘制
- (void)draw {
    if (_drawed) {
        return;
    }
    _drawed = YES;
    self.titleLbe.text = _model.title;
    [self.titleLbe sizeToFit];
    
    self.subTitleLbe.text = _model.subTitle;
    [self.subTitleLbe sizeToFit];
    
    if (_model.isAttention) {
        self.attentionLbe.text = @"已关注";
        [self.attentionLbe sizeToFit];
        self.attentionLbe.textColor = [UIColor grayColor];
        self.attentionLbe.userInteractionEnabled = NO;
    } else {
        self.attentionLbe.text = @"关注";
        [self.attentionLbe sizeToFit];
        self.attentionLbe.textColor = [UIColor redColor];
        self.attentionLbe.userInteractionEnabled = YES;
    }
    
    self.contentLbe.text = _model.content;
    
    [self.imgListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float imgListViewHeight = 0;
    float discussActionViewPosY = 0;
    
    if (_model.imgs.count > 0) {
        __block float posX = 0;
        [_model.imgs enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
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
        imgListViewHeight = kImgViewWH;
        discussActionViewPosY = 10;
    }
    
//    [self.imgListView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(imgListViewHeight);
//    }];

    [self.contentLbe mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10);
        make.top.equalTo(self.iconImgView.mas_bottom).offset(10);
    }];
    
    [self.imgListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10);
        make.top.equalTo(self.contentLbe.mas_bottom).offset(10);
        make.height.mas_equalTo(imgListViewHeight);
    }];
    
    [self.discussActionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgListView.mas_bottom).offset(discussActionViewPosY);
    }];
    
    if (_model.isLike) {
        [self.likeActionView updateImgName:@"like_red"];
    } else {
        [self.likeActionView updateImgName:@"like"];
    }
    
    [self.discussActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.discussNum]];
    [self.shareActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.shareNum]];
    [self.likeActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_model.likeNum]];
}

/// 清空视图
- (void)clear {
    if (!_drawed) {
        return;
    }
    _drawed = NO;
    
    // content
    self.contentLbe.text = @"";
    
    // img list
    [self.imgListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.imgListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [self.discussActionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgListView.mas_bottom).offset(0);
    }];
}

#pragma mark - set

- (void)setModel:(NewsModel *)model {
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
}

#pragma mark - action

- (void)tapAttentionLbe {
    if ([self.delegate respondsToSelector:@selector(didTapNewsCellAttention:)]) {
        [self.delegate didTapNewsCellAttention:self.model];
    }
}

- (void)tapDelete {
    if ([self.delegate respondsToSelector:@selector(didTapNewsCellDelete:)]) {
        [self.delegate didTapNewsCellDelete:self.model];
    }
}

- (void)tapShare {
    if ([self.delegate respondsToSelector:@selector(didTapNewsCellShare:)]) {
        [self.delegate didTapNewsCellShare:self.model];
    }
}

- (void)tapDiscuss {
    if ([self.delegate respondsToSelector:@selector(didTapNewsCellDiscuss:)]) {
        [self.delegate didTapNewsCellDiscuss:self.model];
    }
}

// 用户点击了点赞按钮
- (void)tapLike {
    /**
     标准MVC写法 - 用户点击事件外传
     */
    if ([self.delegate respondsToSelector:@selector(didTapNewsCellLike:)]) {
        [self.delegate didTapNewsCellLike:self.model];
    }
    
    /**
     * view上面的用户行为事件如何处理？
     2.直接发起网络请求并处理回调事件 - 非标准的MVC写法,此种写法有问题
     */
    //    NSLog(@"old model %p",self.model);
    //    __weak typeof(self) weakSelf = self;
    //    [self.model addLike:^(NSDictionary *json) {
    //        weakSelf.model.like = !weakSelf.model.isLike;
    //        NSLog(@"new model %p",weakSelf.model);
    //        if (weakSelf.model.isLike) {
    //            [weakSelf.likeActionView updateImgName:@"like_red"];
    //            weakSelf.model.likeNum++;
    //        } else {
    //            [weakSelf.likeActionView updateImgName:@"like"];
    //            weakSelf.model.likeNum--;
    //        }
    //        [weakSelf.likeActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)weakSelf.model.likeNum]];
    //    }];
    
    /**
     * 数据模型更新了后如何处理？
     * 直接发通知,然后视图监听通知并刷新视图
     */
    //    __weak typeof(self) weakSelf = self;
    //    [self.model addLike:^(NSDictionary *json) {
    //        // 发通知
    //        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyModelUpdate object:weakSelf.model];
    //    }];
}

#pragma mark - notify

- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyModelUpdate:) name:kNotifyModelUpdate object:nil];
}

- (void)onNotifyModelUpdate:(NSNotification *)notify {
    NewsModel *model = (NewsModel *)notify.object;
    if (model == nil) {
        return;
    }
    if (![self.model.newsId isEqualToString:model.newsId]) {
        return;
    }
    // 更新视图操作
    if (self.model.isLike) {
        [self.likeActionView updateImgName:@"like_red"];
    } else {
        [self.likeActionView updateImgName:@"like"];
    }
    [self.likeActionView updateTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.model.likeNum]];
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
        [_attentionLbe onTap:self action:@selector(tapAttentionLbe)];
    }
    return _attentionLbe;
}

- (UIImageView *)deleteImgView {
    if (_deleteImgView == nil) {
        _deleteImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        [_deleteImgView onTap:self action:@selector(tapDelete)];
    }
    return _deleteImgView;
}

- (UILabel *)contentLbe {
    if (_contentLbe == nil) {
        _contentLbe = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 0)];
        _contentLbe.font = [UIFont systemFontOfSize:16];
        _contentLbe.textColor = [UIColor grayColor];
        _contentLbe.numberOfLines = 3;
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
        [_shareActionView onTap:self action:@selector(tapShare)];
    }
    return _shareActionView;
}

- (NewsActionView *)discussActionView {
    if (_discussActionView == nil) {
        _discussActionView = [[NewsActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.34, 44) imgName:@"message" title:@"0"];
        [_discussActionView onTap:self action:@selector(tapDiscuss)];
    }
    return _discussActionView;
}

- (NewsActionView *)likeActionView {
    if (_likeActionView == nil) {
        _likeActionView = [[NewsActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.33, 44) imgName:@"like" title:@"0"];
        [_likeActionView onTap:self action:@selector(tapLike)];
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
