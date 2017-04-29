//
//  Find_QuestionAnswerTableViewCell.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "Find_QuestionAnswerTableViewCell.h"

@implementation Find_QuestionAnswerTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"Find_QuestionAnswerTableViewCell" owner:nil options:nil][0];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code


}

-(void)setType:(answerType)type{
    _type = type;
    
    switch (_type) {
        case answerDefaultA:
            self.img.image = [UIImage imageNamed:@"zimu_a.png"];
            self.title.textColor = UIColorFromRGBHex(0x151515);
            break;
        case answerDefaultB:
            self.img.image = [UIImage imageNamed:@"zimu_b.png"];
            self.title.textColor = UIColorFromRGBHex(0x151515);
            break;
        case answerDefaultC:
            self.img.image = [UIImage imageNamed:@"zimu_c.png"];
            self.title.textColor = UIColorFromRGBHex(0x151515);
            break;
        case answerDefaultD:
            self.img.image = [UIImage imageNamed:@"zimu_d.png"];
            self.title.textColor = UIColorFromRGBHex(0x151515);
            break;
        case answerRightA:
            self.img.image = [UIImage imageNamed:@"zimu_lva.png"];
            self.title.textColor = UIColorFromRGBHex(0x009944);
            break;
        case answerRightB:
            self.img.image = [UIImage imageNamed:@"zimu_lvb.png"];
            self.title.textColor = UIColorFromRGBHex(0x009944);
            break;
        case answerRightC:
            self.img.image = [UIImage imageNamed:@"zimu_lvc.png"];
            self.title.textColor = UIColorFromRGBHex(0x009944);
            break;
        case answerRightD:
            self.img.image = [UIImage imageNamed:@"zimu_lvd.png"];
            self.title.textColor = UIColorFromRGBHex(0x009944);
            break;
        case answerRight:
            self.img.image = [UIImage imageNamed:@"dadui.png"];
            self.title.textColor = UIColorFromRGBHex(0x009944);
            break;
        case answerError:
            self.img.image = [UIImage imageNamed:@"dacuo.png"];
            self.title.textColor = UIColorFromRGBHex(0xf15353);
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
