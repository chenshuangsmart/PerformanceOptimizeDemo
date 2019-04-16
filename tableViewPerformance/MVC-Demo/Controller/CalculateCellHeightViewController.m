//
//  CalculateCellHeightViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/4/16.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CalculateCellHeightViewController.h"
#import "CalculateNewsCell.h"
#import "NewsModel.h"

@interface CalculateCellHeightViewController ()<UITableViewDataSource, UITableViewDelegate>
/** tableView */
@property(nonatomic, strong)UITableView *tableView;
/** dataSource */
@property(nonatomic, strong)NSMutableArray<NewsModel *> *dataSource;
@end

static NSString *cellId = @"NewsCellId";
#define kImgViewWH (kScreenWidth - 20 - 15) / 4.0

@implementation CalculateCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupData];
    // drawUI
    [self drawUI];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)setupData {
    [self.dataSource addObjectsFromArray:[self getRandomData]];
}

- (void)drawUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.tableView reloadData];
}

#pragma mark - loadData

- (void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.pullToRefreshView stopAnimating];
        NSArray *datas = [self getRandomData];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datas];
        [self.tableView reloadData];
    });
}

- (void)loadNextPage {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.infiniteScrollingView stopAnimating];
        NSArray *newRows = [self getRandomData];
        [self.dataSource addObjectsFromArray:newRows];
        [self.tableView beginUpdates];
        
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        NSInteger total = [self.tableView numberOfRowsInSection:0];
        for (NSUInteger i = (NSUInteger) total; i < self.dataSource.count; i++) {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [self.tableView insertRowsAtIndexPaths:arrayWithIndexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    });
}

#pragma mark - get

- (NSArray *)getRandomData {
    NSMutableArray *models = [NSMutableArray array];
    int number = arc4random_uniform(30);
    for (int i = 0; i < 20 + number; i++) {
        NewsModel *model = [[NewsModel alloc] init];
        model.icon = [[NewsHandler shareInstance].icons objectAtIndex:arc4random_uniform(10)];
        model.title = [[NewsHandler shareInstance].titles objectAtIndex:arc4random_uniform(10)];
        model.subTitle = [[NewsHandler shareInstance].subTitles objectAtIndex:arc4random_uniform(10)];
        model.content = [[NewsHandler shareInstance].contents objectAtIndex:arc4random_uniform(20)];
        NSUInteger index = arc4random_uniform(6);
        NSMutableArray *imgs = [NSMutableArray array];
        for (int i = 0; i < index; i++) {
            [imgs addObject:[[NewsHandler shareInstance].imgs objectAtIndex:arc4random_uniform(20)]];
        }
        if (imgs.count > 0) {
            model.imgs = imgs.copy;
        }
        model.newsId = [NSString stringWithFormat:@"%@%d",[self getNowTimeTimestamp2],i];
        model.attention = arc4random_uniform(10) % 3 == 0;
        model.like = arc4random_uniform(10) % 2 == 0;
        model.shareNum = arc4random_uniform(100);
        model.discussNum = arc4random_uniform(100);
        model.likeNum = arc4random_uniform(100) + 1;
        
        model.rowHeight = [self calculateNewsCellHeight:model];
        [models addObject:model];
    }
    return models.copy;
}

#pragma mark - updateData

- (void)updateNewsView:(NewsModel *)newsModel {
    __block NSUInteger index = NSNotFound;
    [self.dataSource enumerateObjectsUsingBlock:^(NewsModel *obj, NSUInteger idx, BOOL *stop) {
        if ([newsModel.newsId isEqualToString:obj.newsId]) {
            index = idx;
            *stop = YES;
        }
    }];
    if (index == NSNotFound) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = [self.dataSource objectAtIndex:indexPath.row];
    CalculateNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = [self.dataSource objectAtIndex:indexPath.row];
    return model.rowHeight;
}

#pragma mark - private

// 获取时间戳 - new id
- (NSString *)getNowTimeTimestamp2{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

- (CGFloat)getContentHeight:(NSString *)content {
    CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16 ]}
                                          context:nil].size;
    return size.height;
}

- (CGFloat)calculateNewsCellHeight:(NewsModel *)model {
    float contentHeight = 64;
    contentHeight += ([self getContentHeight:model.content] + 10);
    if (model.imgs.count > 0) {
        contentHeight += (kImgViewWH + 10);
    }
    return (contentHeight + 44 + 5);   
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = true;
        _tableView.backgroundColor = [UIColor whiteColor];;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = YES;
        [_tableView registerClass:[CalculateNewsCell class] forCellReuseIdentifier:cellId];
        __weak typeof(self) weakSelf = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            [weakSelf refreshData];
        }];
        [_tableView addInfiniteScrollingWithActionHandler:^{
            [weakSelf loadNextPage];
        }];
    }
    return _tableView;
}

- (NSMutableArray<NewsModel *> *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
