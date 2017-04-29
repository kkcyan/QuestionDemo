//
//  ACMarcors.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/3/21.
//  Copyright © 2017年 boran. All rights reserved.
//

#ifndef ACMarcors_h
#define ACMarcors_h

/// 单例
#undef	SINGLETON_INTERFACE
#define SINGLETON_INTERFACE( __class ) \
+ (__class *)sharedInstance;

#undef	SINGLETON_IMPLEMENTATION
#define SINGLETON_IMPLEMENTATION( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

/// 自定义 log
#ifdef DEBUG
#define ZXLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define ZXLog( s, ... )
#endif

#ifdef DEBUG
#define DLog( fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" fmt), _FILE_,_FUNCTION_,_LINE_,##_VA_ARGS_);
#else
#define DLog(...);
#endif

#pragma -mark weadSelf
#define WS  __weak __typeof(&*self)weakSelf = self;
#define YJWeakType(type) __weak typeof(type) weak##type = type;
#define YJBlockType(type) __block typeof(type) weak##type = type;

/// 友情提示  text  bottom
#define HUD_TIP_BOTTOM_TEXT(content) [self showHudWithView:self.view withDelay:1 withTitle:nil withDetailTitle:(content) withColor:HUDColor withDimBackgroud:NO withStype:HUDModeText withSite:HUDSiteBottom];

/// 连接网络前的加载框 
#define NET_WORKING_BEFORE_IMG_CENTER_TIP(content) [self showHudWithView:self.view  withDelay:0 withTitle:nil withDetailTitle:(content) withColor:HUDColor withDimBackgroud:NO withStype:HUDModeDefault withSite:HUDSiteCenter];

/// 网络连接成功，但数据返回错误
#define NET_WORKING_LINK_SUCCESS_STATUS_FAILT(content) [weakSelf showHudWithView:self.view withDelay:1 withTitle:nil withDetailTitle:(content) withColor:HUDColor withDimBackgroud:NO withStype:HUDModeText withSite:HUDSiteBottom];

/// 网络连接失败
#define NET_WORKING_LINK_FAILT  [weakSelf dismissHUD]; [weakSelf showHudWithView:weakSelf.view withDelay:1 withTitle:nil withDetailTitle:@"请检查你的网络环境..." withColor:HUDColor withDimBackgroud:NO withStype:HUDModeText withSite:HUDSiteCenter];

#endif /* ACMarcors_h */
