//
//  NSString+Other.h
//  WeiChat
//
//  Created by   清正 on 15/10/20.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///判断字符串是否为空
static inline BOOL isStringEmpty(NSString *value) {
    BOOL result = FALSE;
    if (!value || [value isKindOfClass:[NSNull class]] ||[value isEqualToString:@"null"] ||[value isEqualToString:@"(null)"] ||[value isEqualToString:@"nil"] ||[value isEqualToString:@"<null>"]) {
        result = TRUE;
    } else {
        NSString *trimedString = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([value isKindOfClass:[NSString class]] && [trimedString length] == 0) {
            result = TRUE;
        }
    }
    return result;
}

static inline NSString * isEmptyString(NSString *str){
    return isStringEmpty(str) ? @"" : str;
}


@interface NSString (Other)
/**
 *  fond:字号
 */
- (CGFloat)stringOfSize:(CGFloat)fond;
-(CGSize)stringWithFont:(UIFont*)font;
/**
 *  第一个参数:字号
 *  第二个参数:定宽
 */
- (CGSize)stringOfFond:(CGFloat)fond aWidth:(CGFloat)width;

/**  文字转为图片
 *  arrContent:装字符串(每一项分为一段落)
 *  fontSize:字号
 *  color:字体颜色
 *  width:每行最大宽度
 */
+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize aTextColor:(UIColor*)color aWidth:(CGFloat)width;
//对图片数组中的每一个张图片进行Basr64编码以,分割拼成字符串
+ (NSString *)getStringWithBase64ImageData:(NSMutableArray <UIImage*> *)imageArray;

/**
 *  32位小写 md5 加密
 */
- (NSString *)md5;
/**
 *  32位大写 MD5 加密
 */
- (NSString *)MD5;
/**
 *  字符串(2015-06-25 17:04)转date
 */
+ (NSDate *)stringWithDate:(NSString *)string;
/**
 *  date转字符串(2015-06-25 17:04)
 */
+(NSString *)dateWithString:(NSDate *)date;


///邮箱
- (BOOL)validateEmail;
///手机号码验证
- (BOOL)validateMobile;
///空字符串 => @""
+ (NSString *)stringOfNull:(NSString*)string;
///去除HTML标签对
- (NSString *)trimmedStringWithSpecialString;

///json解析
- (id)jsonResolve;
/**
 *  判断是否含有表情符
 *
 *  @param string 字符串
 *
 *  @return YES/NO
 */
- (BOOL)isContainsEmoji:(NSString *)string;
/**
 *  判断字符串是否为空
 *
 *  @return YES/NO
 */
- (BOOL)stringIsNull;

@end
