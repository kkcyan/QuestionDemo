//
//  UINavigationBar+PS.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NavigationBarBGColor [UIColor colorWithRed:32/255.0f green:177/255.0f blue:232/255.0f alpha:1]

//如想实现导航颜色的渐变 ，则translucent 属性不可为no，系统默认为yes
@interface UINavigationBar (PS)
- (void)ps_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ps_setElementsAlpha:(CGFloat)alpha;
- (void)ps_setTranslationY:(CGFloat)translationY;
- (void)ps_setTransformIdentity;
- (void)ps_reset;
@end
