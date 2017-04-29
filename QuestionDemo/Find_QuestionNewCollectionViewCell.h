//
//  Find_QuestionNewCollectionViewCell.h
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/28.
//  Copyright © 2017年 boran. All rights reserved.
//

typedef enum : NSUInteger {
    adTypeDefault = 0,
    adTypeImg,
    adTypeLabel,
} adType;

#import <UIKit/UIKit.h>

@interface Find_QuestionNewCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * bodyView;

@property (nonatomic,assign) adType  type;

@property (nonatomic,strong)  NSMutableDictionary * dataSource;
@property (nonatomic,strong)  NSMutableArray * answerArray;

@property (nonatomic,copy) void(^clickAnswerBlcok)(NSDictionary *dic);

@end


