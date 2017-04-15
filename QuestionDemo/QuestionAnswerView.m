//
//  QuestionAnswerView.m
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import "QuestionAnswerView.h"
#import "QuestionAnswerItemView.h"
@implementation QuestionAnswerView

-(instancetype)creatView{
    return [[NSBundle mainBundle]loadNibNamed:@"QuestionAnswerView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    self.content.text = _dic[@"qcontent"];
    self.rightAnswer.text = [NSString stringWithFormat:@"正确答案：%@",_dic[@"ranswer"]];
    
    NSArray * arr = _dic[@"qchoose"];
    
    for (int i=0; i< arr.count; i++) {
        
        NSDictionary * adic = arr[i];
        NSString * num = adic[@"aid"];
        NSString * content = adic[@"acontent"];
        
        QuestionAnswerItemView * item = [[QuestionAnswerItemView alloc]creatView];
        item.frame = CGRectMake(0, 40*i, self.contentView.frame.size.width, 40);
        
        item.backgroundColor = [UIColor whiteColor];
        
        item.num.text = num;
        item.answer.text = content;
        
        if ([_dic[@"chooseanser"] isEqualToString:@"0"]) {
            item.btn.userInteractionEnabled = YES;
            item.btn.enabled = YES;
            self.rightAnswer.hidden = YES;}
        else{
            item.btn.userInteractionEnabled = NO;
            item.btn.enabled = NO;
            self.rightAnswer.hidden = NO;
            if ([num isEqualToString:_dic[@"chooseanser"]]) {
                item.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1];
            }
            if ([num isEqualToString:_dic[@"ranswer"]]){
                item.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:1];
            }
        }
        
        item.clickItemBlock = ^(NSString *str) {
            self.rightAnswer.hidden = NO;
            
            NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dic];
            
            [mdic setValue:str forKey:@"chooseanser"];
            
            
            for (QuestionAnswerItemView * item in self.contentView.subviews) {
                if ([item.num.text isEqualToString:mdic[@"chooseanser"]]) {
                    item.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1];
                }
                if ([item.num.text isEqualToString:_dic[@"ranswer"]]){
                    item.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:1];
                }
            }
            
            self.block(mdic);
            
//            NSLog(@"%@  __  %@",mdic,str);
        };
        
        [self.contentView addSubview:item];
    }
    
}
@end


//@implementation QuestionAnswerItemView
//
//-(instancetype)creatView{
//    return [[NSBundle mainBundle]loadNibNamed:@"QuestionAnswerView" owner:nil options:nil][1];
//}
//
//@end
