//
//  scrollBar.m
//  StarWardrobe
//
//  Created by pop on 14-8-10.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#define WIDTH 65

#import "ScrollBar.h"

@interface ScrollBar ()

@property(nonatomic,strong) UIColor *selectedColor;

@property(nonatomic,strong) NSMutableArray *views;

@end

@implementation ScrollBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [NSMutableArray array];
        _views = [NSMutableArray array];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTitleColor{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.highlighted = NO;
    btn.tintColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    
    self.selectedColor = selectedTitleColor;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    [self.buttons addObject:btn];
    
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    [self.views addObject:view];
    
    if (!self.selectedBtn) {
        self.selectedBtn = btn;
    }
}

- (void)addButtonWithTitles:(NSArray *)titles andSelectedTitleColor:(UIColor *)selectedTitleColor{

    for (int i = 0; i < titles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.highlighted = NO;
        btn.tintColor = [UIColor clearColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
        
        self.selectedColor = selectedTitleColor;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        [self.buttons addObject:btn];
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [self.views addObject:view];
        
        if (!self.selectedBtn) {
            self.selectedBtn = btn;
        }
    }
  
}


#pragma mark setter方法

- (void)setSelectedBtn:(UIButton *)selectedBtn{

    UIView *view = self.views[self.selectedBtn.tag];
    view.backgroundColor = [UIColor clearColor];
    
    _selectedBtn = selectedBtn;
    selectedBtn.selected = YES;
    
    
    UIView *viewSelected = self.views[selectedBtn.tag];
    viewSelected.backgroundColor = self.selectedColor;
}

- (void)layoutSubviews{
    
    int count = (int)self.buttons.count;
    
    CGFloat width = self.frame.size.width / count;
    CGFloat height = self.frame.size.height;
    CGFloat y = 0;
    
    
    //当宽度大于等于75时 宽度是变化的
    if (width > WIDTH) {
        
        for (int i = 0; i < count; i++) {
            
            UIButton * button = self.buttons[i];
            //frame设置
            width = self.bounds.size.width / count;
            CGFloat x = i * width;
            button.tag = i;
            button.frame = CGRectMake(x, y, width, height);
            
            UIView *view = self.views[i];
            view.frame = CGRectMake(x, height - 2, width, 2);
        }
        
    }
    else{ //当计算宽度小于75时 宽度固定为75
        
        for (int i = 0; i < count; i++) {
            
            UIButton * button = self.buttons[i];
            //frame设置
            CGFloat x = i * WIDTH;
            button.tag = i;
            button.frame = CGRectMake(x, y, WIDTH, height);
            
            UIView *view = self.views[i];
            view.frame = CGRectMake(x, height - 2, WIDTH, 2);
        }
        //设置contentSize
        self.contentSize=CGSizeMake(count * WIDTH, self.bounds.size.height);
    }
    
}

- (void)btnClick:(UIButton *)btn{

    NSLog(@"btnClick");
    
    //btn的起始点
    CGFloat btnOriginX = btn.frame.origin.x;
    //scrollView的宽度
    CGFloat scrollWidth = self.frame.size.width;
    //scrollView的ContentView的宽度
    CGFloat scrollContentSizeWidth = self.contentSize.width;
    
    
    CGFloat x = self.contentOffset.x;
    
    //当滚动视图的滚动范围大于本身frame的时候
    if (scrollContentSizeWidth > scrollWidth) {
        //使选中的btn处于正中间 且到头和尾部时 scrollView.contentOffset 不再改变
        
        if (btnOriginX > scrollWidth / 2 ) {
            //往后点
            if (btn.tag > self.selectedBtn.tag) {
                
                if (scrollContentSizeWidth - x > scrollWidth) {
                    
                    x = btnOriginX - scrollWidth / 2;
                    
                    if (scrollContentSizeWidth - x < scrollWidth) {
                        
                        x = scrollContentSizeWidth - scrollWidth;
                        
                    }
                    self.contentOffset = CGPointMake(x, 0);
                }
            }else{
                //往前点
                self.contentOffset = CGPointMake(btnOriginX - scrollWidth / 2, 0);
            }
            
        }else if(btnOriginX <= scrollWidth / 2){
            
            self.contentOffset = CGPointMake(0, 0);
            
        }
        
    }

    //btn点击的回调
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag);
    }
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
}

@end
