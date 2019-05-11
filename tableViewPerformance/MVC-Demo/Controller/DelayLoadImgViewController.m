//
//  DelayLoadImgViewController.m
//  MVC-Demo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "DelayLoadImgViewController.h"
#import "NewsModel.h"
#import "DelayLoadImgCell.h"
#import <objc/runtime.h>

//定义一个block，用来存放加载图片的事件
typedef BOOL(^RunloopBlock)(void);

@interface DelayLoadImgViewController ()<UITableViewDataSource, UITableViewDelegate>
/** tableView */
@property(nonatomic, strong)UITableView *tableView;
/** dataSource */
@property(nonatomic, strong)NSMutableArray<NewsModel *> *dataSource;
/** header view */
@property(nonatomic, strong)UIView *headerView;
/** tasks */
@property(nonatomic, strong)NSMutableArray *tasks;
/** max */
@property(nonatomic, assign)NSUInteger max;
/** timer */
@property(nonatomic, strong)NSTimer *timer;
@end

static NSString *cellId = @"NewsCellId";

@implementation DelayLoadImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupData];
    // drawUI
    [self drawUI];
    // add observer
    [self addRunloopObserver];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)setupData {
    [self.dataSource addObjectsFromArray:[self getRandomData]];
    self.max = 20;
}

- (void)drawUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.tableView reloadData];
}

#pragma mark - observer

// 监听 runloop 状态
- (void)addRunloopObserver {
    // 获取当前 runloop
    //获得当前线程的runloop，因为我们现在操作都是在主线程，这个方法就是得到主线程的runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();

    //定义一个观察者,这是一个结构体
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };

    // 定义一个观察者
    static CFRunLoopObserverRef defaultModeObsever;
    // 创建观察者
    defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                 kCFRunLoopBeforeWaiting,   // 观察runloop等待的时候就是处于NSDefaultRunLoopMode模式的时候
                                                 YES,   // 是否重复观察
                                                 NSIntegerMax - 999,
                                                 &Callback, // 回掉方法，就是处于NSDefaultRunLoopMode时候要执行的方法
                                                 &context);
    
    // 添加当前 RunLoop 的观察者
    CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
    //c语言有creat 就需要release
    CFRelease(defaultModeObsever);
}

// 每次 runloop 回调执行代码块
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    DelayLoadImgViewController *vc = (__bridge DelayLoadImgViewController *)(info);  // 这个info就是我们在context里面放的self参数
    
    if (vc.tasks.count == 0) {
        return;
    }
    
    BOOL result = NO;
    while (result == NO && vc.tasks.count) {
        NSLog(@"开始执行加载图片总任务数:%d",vc.tasks.count);
        // 取出任务
        RunloopBlock unit = vc.tasks.firstObject;
        // 执行任务
        result = unit();
        // d干掉第一个任务
        [vc.tasks removeObjectAtIndex:0];
    }
}

#pragma mark - Task

// 添加任务
- (void)addTask:(RunloopBlock)unit {
    [self.tasks addObject:unit];
    
    // 保证之前没有显示出来的任务,不再浪费时间加载
    if (self.tasks.count > self.max) {
        [self.tasks removeObjectAtIndex:0];
    }
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
    DelayLoadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    // 将加载绘制图片操作丢到任务中去
    [self addTask:^BOOL{
        [cell drawImg];
        return YES;
    }];
    return cell;
}

#pragma mark - like network + data dealwith

- (void)postLikeNetwork:(NewsModel *)newsModel {
    NSString *api = @"http://rap2api.taobao.org/app/mock/163155/gaoshilist"; // 告示
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:api] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                [self dealwithLikeData:newsModel.newsId];
            }
        });
    }];
    [task resume];
}

- (void)dealwithLikeData:(NSString *)newsId {
    __block NewsModel *newsModel;
    [self.dataSource enumerateObjectsUsingBlock:^(NewsModel *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.newsId isEqualToString:newsId]) {
            newsModel = obj;
            *stop = YES;
        }
    }];
    if (newsModel) {
        newsModel.like = !newsModel.like;
        if (newsModel.like) {
            newsModel.likeNum += 1;
        } else {
            newsModel.likeNum -= 1;
        }
        [self updateNewsView:newsModel];
    }
}

#pragma mark - alert

- (void)alertMessage:(NewsModel *)newsModel preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@\n%@",newsModel.title,newsModel.subTitle] message:newsModel.content preferredStyle:preferredStyle];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertVC addAction:okAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - private

// 获取时间戳 - new id
- (NSString *)getNowTimeTimestamp2{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

#pragma mark - lazy

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        lbe.font = [UIFont systemFontOfSize:16];
        lbe.textColor = [UIColor redColor];
        lbe.textAlignment = NSTextAlignmentCenter;
        [lbe sizeToFit];
        [_headerView addSubview:lbe];
        
        [lbe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headerView.mas_centerX);
            make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
        }];
    }
    return _headerView;
}

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
        _tableView.estimatedRowHeight = 250;//预估高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[DelayLoadImgCell class] forCellReuseIdentifier:cellId];
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

- (NSMutableArray *)tasks {
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    return _tasks;
}

@end
