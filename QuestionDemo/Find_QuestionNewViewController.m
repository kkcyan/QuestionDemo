//
//  Find_QuestionNewViewController.m
//  ZHXSHQUser
//
//  Created by 范玉杰 on 2017/4/27.
//  Copyright © 2017年 boran. All rights reserved.
//

#import "Find_QuestionNewViewController.h"
#import "Find_QuestionNewCollectionViewCell.h"

#import "Find_QuestionBottomNewView.h"
#import "QuestionItemView.h"

@interface Find_QuestionNewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property NSMutableArray * dataSource;
@property int  totalNum;
@property int  readNum;
@property int  rightNum;
@property int  wrongNum;
@property CGFloat beginOffsetX;
@property int  currentCell;
@property NSTimer * timer;

@property int  totalMin; /// 总时间
@property int  min;  /// 分钟
@property int  sen;  /// 秒

@property(nonatomic ,strong) UICollectionView * collectionV;
@property(nonatomic,strong) UICollectionViewFlowLayout * flowLayout;

@property(nonatomic,strong) UIView * bottom;
@property(nonatomic,strong) UIView * bottomWindow;

@property QuestionItemView * item;
@property Find_QuestionBottomNewView * nav;
@property UIView * wview;


@end

@implementation Find_QuestionNewViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.view.backgroundColor = UIColorFromRGBHex(0xf5f5f5);
//    self.title = @"趣闻答题";
    
    _dataSource = @[].mutableCopy;
    
    for (int i=0; i< 50; i++) {
        NSDictionary * dic = @{@"qid":[NSString stringWithFormat:@"%i",i],
                               @"qcontent":[NSString stringWithFormat:@"这只是测试的题目这只是测试的题目这只是测试的题目这只是测试的题目%i",i],
                               @"qchoose":@[@{@"aid":@"A",@"acontent":@"这只是测试答案A"},
                                            @{@"aid":@"B",@"acontent":@"这只是测试答案B"},
                                            @{@"aid":@"C",@"acontent":@"这只是测试答案C"},
                                            @{@"aid":@"D",@"acontent":@"这只是测试答案D这只是测试答案D这只是测试答案D这只是测试答案D这只是测试答案D这只是测试答案D"}],
                               @"ranswer":@"B",
                               @"chooseanser":@"0",
                               @"lasttime":@"65",
                               @"isShouldAnswer":i == 0 ? @"1" : @"0"};
        
        [_dataSource addObject:dic];
        
    }
    
    _totalNum = (int)_dataSource.count;
    _readNum = 0;
    _rightNum = 0;
    _wrongNum = 0;
    _beginOffsetX = 0.0;
    _currentCell = 0;
    
    NSDictionary * dic = _dataSource[0];
    _totalMin = [dic[@"lasttime"] intValue];
    
    [self creatTimer];
    
    [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:@"question"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [self loadCusNav];
    [self loadCusNavRightView];
    [self loadBodyView];
    
}

#pragma mark - load view

-(void)loadCusNav{
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    NSString * titleStr = [NSString stringWithFormat:@"倒计时：%02d:%02d",_min,_sen];
    
    NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    NSRange stringRange = NSMakeRange(0, 4); //该字符串的位置
    [noteString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:stringRange];
    [noteString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBHex(0x151515) range:stringRange];
    
    NSRange stringRange1 = NSMakeRange(4, 5); //该字符串的位置
    [noteString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:stringRange1];
    [noteString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBHex(0xf15353) range:stringRange1];
    
    titleLabel.attributedText = noteString;
    
    self.navigationItem.titleView = titleLabel;
}
-(void)loadCusNavRightView{
    ///右边消息
    UIButton *MsgBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    MsgBtn.frame=CGRectMake(0, 0, 22, 22);
    [MsgBtn setBackgroundImage:[UIImage imageNamed:@"datishuoming.png"] forState:UIControlStateNormal];
    [MsgBtn addTarget:self action:@selector(clickMsgBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *MsgBtnBar=[[UIBarButtonItem alloc]initWithCustomView:MsgBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    
    negativeSpacer.width = -3;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,MsgBtnBar, nil];

}
-(void)loadBodyView{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(51, 0, 0, 0);
    
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - 64 - 44 ) collectionViewLayout:_flowLayout];
    _collectionV.showsVerticalScrollIndicator = NO;
    _collectionV.showsHorizontalScrollIndicator = NO;
    _collectionV.bounces = NO;
    
    _collectionV.backgroundColor = UIColorFromRGBHex(0xf5f5f5);
    _collectionV.pagingEnabled = YES;
    
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
    [_collectionV registerClass:[Find_QuestionNewCollectionViewCell class] forCellWithReuseIdentifier:@"Find_QuestionNewCollectionViewCell"];
    [self.view addSubview:_collectionV];
    
    
    _bottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-44, SCREEN_WIDTH, 44)];
    _nav = [[Find_QuestionBottomNewView alloc]craetView];
    _nav.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    _nav.rightNum.text = [NSString stringWithFormat:@"%i",_rightNum];
    _nav.errrowNum.text = [NSString stringWithFormat:@"%i",_wrongNum];
    _nav.totalNum.text = [NSString stringWithFormat:@"%i/%i",_readNum,_totalNum];
    MJWeakSelf
    _nav.clickTapBlock = ^{
        [weakSelf chooseItem];
    };
    _nav.clickNextBlock = ^{
        
        /// 判断是否可以点击
        if (weakSelf.currentCell + 1 > weakSelf.readNum) {
            NSLog(@"该题目不能被答");
            [weakSelf showToastContent:@"您当前还有题目未完成作答，该题目不能够被作答"];
        }
        else{
            weakSelf.currentCell = weakSelf.currentCell + 1;
            [weakSelf.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentCell inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [weakSelf updateTimer];
        }
        
    };
    [_bottom addSubview:_nav];
    [self.view addSubview:_bottom];
}

#pragma mark - delegate && data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{MJWeakSelf
    Find_QuestionNewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Find_QuestionNewCollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[Find_QuestionNewCollectionViewCell alloc]init];
    }
    
    if (indexPath.row%2 == 0) {
        cell.type = adTypeLabel;
    }
    else
        cell.type = adTypeImg;
    
    cell.dataSource = _dataSource[indexPath.item];
    cell.clickAnswerBlcok = ^(NSDictionary *dic) {
        
        [weakSelf removeTimer];
        [weakSelf dealWithLocalData:dic index:indexPath.item];
        
    };
    
    return cell;
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.collectionV){
        if (scrollView.contentOffset.x - _beginOffsetX > 0) {
            
            NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dataSource[_currentCell]];
            if ([mdic[@"chooseanser"] isEqualToString:@"0"]) {
                ZXLog(@"请完成当前题目");
                self.collectionV.scrollEnabled = NO;
                [self performSelector:@selector(delay) withObject:nil afterDelay:1.0f];
            }
        }
        else if (scrollView.contentOffset.x - _beginOffsetX > 0){}
        else{
            if (_currentCell == _readNum) {
                NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dataSource[_currentCell]];
                
                if (![mdic[@"lasttime"] isEqualToString:@"-1"]) {
                    [mdic setValue:[NSString stringWithFormat:@"%i",_totalMin] forKey:@"lasttime"];
                    [self.dataSource replaceObjectAtIndex:_currentCell withObject:mdic];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:@"question"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
            }
        }
    } 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _beginOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    _currentCell = targetContentOffset->x/SCREEN_WIDTH;
    [self updateTimer];
}

#pragma mark - custom method

-(void)dealWithLocalData:(NSDictionary *)dic index:(NSInteger)index{
    
    [self.dataSource replaceObjectAtIndex:index withObject:dic];
    
    if (index + 1 == _totalNum) {
        ZXLog(@"题目已经打完了");
    }
    else{
        NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dataSource[index + 1]];
        [mdic setValue:@"1" forKey:@"isShouldAnswer"];
        [self.dataSource replaceObjectAtIndex:index + 1 withObject:mdic];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:@"question"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.collectionV reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    
    self.readNum ++;
    
    if ([dic[@"chooseanser"] isEqualToString:dic[@"ranswer"]]) {
        NSLog(@"恭喜您 答对了 💐");
        self.rightNum ++;
        [self performSelector:@selector(pushNext) withObject:nil afterDelay:1.0f];
    }
    else{
        NSLog(@"很遗憾 打错了 😢");
        self.wrongNum ++;
    }
    
    _nav.rightNum.text = [NSString stringWithFormat:@"%i",_rightNum];
    _nav.errrowNum.text = [NSString stringWithFormat:@"%i",_wrongNum];
    _nav.totalNum.text = [NSString stringWithFormat:@"%i/%i",_readNum,_totalNum];
}
-(void)pushNext{
    if (_readNum == _totalNum) {
        return;
    }
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_readNum inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _currentCell = _readNum;
    [self updateTimer];
}
-(void)delay{
    self.collectionV.scrollEnabled = YES;
}
-(void)dealTimerTime{
    if (_totalMin == 0) {
        ZXLog(@"时间已经使用完！");
        if (_item) {
            [self removeItem];
        }
        
        NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:_dataSource[_currentCell]];
        
        [mdic setValue:@"X" forKey:@"chooseanser"];
        [mdic setObject:@"-1" forKey:@"lasttime"];
        
        [self dealWithLocalData:mdic index:_currentCell];
        
        [self removeTimer];
        return;
    }
    _totalMin --;
    _min = _totalMin / 60;
    _sen = _totalMin % 60;
    [self loadCusNav];
}
-(void)creatTimer{
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(dealTimerTime)userInfo:nil repeats:YES];
    _timer = myTimer;
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}
-(void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}
-(void)updateTimer{
    if (_timer) {
        [self removeTimer];
    }
    NSDictionary * dic = _dataSource[_currentCell];
    if ([dic[@"lasttime"] isEqualToString:@"-1"]) {
        _min = 0; _sen = 0;
        [self loadCusNav];
        return;
    }
    _totalMin = [dic[@"lasttime"] intValue];
    [self creatTimer];
}

#pragma mark Toast

-(void)showToastContent:(NSString *)content{
    ToastView * item = [[ToastView alloc]initWithType:ToastLocationBottom content:content presentView:self.view delay:2.5 block:^{}];
    [item show];
}

#pragma mark - click method

-(void)clickMsgBtn:(UIButton *)sender{
    ZXLog(@"答题说明");
}

-(void)chooseItem{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    window.userInteractionEnabled = YES;
    _wview = [[UIView alloc]initWithFrame:window.bounds];
    _wview.userInteractionEnabled = YES;
    _wview.backgroundColor = [UIColorFromRGBHex(0x000000) colorWithAlphaComponent:0.0];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickWView)];
    [_wview addGestureRecognizer:tap];
    [window addSubview:_wview];
    
    _bottomWindow = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
    Find_QuestionBottomNewView * nav = [[Find_QuestionBottomNewView alloc]craetView];
    nav.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    nav.rightNum.text = [NSString stringWithFormat:@"%i",_rightNum];
    nav.errrowNum.text = [NSString stringWithFormat:@"%i",_wrongNum];
    nav.totalNum.text = [NSString stringWithFormat:@"%i/%i",_readNum,_totalNum];
    MJWeakSelf
    nav.clickTapBlock = ^{
        [weakSelf removeItem];
    };
    nav.clickNextBlock = ^{
        [weakSelf removeItem];
        
        /// 判断是否可以点击
        if (_currentCell+1 > _readNum) {
            NSLog(@"该题目不能被答");
        }
        else{
            _currentCell = _currentCell+1;
            [weakSelf.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentCell inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [weakSelf updateTimer];
        }
        
    };
    [_bottomWindow addSubview:nav];
    [self.view addSubview:_bottomWindow];
    
    _item = [[QuestionItemView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    _item.dataSource = _dataSource;
    
    _item.clickItemBlock = ^(NSInteger item) {
        //// 移除遮罩
        [weakSelf removeItem];
        
        if (_currentCell == _readNum) {
            NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:weakSelf.dataSource[weakSelf.currentCell]];
            
            if (![mdic[@"lasttime"] isEqualToString:@"-1"]) {
                [mdic setValue:[NSString stringWithFormat:@"%i",weakSelf.totalMin] forKey:@"lasttime"];
                [weakSelf.dataSource replaceObjectAtIndex:weakSelf.currentCell withObject:mdic];
                
                [[NSUserDefaults standardUserDefaults] setObject:weakSelf.dataSource forKey:@"question"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        }
        
        /// 判断是否可以点击
        if (item > _readNum) {
            NSLog(@"该题目不能被答");
        }
        else{
            _currentCell = (int)item;
            [weakSelf.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [weakSelf updateTimer];
        }
    };
    [self.view addSubview:_item];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _wview.backgroundColor = [UIColorFromRGBHex(0x000000) colorWithAlphaComponent:0.6];
        _wview.frame = CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - (SCREEN_HEIGHT * 0.6) - 44);
        _bottomWindow.frame = CGRectMake(0, SCREEN_HEIGHT - (SCREEN_HEIGHT * 0.6) - 64 - 44 , SCREEN_WIDTH, 44);
        _item.frame = CGRectMake(0, SCREEN_HEIGHT - (SCREEN_HEIGHT * 0.6) - 64, SCREEN_WIDTH, SCREEN_HEIGHT*0.6);
        
    }];
}

-(void)removeItem{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _wview.backgroundColor = [UIColorFromRGBHex(0x000000) colorWithAlphaComponent:0.0];
        _wview.frame = window.bounds;
        _bottomWindow.frame = CGRectMake(0, SCREEN_HEIGHT - 44 , SCREEN_WIDTH, 44);
        _item.frame = CGRectMake(0, SCREEN_HEIGHT  , SCREEN_WIDTH, SCREEN_HEIGHT*0.6);
        
    } completion:^(BOOL finished) {
        [_bottomWindow removeFromSuperview];
        [_item removeFromSuperview];
        [_wview removeFromSuperview];
    }];
}

-(void)clickWView{
    [self removeItem];
}
@end
