//
//  Find_QuestionADTableViewCell.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "Find_QuestionADTableViewCell.h"

@implementation Find_QuestionADTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"Find_QuestionADTableViewCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
