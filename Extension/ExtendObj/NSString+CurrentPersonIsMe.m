//
//  NSString+CurrentPersonIsMe.m
//  myhome
//
//  Created by wang kai on 15/5/20.
//  Copyright (c) 2015年 wang kai. All rights reserved.
//

#import "NSString+CurrentPersonIsMe.h"

@implementation NSString (CurrentPersonIsMe)

//+ (BOOL) currentPersonIsMe:(NSString *)relation
//{
//    if (!VALID_STRING(relation)) {
//        return YES;
//    }
//    if (([relation hasPrefix:@"m"] || [relation hasPrefix:@"f"]) ){
//        NSRange range = [relation rangeOfString:@"."];
//        if (range.length == 0) {
//            return YES;
//        }
//    }
//    return NO;
//}
- (NSString *)format
{
    if (self.length>0 && [self rangeOfString:@"null"].location == NSNotFound) {
        return self;
    }
    return @"";
}
@end
