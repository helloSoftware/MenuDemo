//
//  MenuViewController.h
//  StarWardrobe
//
//  Created by pop on 14-9-1.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollBar.h"

@interface MenuViewController : UIViewController

/**
 *  可控制自己跳转到哪一页的按钮条
 */
@property(nonatomic,strong) ScrollBar *scrollBar;
/**
 *  控制器
 */
@property(nonatomic,strong) NSArray *viewControllers;

@end
