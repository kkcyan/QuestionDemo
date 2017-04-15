//
//  ViewController.h
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/4/14.
//  Copyright © 2017年 范玉杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface ViewController : UIViewController
<iCarouselDelegate,iCarouselDataSource>
{
    iCarousel * carousel;
}

@end

