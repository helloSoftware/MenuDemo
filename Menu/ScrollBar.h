//
//  scrollBar.h
//  StarWardrobe
//
//  Created by pop on 14-8-10.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)(NSInteger index);

@interface ScrollBar : UIScrollView

@property(nonatomic,strong) UIButton *selectedBtn;

@property(nonatomic,strong) NSMutableArray *buttons;

@property(nonatomic,copy) btnClickBlock btnClickBlock;

/**
 *  一个一个添加 旧版本 已弃之不用
 */
- (void)addButtonWithTitle:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTitleColor;
/**
 *  一次添加 取代之前的一个一个添加方法
 */
- (void)addButtonWithTitles:(NSArray *)titles andSelectedTitleColor:(UIColor *)selectedTitleColor;

@end
