//
//  Find_QuestionAnswerTableViewCell.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//
typedef enum : NSUInteger {
    answerDefaultA = 0,
    answerDefaultB,
    answerDefaultC,
    answerDefaultD,
    answerRightA,
    answerRightB,
    answerRightC,
    answerRightD,
    answerRight,
    answerError
} answerType;

#import <UIKit/UIKit.h>

@interface Find_QuestionAnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property(nonatomic,assign) answerType  type;

@end
