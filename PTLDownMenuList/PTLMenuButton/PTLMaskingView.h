//
//  PTLMaskingView.h
//  PTLDownMenuList
//
//  Created by soliloquy on 2017/11/20.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectRowBlock)(NSInteger row, NSString *rowTitle);

@interface PTLMaskingView : UIView

/** <#注释#> */
@property (nonatomic, copy) SelectRowBlock selectRowBlock;

- (void)getDataSource:(NSArray *)arr menuIndex:(NSInteger)menuIndex;

- (void)reloadData;
- (void)dismiss;
- (void)show:(UIView *)superView;
@end
