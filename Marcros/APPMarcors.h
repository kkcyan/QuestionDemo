//
//  APPMarcors.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/3/21.
//  Copyright © 2017年 boran. All rights reserved.
//

#ifndef APPMarcors_h
#define APPMarcors_h

/// 广告地址链接
#define BaseAdURL             @"http://182.92.234.109:9078/BRSD/News/Advert/GetAdvertContent"

/// 数据地址链接 .SOAP
#define BaseURL               @"http://182.92.234.109:9078/BRSD/News/PointPay/"
//#define BaseURL               @"http://192.168.5.138:9078/BRSD/News/PointPay/"

/// 数据地址链接 .WCF
#define BaseNesURL            @"http://182.92.234.109:9078/BRSD/News/"  /// 远程服务器
#define BaseLocalURL          @"http://192.168.5.123:9078/BRSD/News/"   /// 本地服务器



//#define TestServieceLocalURL   @"http://192.168.5.117:9078/BRSD/News/IAPPWork/"
#define TestServieceLocalURL   @"http://182.92.234.109:9078/BRSD/News/IAPPWork/"


//掌心快抢
#define ZHXFAST_GET           @"http://www.zhangxinshequ.cn/Web2/KuaiQiangAPP/Index.aspx?uid="

//我的快抢
#define ZHXFAST_MY_LIST       @"http://www.zhangxinshequ.cn/Web2/KuaiQiangAPP/MyList.aspx?uid="





////基类 显示 与 隐藏
#define SHOW_NEW_FEATURE_IS_FOREGROUNE  @"SHOW_NEW_FEATURE_IS_FOREGROUNE"
#define SHOW_NEW_FEATURE  @"IS_NEW_VERSION_SHOW_NEW_FEATURE"
#define SHOW_NEW_FEATURE_SERVICE  @"IS_NEW_VERSION_SHOW_NEW_FEATURE_SERVICE"
#define SHOW_NEW_FEATURE_MANA  @"IS_NEW_VERSION_SHOW_NEW_FEATURE_MANA"
#define SHOW_NEW_FEATURE_EDIT  @"IS_NEW_VERSION_SHOW_NEW_FEATURE_EDIT"
#define SHOW_NEW_TIP_NEW_DAY   @"SHOW_NEW_TIP_NEW_DAY"   ///签到显示
#define SHOW_NEW_TIP_FAST_KNOCK   @"SHOW_NEW_TIP_FAST_KNOCK"   ///快抢显示


#define CYAN_RESTAURANT_NAME   @"CYAN_RESTAURANT_NAME"
#define CYAN_RESTAURANT_ID     @"CYAN_RESTAURANT_ID"

//用户名与密码
#define cyan_isLaunch           @"isLaunch"
#define cyan_userName           @"userName"
#define cyan_userPsd            @"pwd"
#define cyan_token              @"token"//后台分配的token
#define cyan_userId             @"userId"//用户ID
#define cyan_memoryUserId       @"memoryUserId"//记忆大师用户ID
#define cyan_uuid               @"uuid"//uuid
#define cyan_userLogo           @"userLogo"//用户头像
#define cyan_userLoginPhone     @"userLoginPhone"//用户登陆的电话
#define cyan_thirdLoginUID      @"userThirdLoginUID"//用户第三方登陆授权成功后的uid
#define cyan_forgetPWDPhone     @"forgetPWDTelephone"//忘记密码时的手机号
#define cyan_isBandingPhone     @"bangdingPhone"//是否绑定了手机号
#define cyan_bandingPhoneMethod @"bangdingPhoneMethod"//绑定手机号的方式
#define cyan_openID             @"openID"//openID
#define cyan_pToken             @"pToken"//pToken
#define cyan_appVersion         @"appVersionNum"//版本号
#define cyan_isRemoberPWD       @"remeberPassword"//记住密码
#define cyan_isLogin            @"isLogin"//是否已登陆
#define cyan_isCommunity        @"isCommunity"//是否已选择免登陆的基本信息
#define cyan_isCity             @"isCity"
#define cyan_pushSource         @"userPushSource"//是否从提交坐标视图调至便利店列表
#define cyan_backToSource       @"fromMine_ShoppingCarToStore"//从购物车进入便利店，再返回时的控制器
#define cyan_service            @"ServiceViewController"
#define cyan_store              @"StoreViewController"
#define cyan_main               @"MainViewController"
#define cyan_userLastLocationState  @"userLastLocationState"//用户的位置状态
#define cyan_userShouldChooseLocationState    @"cyan_userShouldChooseLocationState"//用户选择的状态

#define cyan_cityId             @"cityid"//城市id
#define cyan_communityid        @"communityid"//社区id
#define cyan_community          @"community"//社区id
#define cyan_expressesName      @"expressesName"//快递公司
#define cyan_expressesId        @"expressesId"//快递公司id
#define cyan_storeId            @"storeid"//便利店id
#define cyan_storeName          @"storeName"//便利店名称

#define cyan_restaurantId            @"cyan_restaurantId"//便利店id
#define cyan_restaurantName          @"restaurantName"//便利店名称

#define cyan_userAddressId      @"userAddressId"//用户的收获地址

#define cyan_longitude          @"userStateLongitude"//JING
#define cyan_latitude           @"userStateLatitude"//WEI

#define cyan_locallongitude          @"localuserStateLongitude"//local JING
#define cyan_locallatitude           @"localuserStateLatitude"//local WEI

#define cyan_carouselPicImgUrl     @"carouselPicImgUrl"  //轮播图url
#define cyan_carouselPicImg        @"carouselPicImg"     //轮播图图片
#define cyan_carouselPicTitle      @"carouselPicTitle"   //轮播标题

#define cyan_yes                   @"yes"//
#define cyan_no                    @"no"
#define cyan_default               @"default"      //绑定手机号方式
#define cyan_middle                @"middleDuring"

#define SERVICE_ON_DOOR   @"servieceOnDoor" //上门服务


#define isToTop               @"isToTop"

#endif /* APPMarcors_h */
