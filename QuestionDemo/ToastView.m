//
//  ToastView.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/29.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "ToastView.h"

@interface ToastView ()
{
    UIView * presentV;
    NSString * contentS;
    int delayTime;
    
    UILabel * contentLable;
}

@end

@implementation ToastView

-(instancetype)initWithType:(ToastLocationType)type
                    content:(NSString *)content
                presentView:(UIView *)presentView
                      delay:(int)timer
                      block:(toastDismissBlock)block{
    if (self == [super initWithFrame:CGRectZero]) {
        
        presentV = presentView;
        contentS = content;
        delayTime = timer;
        _dismissBlock = block;
        _type = type;
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGSize  fSize = [contentS stringOfFond:14 aWidth:(SCREEN_WIDTH - 50 - 28)];
    
    contentLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 14, fSize.width, fSize.height)];
    contentLable.text = contentS;
    contentLable.numberOfLines = 0;
    contentLable.textColor = UIColorFromRGBHex(0x794520);
    contentLable.font = [UIFont systemFontOfSize:14];
    [self addSubview:contentLable];
    
    CGSize  sSize = CGSizeMake(fSize.width+28, fSize.height+28);
    self.backgroundColor = UIColorFromRGBHex(0xffc345);
    ROUNDCORNER(self, 7);
    
    switch (_type) {
        case ToastLocationCenter:
        {
            CGFloat X = (SCREEN_WIDTH - sSize.width)/2.00;
            CGFloat Y = (SCREEN_HEIGHT - sSize.height)/2.00;
            self.frame = CGRectMake(X, Y, sSize.width , sSize.height);
        }
            break;
        case ToastLocationBottom:
        {
            CGFloat X = (SCREEN_WIDTH - sSize.width)/2.00;
//            CGFloat Y = (SCREEN_HEIGHT - sSize.height)/2.00;
            CGFloat Y = SCREEN_HEIGHT - 300 - sSize.height/2.00;
            self.frame = CGRectMake(X, Y, sSize.width , sSize.height);
        }
            break;
        default:
            break;
    }
    
}
-(void)show{
    
    [self removeFromSuperview];
    
    self.alpha = 0.0;
    
    [presentV addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1.0f;
    } completion:nil];
    
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:delayTime];

}
-(void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
