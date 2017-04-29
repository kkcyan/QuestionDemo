//
//  ToolMarcros.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/3/21.
//  Copyright © 2017年 boran. All rights reserved.
//

#ifndef ToolMarcros_h
#define ToolMarcros_h

/// 颜色
#define UIColorFromRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COLOR_RGB(r, g, b) COLOR_RGBA(r, g, b, 1.0)
#define COLOR_GRAY COLOR_RGB(247, 247, 247)

#define COLOR_CURRENT_APP_THEME UIColorFromRGBHex(0xFFCC00)

#define COLOR_LIGHT_GRAY_BACKGROUND UIColorFromRGBHex(0xF0F0F0)
#define COLOR_DARKGRAY_TEXT [UIColor darkGrayColor]
#define COLOR_THEME_RED UIColorFromRGBHex(0xF15353)//<!-- 红色 -->
#define BUTTON_YELLOW UIColorFromRGBHex(0xE6A32D)//<!-- 按钮黄色 -->
#define THEME_YELLOW UIColorFromRGBHex(0xFFCC00)//<!-- 主题黄色 -->
#define BUTTON_PURPLE UIColorFromRGBHex(0x836A82)//<!-- 按钮紫色 -->
#define LINE_GRAY UIColorFromRGBHex(0xE5E5E5)//<!-- 灰线颜色 -->
#define TEXT_COLOR_GRAY UIColorFromRGBHex(0xA4A4A4)//<!-- 灰字颜色 -->
#define SHOU_HUO_TEXT_COLOR UIColorFromRGBHex(0x958D70)//<!-- 收货地址的字体颜色 -->
#define BLACK UIColorFromRGBHex(0x00000)//<!-- 纯黑色 -->
#define THEME_GRAY UIColorFromRGBHex(0xF5F5F5)//<!-- 背景灰 -->
#define FORGET_PWD_TEXT_COLOR UIColorFromRGBHex(0x705C0A)//<!-- 忘记密码等字体颜色 -->
#define TEXTS_COLOR UIColorFromRGBHex(0x323232)//<!-- 深灰色字体 -->
#define CLICK_GRAY UIColorFromRGBHex(0xDCDCDC)//<!-- 点击灰色 -->

//iOS System Version Begin
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//Device Type Check Begin
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT     ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6PLUS     (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >


//View frame
#define kViewLeft(__view) (__view.frame.origin.x)
#define kViewWidth(__view) (__view.frame.size.width)

#define kViewTop(__view) (__view.frame.origin.y)
#define kViewHeight(__view) (__view.frame.size.height)

#define kViewRight(__view) ( kViewLeft(__view) + kViewWidth(__view) )
#define kViewFoot(__view) ( kViewTop(__view) + kViewHeight(__view) )

//custom by fyj
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  49

#define YJ_MAX_TEXT_FONT [UIFont systemFontOfSize:15]
#define YJ_MIDDLE_TEXT_FONT [UIFont systemFontOfSize:13]
#define YJ_MIN_TEXT_FONT [UIFont systemFontOfSize:11]
#define YJFONT(value) [UIFont systemFontOfSize:value]


#endif /* ToolMarcros_h */
