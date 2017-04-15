//
//  ViewController.m
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define YJWeakType(type) __weak typeof(type) weak##type = type;

#import "ViewController.h"
#import "QuestionItemView.h"
#import "QuestionAnswerView.h"

@interface ViewController ()
@property QuestionItemView * item;
@property UILabel  * numLabel;

@property NSMutableArray * dataSource;
@property int  totalNum;
@property int  readNum;
@property int  rightNum;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = @[].mutableCopy;
    
    for (int i=0; i< 50; i++) {
        NSDictionary * dic = @{@"qid":[NSString stringWithFormat:@"%i",i],
                               @"qcontent":[NSString stringWithFormat:@"这只是测试的题目这只是测试的题目这只是测试的题目这只是测试的题目%i",i],
                               @"qchoose":@[@{@"aid":@"A",@"acontent":@"这只是测试答案A"},
                                            @{@"aid":@"B",@"acontent":@"这只是测试答案B"},
                                            @{@"aid":@"C",@"acontent":@"这只是测试答案C"},
                                            @{@"aid":@"D",@"acontent":@"这只是测试答案D"}],
                               @"ranswer":@"B",
                               @"chooseanser":@"0"};
        
        [_dataSource addObject:dic];
        
    }
    
    _totalNum = (int)_dataSource.count;
    _readNum = 0;
    _rightNum = 0;
    
    [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:@"question"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //背景色
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:192/255.0 blue:203/255.0 alpha:1.0];
    //动画效果
    carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-80)];
    carousel.delegate = self;
    carousel.dataSource = self;
    carousel.type = iCarouselTypeTimeMachine;
    carousel.pagingEnabled = YES;
    [self.view addSubview:carousel];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"列表" forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT-40, 60, 40);
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 40, 60, 40)];
    _numLabel.text = [NSString stringWithFormat:@"%i/%i/%i",_rightNum ,_readNum,_totalNum];
    [self.view addSubview:_numLabel];
}

#pragma -mark -iCarouselDelegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 50;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{

    QuestionAnswerView * av = (QuestionAnswerView *)view;
    
    if (av == nil) {
    
        av = [[QuestionAnswerView alloc]creatView];
        av.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-80);

    }
    
    
    __weak typeof(carousel) weakCarousel = carousel;
    av.num.text = [NSString stringWithFormat:@"%ld",(long)index+1];
    av.dic = self.dataSource[index];
    av.block = ^(NSDictionary *dic) {
        
        [self removeItem];
        
        [self.dataSource replaceObjectAtIndex:index withObject:dic];
        
        [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:@"question"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.readNum ++;
        if ([dic[@"chooseanser"] isEqualToString:dic[@"ranswer"]]) {
            NSLog(@"恭喜您 答对了 💐");
            self.rightNum ++;
        }
        else
            NSLog(@"很遗憾 打错了 😢");
        
        _numLabel.text = [NSString stringWithFormat:@"%i/%i/%i",_rightNum,_readNum,_totalNum];
        [weakCarousel reloadItemAtIndex:index animated:YES];
        [self performSelector:@selector(next) withObject:nil afterDelay:0.5];
    };
    
    return av;
}

-(void)next{
    [carousel scrollToItemAtIndex:carousel.currentItemIndex+1 animated:YES];
}
- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}
-(NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 200;
}
-(BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeItem];
}

-(void)clickBtn:(UIButton *)sender{
    _item = [[QuestionItemView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 200)];
    _item.dataSource = _dataSource;
    
    __weak typeof(carousel) weakCarousel = carousel;
    WS(weakSelf)
    _item.clickItemBlock = ^(NSInteger item) {
        [weakSelf removeItem];
        [weakCarousel scrollToItemAtIndex:item animated:NO];
    };
    [self.view addSubview:_item];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _item.frame = CGRectMake(0, SCREEN_HEIGHT - 200 , SCREEN_WIDTH, 200);
         
    }];
}
-(void)removeItem{
    [UIView animateWithDuration:0.3 animations:^{
        
        _item.frame = CGRectMake(0, SCREEN_HEIGHT  , SCREEN_WIDTH, 200);
        
    } completion:^(BOOL finished) {
        [_item removeFromSuperview];
    }];
}
@end

