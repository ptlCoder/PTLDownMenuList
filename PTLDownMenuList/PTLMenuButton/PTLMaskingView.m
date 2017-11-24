//
//  PTLMaskingView.m
//  PTLDownMenuList
//
//  Created by soliloquy on 2017/11/20.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import "PTLMaskingView.h"

@interface PTLMaskingView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** 数据源 */
@property (nonatomic, strong) NSArray *dataSource;
/** 记录选中哪个菜单按钮 */
@property (nonatomic, assign) NSInteger menuIndex;

@property (nonatomic, strong) NSMutableDictionary *status;
@end

@implementation PTLMaskingView

-(NSMutableDictionary *)status {
    if (!_status) {
        _status = [[NSMutableDictionary alloc]init];
    }
    return _status;
}

-(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSArray alloc]init];
    }
    return _dataSource;
}

- (void)getDataSource:(NSArray *)arr menuIndex:(NSInteger)menuIndex {
    self.dataSource = [NSArray arrayWithArray:arr];
    _menuIndex = menuIndex;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [[UIView alloc]init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}


- (void)setupUI {

    [self addSubview:self.tableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

- (void)reloadData {
    
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.dataSource.count * 44.0;
    if (h >= self.frame.size.height) {
        h = self.frame.size.height;
    }
    self.tableView.frame = CGRectMake(0, 0, w, h);
    [self.tableView reloadData];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    if (self.status[@(_menuIndex)] == indexPath) {
        cell.textLabel.textColor = [UIColor redColor];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectRowBlock) {
        self.selectRowBlock(indexPath.row, _dataSource[indexPath.row]);
    }
    // 记录选中菜单对应的indexPath
    self.status[@(_menuIndex)] = indexPath;
    [self.tableView reloadData];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{

        CGRect rect = self.tableView.frame;
        rect.size.height = 0;
        self.tableView.frame = rect;
        
        
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}


- (void)show:(UIView *)superView {
    [superView addSubview:self];
}

@end
