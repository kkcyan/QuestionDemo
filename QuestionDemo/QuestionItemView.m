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
    
    self.userInteractionEnabled = YES;
    
    self.backgroundColor = UIColorFromRGBHex(0xffffff);
    
    UIView * lineV =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineV.backgroundColor = UIColorFromRGBHex(0xe5e5e5);
    [self addSubview:lineV];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(44, 44);
    self.flowLayout.minimumLineSpacing = 7.5;
    self.flowLayout.minimumInteritemSpacing = 7.5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
    
    self.itemCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10.5, 1, self.frame.size.width-21, self.frame.size.height-1) collectionViewLayout:self.flowLayout];
    self.itemCollectionView.backgroundColor = [UIColor whiteColor];
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;
    self.itemCollectionView.showsVerticalScrollIndicator = NO;
    self.itemCollectionView.showsHorizontalScrollIndicator = NO;
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
    
    if ([dic[@"isShouldAnswer" ] isEqualToString:@"0"]){
        cell.type = typeNode;
    }
    if ([dic[@"isShouldAnswer" ] isEqualToString:@"1"]){
        cell.type = typeDefault;
    }
    if ([dic[@"chooseanser" ] isEqualToString:dic[@"ranswer"]]){
        cell.type = typeRight;
    }
    if (![dic[@"chooseanser" ] isEqualToString:dic[@"ranswer"]] && ![dic[@"chooseanser" ] isEqualToString:@"0"]){
        cell.type = typeErrow;
    }
    
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.clickItemBlock(indexPath.item);
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
    
    self.frame = CGRectMake(0, 0, 44, 44);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    _label.textColor = [UIColor blackColor];
    _label.layer.borderWidth = .5;
    _label.layer.borderColor = [UIColor blackColor].CGColor;
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = 22;
    
    

}

-(void)setType:(typeState)type{
    _type =type;
    switch (self.type) {
        case typeDefault:
        {
            _label.textColor = UIColorFromRGBHex(0xa4a4a4);
            _label.layer.borderColor = UIColorFromRGBHex(0xa4a4a4).CGColor;
            _label.backgroundColor = UIColorFromRGBHex(0xffffff);
        }
            break;
        case typeErrow:
        {
            _label.textColor = UIColorFromRGBHex(0xf15353);
            _label.layer.borderColor = UIColorFromRGBHex(0xf15353).CGColor;
            _label.backgroundColor = UIColorFromRGBHex(0xffffff);
        }
            break;
        case typeRight:
        {
            _label.textColor = UIColorFromRGBHex(0x009944);
            _label.layer.borderColor = UIColorFromRGBHex(0x009944).CGColor;
            _label.backgroundColor = UIColorFromRGBHex(0xffffff);
        }
            break;
        case typeNode:
        {
            _label.textColor = UIColorFromRGBHex(0xffffff);
            _label.layer.borderColor = UIColorFromRGBHex(0xa4a4a4).CGColor;
            _label.backgroundColor = UIColorFromRGBHex(0xa4a4a4);
        }
            break;
        default:
            break;
    }
}
@end
