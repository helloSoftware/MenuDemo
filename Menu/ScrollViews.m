//
//  ScrollViews.m
//  StarWardrobe
//
//  Created by pop on 14-8-10.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#import "ScrollViews.h"

@interface ScrollViews ()<UIScrollViewDelegate>

@end

@implementation ScrollViews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.bounces = NO;
        self.pagingEnabled = YES;
    }
    return self;
}

//- (void)setViews:(NSMutableArray *)views{
//
//    _views = views;
//    for (UIViewController *vc in self.viewControllers) {
//        [_views addObject:vc.view];
//    }
//}

- (NSMutableArray *)views{

    _views = [NSMutableArray array];
    for (UIViewController *vc in self.viewControllers) {
        [_views addObject:vc.view];
    }
    
    return _views;
}



- (void)layoutSubviews{

    int count = (int)self.views.count;
    
    for (int i = 0; i < self.views.count; i++) {
        
        UIView *view = self.views[i];
        view.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:view];
        
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width * count, self.frame.size.height);

}

- (void)setScrollBar:(ScrollBar *)scrollBar{

    _scrollBar = scrollBar;
    __weak typeof(self) cls = self;
    
    _scrollBar.btnClickBlock = ^(NSInteger index){
    
        cls.contentOffset = CGPointMake(index * cls.frame.size.width, cls.frame.origin.y);
        NSLog(@"aaaaa%@",NSStringFromCGPoint(cls.contentOffset));
    };
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    NSLog(@"aaaaaa %d",index);
    
//    //用于回调
//    if (self.endDeceleratingBlock) {
//        self.endDeceleratingBlock(index);
//    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
 
    if ([self.scrollBar respondsToSelector:@selector(btnClick:)]) {
        [self.scrollBar performSelector:@selector(btnClick:) withObject:self.scrollBar.buttons[index]];
    }
#pragma clang diagnostic pop
//    self.scrollBar.selectedBtn.selected = NO;
//    self.scrollBar.selectedBtn = self.scrollBar.buttons[index];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
