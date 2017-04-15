//
//  QuestionItemView.m
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import "QuestionItemView.h"

@implementation QuestionItemView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    [self setUI];
}

-(void)setUI{
    
    self.backgroundColor = [UIColor orangeColor];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(50, 50);
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.itemCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(1, 2, self.frame.size.width-2, self.frame.size.height-1) collectionViewLayout:self.flowLayout];
    self.itemCollectionView.backgroundColor = [UIColor whiteColor];
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;
    [self addSubview:_itemCollectionView];
    
    [self.itemCollectionView registerClass:[QuestionItemCell class] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //重用cell
    QuestionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * dic = _dataSource[indexPath.row];
    
    //赋值
    cell.label.text = [NSString stringWithFormat:@"%.f",[dic[@"qid"] floatValue] + 1];
    if ([dic[@"chooseanser" ] isEqualToString:@"0"]) {
        cell.type = typeDefault;
    }
    else if ([dic[@"chooseanser" ] isEqualToString:dic[@"ranswer"]]){
        cell.type = typeRight;
    }
    else{
        cell.type = typeErrow;
    }
    
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.clickItemBlock(indexPath.row);
}

@end


@implementation QuestionItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
    
}

-(void)setUI{
    
    self.frame = CGRectMake(0, 0, 50, 50);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    _label.textColor = [UIColor blackColor];
    _label.layer.borderWidth = .5;
    _label.layer.borderColor = [UIColor blackColor].CGColor;
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = 3;
    
    

}

-(void)setType:(typeState)type{
    _type =type;
    switch (self.type) {
        case typeDefault:
        {
            _label.textColor = [UIColor blackColor];
            _label.layer.borderColor = [UIColor blackColor].CGColor;
        }
            break;
        case typeErrow:
        {
            _label.textColor = [UIColor redColor];
            _label.layer.borderColor = [UIColor redColor].CGColor;
        }
            break;
        case typeRight:
        {
            _label.textColor = [UIColor greenColor];
            _label.layer.borderColor = [UIColor greenColor].CGColor;
        }
            break;
        default:
            break;
    }
}
@end
