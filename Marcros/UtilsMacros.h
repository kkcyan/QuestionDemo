//
//  UtilsMacros.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/3/21.
//  Copyright © 2017年 boran. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h


/**
 使图片圆角
 */
#pragma mark - 使..圆角
#define ROUNDCORNER(imageView,roundCorner)  (imageView).layer.masksToBounds = YES; (imageView).layer.cornerRadius = roundCorner
///缺省页
#define NETLOADINGRESULTVIEWNOTHING(targetView)  self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, 100, 200, 200)];self.imageView.image = [UIImage imageNamed:@"img_big_no_product"];[(targetView) addSubview:self.imageView];
#define NETLOADINGRESULTVIEWNOINFO(targetView)  self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, 100, 200, 200)];self.imageView.image = [UIImage imageNamed:@"img_big_no_info"];[(targetView) addSubview:self.imageView];

///刷新
#define  CYAN_MJGIFREFRESHHEADER(customMethod) MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector((customMethod))];\
[header setImages:self.refreshImages forState:MJRefreshStateRefreshing];\
[header setImages:self.normalImages forState:MJRefreshStateIdle];\
[header setImages:self.refreshImages forState:MJRefreshStatePulling];\
header.lastUpdatedTimeLabel.hidden= YES;

#define  CYAN_MJGIFREFRESHFOOTER(customMethod) MJRefreshAutoGifFooter *footer =[MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector((customMethod))];\
[footer setImages:self.refreshImages forState:MJRefreshStateRefreshing];\
[footer setImages:self.normalImages forState:MJRefreshStateIdle];\
[footer setImages:self.refreshImages forState:MJRefreshStatePulling];


#pragma -mark 让separator 从头开始
//让separator 从头开始
#define TABLE_VIEW_CELL_SEPARATOR_FILL(tableViewCell) \
if ([(tableViewCell) respondsToSelector:@selector(setSeparatorInset:)]) \
{\
[(tableViewCell) setSeparatorInset:UIEdgeInsetsZero];\
}\
if ([(tableViewCell) respondsToSelector:@selector(setLayoutMargins:)]) \
{\
[(tableViewCell) setLayoutMargins:UIEdgeInsetsZero];\
}

//自定义方法 ，让separator 从头开始
#define TABLE_VIEW_CELL_SEPARATOR_FILL_METHOD(tableView) \
-(void)viewDidLayoutSubviews\
{\
if ([(tableView) respondsToSelector:@selector(setSeparatorInset:)]) {\
[(tableView) setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];\
}\
if ([(tableView) respondsToSelector:@selector(setLayoutMargins:)]) {\
[(tableView) setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];\
}\
}

///MBProgressHUD提示框.png
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define kWindow [UIApplication sharedApplication].keyWindow
#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \
#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()
#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]
#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \
#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

/**
 正则表达
 */
#pragma mark - 正则表达
//判断邮箱是否规则
#define IsValidEmail(email)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"] evaluateWithObject:email]
//判断电话号码是否规则
#define IsValidPhoneNum(phoneNum)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",phoneNum]]
//判断用户名是否规则
#define IsValidUserName(userName)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z][a-zA-Z0-9_]{1,17}$"] evaluateWithObject:userName]
//判断用户密码是否规则
#define IsValidUserPwd(pwd)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(\\w){6,20}$"] evaluateWithObject:pwd]
//判断文件名是否规则
#define IsValidFileName(fileName)\
[fileName rangeOfString:@"\\"].length ? NO : [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^*[^?<>:/\"|*]*$"] evaluateWithObject:fileName]
//自定义
#define IsValidText(text,matches)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", matches] evaluateWithObject:text]

//str  format
#define STRING_FORMAT(str)        [[NSString stringWithFormat:@"%@",str] format]

//版本号
#define AppVersion          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

//默认数据库
#define UserDefaults                      [NSUserDefaults standardUserDefaults]
#define RemoveUserInfo(userInfoKeys)          [UserDefaults setObject:@"" forKey:userInfoKeys];[UserDefaults removeObjectForKey:userInfoKeys]


#define differentUserDB(tableName) [NSString stringWithFormat:@"%@%@",tableName,[UserDefaults objectForKey:oyxc_token]]

#define cyan_appVersionNum(versionNum) [NSString stringWithFormat:@"%@%@",versionNum,[UserDefaults objectForKey:cyan_appVersion]]

#define HUDColor  [UIColor colorWithRed:0.8706 green:0.5765 blue:0.1373 alpha:0.8]

#define cyan_ShowTabBar    MainViewController *main=(MainViewController *)self.tabBarController;\
[main showOrHiddenTabBar:NO];
#define cyan_HiddenTabBar    MainViewController *main=(MainViewController *)self.tabBarController;\
[main showOrHiddenTabBar:YES]
#define cyan_makeTheBackBar   UIBarButtonItem *back=[[UIBarButtonItem alloc]init];back.title=@"";self.navigationItem.backBarButtonItem=back;


#define  showPrompt(_tag)    MainViewController *main1=(MainViewController *)self.tabBarController;\
[main1 showPrompt:(_tag)]

#define  hiddenPrompt(_tag)    MainViewController *main2=(MainViewController *)self.tabBarController;\
[main2 hiddenPrompr:(_tag)]


/// UserInfo 定义
#define USER_INFO_DATA [UserInfo alloc]

/// UserInfo 实时判断 更新
#define USER_INFO_DATA_UPDATA if ([USER_INFO_DATA.getCommunity stringIsNull]) {\
USER_INFO_DATA.userstate = [USER_INFO_DATA.getOldUserState stringIsNull]||[USER_INFO_DATA.getOldUserState isEqualToString:USER_STATE_STREET] ? USER_STATE_HOME : USER_INFO_DATA.getOldUserState;\
}

typedef NS_ENUM(NSInteger, HUDStype) {
    HUDModeText,
    HUDModeDefault
};

typedef NS_ENUM(NSInteger, HUDSite) {
    HUDSiteCenter,
    HUDSiteBottom
};

typedef NS_ENUM(NSInteger, PayMethod) {
    PayMethodYuE    =   100  ,
    PayMethodWeiXin ,
    PayMethodZhiFuBao,
    PayMethodYinLian,
    
    PayMethodNone
};

enum LoginTypeState{
    //未登录状态
    LoginTypeNone = 0,
    LoginTypeWeibo = 1,
    LoginTypeQQ = 7,
    LoginTypeWeChat = 9,
    //登录正常
    LoginTypeNormal = 100,
};
typedef enum LoginTypeState LoginTypeState;


enum UserTypeState{
    UserTypeNo = 1000,  /// 没有状态
    UserTypeYes,        /// 有状态
};
typedef enum UserTypeState UserTypeState;

#endif /* UtilsMacros_h */
