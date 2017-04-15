//
//  QuestionAnswerItemView.h
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionAnswerItemView : UIView
- (IBAction)clickBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *answer;
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (nonatomic,copy) void(^clickItemBlock)(NSString * str);

-(instancetype)creatView;

@end
