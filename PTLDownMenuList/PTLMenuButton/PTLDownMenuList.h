//
//  PTLDownMenuList.h
//  PTLDownMenuList
//
//  Created by soliloquy on 2017/11/20.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissBlock)(void);

@class PTLMaskingView;

@interface PTLDownMenuList : UIView
/** 蒙版 */
@property (nonatomic, strong) PTLMaskingView *maskingView;
/** <#注释#> */
@property (nonatomic, copy)DismissBlock dismissBlock;
@end
