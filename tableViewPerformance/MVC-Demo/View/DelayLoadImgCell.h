//
//  DelayLoadImgCell.h
//  MVC-Demo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

/**
 延时加载图片 cell
 */
@interface DelayLoadImgCell : UITableViewCell

/** model */
@property(nonatomic, strong)NewsModel *model;

/// 绘制图片
- (void)drawImg;

@end

NS_ASSUME_NONNULL_END
