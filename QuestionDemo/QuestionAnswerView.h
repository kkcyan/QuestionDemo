//
//  QuestionAnswerView.h
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionAnswerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *rightAnswer;

@property (nonatomic,strong) NSDictionary * dic;

@property (nonatomic,copy) void(^block)(NSDictionary *dic);

-(instancetype)creatView;

@end


