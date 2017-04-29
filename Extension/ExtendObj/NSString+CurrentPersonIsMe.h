//
//  NSString+CurrentPersonIsMe.h
//  myhome
//
//  Created by wang kai on 15/5/20.
//  Copyright (c) 2015年 wang kai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CurrentPersonIsMe)
+ (BOOL) currentPersonIsMe:(NSString *)relation;
- (NSString *)format;

@end
