//
//  AsyncDrawNewsCell.h
//  MVC-Demo
//
//  Created by cs on 2019/5/6.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

@protocol AsyncDrawNewsCellDelegate <NSObject>

// tap delete
- (void)didTapNewsCellDelete:(NewsModel *)newsModel;

// tap attention
- (void)didTapNewsCellAttention:(NewsModel *)newsModel;

// tap share
- (void)didTapNewsCellShare:(NewsModel *)newsModel;

// tap discuss
- (void)didTapNewsCellDiscuss:(NewsModel *)newsModel;

// tap like
- (void)didTapNewsCellLike:(NewsModel *)newsModel;

@end

/**
 异步绘制 cell
 */
@interface AsyncDrawNewsCell : UITableViewCell

/** model */
@property(nonatomic, strong)NewsModel *model;

/** delegate */
@property(nonatomic,weak)id<AsyncDrawNewsCellDelegate> delegate;

/// 开始绘制
- (void)draw;

/// 清空视图
- (void)clear;

@end

NS_ASSUME_NONNULL_END
