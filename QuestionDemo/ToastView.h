//
//  ToastView.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/29.
//  Copyright © 2017年 boran. All rights reserved.
//

typedef enum : NSUInteger {
    ToastLocationTop = 0,
    ToastLocationCenter,
    ToastLocationBottom,
} ToastLocationType;

typedef void(^toastDismissBlock)();

#import <UIKit/UIKit.h>

@interface ToastView : UIView

@property(nonatomic,assign) ToastLocationType type;
@property(nonatomic,copy) toastDismissBlock dismissBlock;

-(instancetype)initWithType:(ToastLocationType)type
                    content:(NSString *)content
                presentView:(UIView *)presentView
                      delay:(int)timer
                      block:(toastDismissBlock)block;

-(void)show;
-(void)dismiss;

@end
