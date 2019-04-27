//
//  CalculateNewsCell.h
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/16.
//  Copyright © 2019年 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NewsModel;

/// 缓存 cell 的高度
@interface CalculateNewsCell : UITableViewCell

/** model */
@property(nonatomic, strong)NewsModel *model;

@end

NS_ASSUME_NONNULL_END
