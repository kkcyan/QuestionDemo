//
//  Find_QuestionBottomNewView.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "Find_QuestionBottomNewView.h"

@implementation Find_QuestionBottomNewView

-(instancetype)craetView{
    return [[NSBundle mainBundle]loadNibNamed:@"Find_QuestionBottomNewView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}


- (IBAction)clickNextBtn:(UIButton *)sender {
//    ZXLog(@"hnext btn");
    self.clickNextBlock();
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
//    ZXLog(@"tap btn");
    self.clickTapBlock();
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
//    ZXLog(@"swipe btn %lu",(unsigned long)sender.direction);
}
@end
