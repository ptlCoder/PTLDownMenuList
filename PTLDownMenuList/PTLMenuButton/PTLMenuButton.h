//
//  PTLMenuButton.h
//  PTLDownMenuList
//
//  Created by soliloquy on 2017/11/20.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTLMenuButton;
@protocol PTLMenuButtonDelegate <NSObject>

- (void)ptl_menuButton:(PTLMenuButton *)menuButton didSelectMenuButtonAtIndex:(NSInteger)index selectMenuButtonTitle:(NSString *)title listRow:(NSInteger)row rowTitle:(NSString *)rowTitle;

@end

@interface PTLMenuButton : UIView

/** 列对应的数据源 */
@property (nonatomic, strong) NSArray<NSArray *> *listTitles;
@property (nonatomic, weak) id<PTLMenuButtonDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame menuTitles:(NSArray *)menuTitles;

@end
