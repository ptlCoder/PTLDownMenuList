//
//  PTLMenuButton.m
//  PTLDownMenuList
//
//  Created by soliloquy on 2017/11/20.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#define kKeyWindow   ([UIApplication sharedApplication].keyWindow)
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)


#import "PTLMenuButton.h"
#import "PTLDownMenuList.h"
#import "PTLMaskingView.h"

@interface PTLMenuButton()

/** 菜单按钮 */
@property (nonatomic, strong) NSMutableArray *menuButtons;
/** 菜单文字 */
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) PTLDownMenuList *listView;

/** <#注释#> */
@property (nonatomic, strong) UIButton *selectBtn;


@end

@implementation PTLMenuButton


- (PTLDownMenuList *)listView {
    if (!_listView) {
        _listView = [[PTLDownMenuList alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.frame)-64)];
        __weak typeof(self)weakSelf = self;
        [_listView setDismissBlock:^{

            // 改变遮罩改变button状态
            // 还原默认颜色
            [weakSelf.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weakSelf.selectBtn.selected = NO;
            
        }];
    }
    return _listView;
}



-(NSMutableArray *)menuButtons {
    if (!_menuButtons) {
        _menuButtons = [[NSMutableArray alloc]init];
    }
    return _menuButtons;
}

- (instancetype)initWithFrame:(CGRect)frame menuTitles:(NSArray *)menuTitles
{
    self = [super initWithFrame:frame];
    if (self) {

        _menuTitles = menuTitles;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    if (!_menuTitles.count) return;
    for (NSInteger i = 0; i < _menuTitles.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        btn.tag = i;
        [btn setTitle:_menuTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didSelectMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.menuButtons addObject:btn];
    }
}

-(void)setListTitles:(NSArray<NSArray *> *)listTitles {
    _listTitles = listTitles;
}

#pragma mark - 菜单按钮点击事件
- (void)didSelectMenuButton:(UIButton *)button {
    [self.superview addSubview:self.listView];
    
    if (self.selectBtn == button) {
        self.selectBtn.selected = !self.selectBtn.selected;
        
    }else {
        // 还原默认颜色
        [self.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.selectBtn.selected = NO;
        self.selectBtn = button;
        self.selectBtn.selected = YES;
    }

    if (self.selectBtn.selected) {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }else {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.listView.maskingView dismiss];

    }

    NSInteger index = button.tag;
    
    [self.listView.maskingView getDataSource:_listTitles[index] menuIndex:index];
    __weak typeof(self) weakSelf = self;
    [self.listView.maskingView setSelectRowBlock:^(NSInteger row, NSString *rowTitle) {

        if ([weakSelf.delegate respondsToSelector:@selector(ptl_menuButton:didSelectMenuButtonAtIndex:selectMenuButtonTitle:listRow:rowTitle:)]) {
            [weakSelf.delegate ptl_menuButton:weakSelf didSelectMenuButtonAtIndex:index selectMenuButtonTitle: button.currentTitle listRow:row rowTitle:rowTitle];
        }
        
    }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = kScreenWidth / self.menuButtons.count;
    CGFloat h = self.bounds.size.height;
    for (NSInteger i = 0; i < self.menuButtons.count; i ++) {
        UIButton *btn = (UIButton *)self.menuButtons[i];
        btn.frame = CGRectMake(i*w, 0, w, h);
    }
    
}

@end
