//
//  Find_QuestionNewCollectionViewCell.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "Find_QuestionNewCollectionViewCell.h"
#import "Find_QuestionADTTableViewCell.h"
#import "Find_QuestionADTableViewCell.h"
#import "Find_QuestionQuestionTableViewCell.h"
#import "Find_QuestionAnswerTableViewCell.h"
#import "Find_QuestionAanswerTipTableViewCell.h"

@implementation Find_QuestionNewCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
//        ZXLog(@"%@",NSStringFromCGRect(frame));
//        self.contentView.backgroundColor = UIColorFromRGBHex(0xf15353);
        [self setUI];
    }
    return self;
}

-(void)setDataSource:(NSMutableDictionary *)dataSource{
    _dataSource = dataSource;
    _answerArray = @[].mutableCopy;
    
    _answerArray = [NSMutableArray arrayWithArray:_dataSource[@"qchoose"]];
    
    if (_bodyView) {
        [_bodyView reloadData];
    }
    else
        [self setUI];
}

-(void)setUI{
    
    _bodyView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _bodyView.delegate = self;
    _bodyView.dataSource = self;
    _bodyView.backgroundColor = UIColorFromRGBHex(0xffffff);
    _bodyView.tableFooterView = [UIView new];
    _bodyView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bodyView.bounces = NO;
    
    [self addSubview:_bodyView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[@"chooseanser"] isEqualToString:@"0"] ? _answerArray.count + 2 : _answerArray.count + 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        switch (_type) {
            case adTypeImg:
                return 59;
                break;
            case adTypeLabel:
            {
                tableView.estimatedRowHeight = 48;
                return UITableViewAutomaticDimension;
            }
            default:
                return 0.001;
                break;
        }
    }
    else{
        tableView.estimatedRowHeight = 48;
        return UITableViewAutomaticDimension;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// 广告位置
    if (indexPath.row == 0) {
        switch (_type) {
            case adTypeImg:
            {
                Find_QuestionADTableViewCell * ad = [[Find_QuestionADTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Find_QuestionADTableViewCell"];
                ad.selectionStyle = UITableViewCellSelectionStyleNone;
                return ad;
            }
                break;
            case adTypeLabel:
            {
                Find_QuestionADTTableViewCell * ad = [[Find_QuestionADTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Find_QuestionADTTableViewCell"];
                ad.selectionStyle = UITableViewCellSelectionStyleNone;
                return ad;
            }
            default:
            {
                UITableViewCell * cell = [UITableViewCell new];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
        }
    }
    //// 题目位置
    else if (indexPath.row == 1){
        Find_QuestionQuestionTableViewCell * question = [[Find_QuestionQuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Find_QuestionQuestionTableViewCell"];
        question.questionTitle.text = _dataSource[@"qcontent"];
        question.selectionStyle = UITableViewCellSelectionStyleNone;
        return question;
    }
    /// 正确答案提示
    else if (indexPath.row == _answerArray.count + 2){
        Find_QuestionAanswerTipTableViewCell * tip = [[Find_QuestionAanswerTipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Find_QuestionAanswerTipTableViewCell"];
        tip.selectionStyle = UITableViewCellSelectionStyleNone;
        return tip;
    }
    else{
        Find_QuestionAnswerTableViewCell * answer = [[Find_QuestionAnswerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Find_QuestionAnswerTableViewCell"];
        
        /// 正确答案
        if (indexPath.row == _answerArray.count + 3) {
            for(NSDictionary * dic in _answerArray){
            if ([dic[@"aid"] isEqualToString:_dataSource[@"ranswer"]]) {
                answer.title.text = dic[@"acontent"];
                answer.type = [self getType:dic];
            }}
        }
        else{
            NSDictionary * dic = _answerArray[indexPath.row - 2];
            answer.title.text = dic[@"acontent"];
            answer.type = [self getChooseType:dic];
            
        }
        
        answer.selectionStyle = UITableViewCellSelectionStyleNone;
        return answer;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![_dataSource[@"chooseanser"] isEqualToString:@"0"]) {}
    else if (indexPath.row < 2 || indexPath.row > _answerArray.count + 1){}
    else{
        NSDictionary * dic = _answerArray[indexPath.row - 2];
        NSString * str = dic[@"aid"];
        
        NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dataSource];
        
        [mdic setValue:str forKey:@"chooseanser"];
        [mdic setObject:@"-1" forKey:@"lasttime"];
        
        [self.bodyView reloadData];
        
        self.clickAnswerBlcok(mdic);

    }
}

-(answerType)getType:(NSDictionary *)dic{
    if ([dic[@"aid"] isEqualToString:@"A"]) {
        return answerRightA;
    }
    else if ([dic[@"aid"] isEqualToString:@"B"]) {
        return answerRightB;
    }
    else if ([dic[@"aid"] isEqualToString:@"C"]) {
        return answerRightC;
    }
    else {
        return answerRightD;
    }
}
-(answerType)getChooseType:(NSDictionary *)dic{
    /// 如果还没有选择
    if ([_dataSource[@"chooseanser"] isEqualToString:@"0"]) {
        if ([dic[@"aid"] isEqualToString:@"A"]) {
            return answerDefaultA;
        }
        else if ([dic[@"aid"] isEqualToString:@"B"]) {
            return answerDefaultB;
        }
        else if ([dic[@"aid"] isEqualToString:@"C"]) {
            return answerDefaultC;
        }
        else {
            return answerDefaultD;
        }
    }
    else{
        /// 如果打错了
        if (![_dataSource[@"chooseanser"] isEqualToString:_dataSource[@"ranswer"]]) {
            /// 错误答案
            if ([dic[@"aid"] isEqualToString:_dataSource[@"chooseanser"]]) {
                return answerError;
            }
            /// 正确答案
            else if ([dic[@"aid"] isEqualToString:_dataSource[@"ranswer"]]){
                return answerRight;
            }
            /// 其他答案
            else{
                if ([dic[@"aid"] isEqualToString:@"A"]) {
                    return answerDefaultA;
                }
                else if ([dic[@"aid"] isEqualToString:@"B"]) {
                    return answerDefaultB;
                }
                else if ([dic[@"aid"] isEqualToString:@"C"]) {
                    return answerDefaultC;
                }
                else {
                    return answerDefaultD;
                }
            }
        }
        /// 如果答对了
        else{
            /// 正确答案
            if ([dic[@"aid"] isEqualToString:_dataSource[@"ranswer"]]){
                return answerRight;
            }
            /// 其他答案
            else{
                if ([dic[@"aid"] isEqualToString:@"A"]) {
                    return answerDefaultA;
                }
                else if ([dic[@"aid"] isEqualToString:@"B"]) {
                    return answerDefaultB;
                }
                else if ([dic[@"aid"] isEqualToString:@"C"]) {
                    return answerDefaultC;
                }
                else {
                    return answerDefaultD;
                }
            }
        }
    }
}
@end


