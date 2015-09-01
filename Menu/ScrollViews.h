//
//  ScrollViews.h
//  StarWardrobe
//
//  Created by pop on 14-8-10.
//  Copyright (c) 2014年 pop. All rights reserved.
//

/**
 *  旧方法 已弃之不用 因为虽然scrollView复用了 但是并不是真正意义上的复用 view已经创建成功了 所以这里的复用相对无用 但是 当广告滚动的时候可以借鉴
 */
#import <UIKit/UIKit.h>
#import "ScrollBar.h"

typedef void(^scrollEndDeceleratingBlock)(NSInteger index);

@interface ScrollViews : UIScrollView

@property(nonatomic,strong) NSMutableArray *views;

@property(nonatomic,weak) ScrollBar *scrollBar;

//@property(nonatomic,copy) scrollEndDeceleratingBlock endDeceleratingBlock;


@property(nonatomic,strong) NSArray *viewControllers;

@end
