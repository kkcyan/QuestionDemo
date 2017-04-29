//
//  Find_QuestionBottomNewView.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Find_QuestionBottomNewView : UIView
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *rightNum;
@property (weak, nonatomic) IBOutlet UILabel *errrowNum;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (nonatomic,copy) void(^clickNextBlock)();
@property (nonatomic,copy) void(^clickTapBlock)();

-(instancetype)craetView;

- (IBAction)clickNextBtn:(UIButton *)sender;
- (IBAction)tap:(UITapGestureRecognizer *)sender;
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender;
@end
