//
//  AsyncDrawNewsCell.h
//  MVC-Demo
//
//  Created by cs on 2019/5/6.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIZE_GAP_LEFT 15
#define SIZE_GAP_TOP 13
#define SIZE_AVATAR 44
#define SIZE_GAP_BIG 10
#define SIZE_GAP_IMG 5
#define SIZE_GAP_SMALL 5
#define SIZE_IMAGE 80
#define SIZE_FONT 17

#define SIZE_FONT_NAME (SIZE_FONT-3)
#define SIZE_FONT_SUBTITLE (SIZE_FONT-8)
#define FontWithSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define SIZE_FONT_CONTENT 17
#define SIZE_FONT_SUBCONTENT (SIZE_FONT_CONTENT-1)

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
