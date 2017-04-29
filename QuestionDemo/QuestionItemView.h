//
//  QuestionItemView.h
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionItemView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property  UICollectionViewFlowLayout * flowLayout;
@property  UICollectionView * itemCollectionView;
@property  (nonatomic)NSArray * dataSource;

@property (nonatomic,copy) void(^clickItemBlock)(NSInteger item);

@end

typedef enum : NSUInteger {
    typeDefault = 0,
    typeErrow,
    typeRight,
    typeNode
} typeState;

@interface QuestionItemCell : UICollectionViewCell

@property (nonatomic)typeState type;


@property UILabel * label;

@end
