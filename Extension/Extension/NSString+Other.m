//
//  NSString+Other.m
//  WeiChat
//
//  Created by   清正 on 15/10/20.
//  Copyright (c) 2015年 qingZheng. All rights reserved.
//

#import "NSString+Other.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>  //DES 加密
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation NSString (Other)
//定高 算占有宽
- (CGFloat)stringOfSize:(CGFloat)fond {
    CGSize strSize = [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fond]}];
    return strSize.width;
}
-(CGSize)stringWithFont:(UIFont*)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}
//定宽 算占有高
- (CGSize)stringOfFond:(CGFloat)fond aWidth:(CGFloat)width {
    CGRect stringRect=[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fond]} context:nil];
    return stringRect.size;
}

//文字转图片
+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize aTextColor:(UIColor*)color aWidth:(CGFloat)width {
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent stringOfFond:fontSize aWidth:width];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(width+20, fHeight+50);
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    CGContextSetRGBFillColor (ctx, 0.1, 0.2, 0.3, 1); // 6
    CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, width, [numHeight floatValue]);
        
        [sContent drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//小写md5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
//大写MD5加密
- (NSString *)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

#pragma mark ----------------时间转化----------------

//字符串(2015-06-25 17:04)转date
+(NSDate *)stringWithDate:(NSString *)string{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"HH:mm"];     //设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

//date转字符串
+(NSString *)dateWithString:(NSDate *)date {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"HH:mm"];/* */    //设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

#pragma mark -------------------正则判断------------------
///邮箱
- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

///手机号码验证
- (BOOL)validateMobile {
    //手机号以13， 15，17, 18开头，八个 \d 数字字符
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (id)jsonResolve {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
}

#pragma mark --------字符处理----------
//替换空字符串
+ (NSString *)stringOfNull:(NSString*)string {
    NSString *result =@"";
    if (!string || [string isKindOfClass:[NSNull class]]) {
        result = @"";
    } else if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] ||[string isEqualToString:@"nil"]) {
        result = @"";
    } else {
        result =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([result isKindOfClass:[NSString class]] && [result length] == 0) {
            result = @"";
        }
    }
    return result;
}
//去除HTML标签对
- (NSString *)trimmedStringWithSpecialString {
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|\r" options:0 error:nil];
    
    NSString *trimmedString =[regularExpretion stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];//替换所有html和换行匹配元素为"-"
    return trimmedString;
}

+ (NSString *)getStringWithBase64ImageData:(NSMutableArray <UIImage*> *)imageArray {
    NSString *dataString = @",";
    for (UIImage *tmpImg in imageArray) {
        NSData *imgData = UIImageJPEGRepresentation(tmpImg, 0.5);
        NSString *base64Str = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        dataString = [NSString stringWithFormat:@"%@,%@",dataString,base64Str];
    }
    NSString *imageStr = [dataString stringByReplacingOccurrencesOfString:@",," withString:@""];
    return imageStr;
}


//emoji表情判断
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

//yes 字符串不为空 no 为空
- (BOOL)stringIsNull {
    if (self && self.length > 0 && ![self isKindOfClass:[NSNull class]])
        return NO;
    return YES;
}

@end
