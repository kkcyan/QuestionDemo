//
//  QuestionAnswerItemView.m
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import "QuestionAnswerItemView.h"

@implementation QuestionAnswerItemView

-(instancetype)creatView{
    return [[NSBundle mainBundle]loadNibNamed:@"QuestionAnswerItemView" owner:nil options:nil][0];
}


- (IBAction)clickBtn:(id)sender {
    
    self.clickItemBlock(self.num.text);
    
}
@end
