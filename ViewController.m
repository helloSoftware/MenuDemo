//
//  ViewController.m
//  MenuDemo
//
//  Created by pop on 14-9-1.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "ScrollBar.h"

@interface ViewController ()
{
    //使持有此controller 否则一创建就会释放
    MenuViewController *_menu;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ScrollBar *scrollBar = [[ScrollBar alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width - 60, 50)];
    [scrollBar addButtonWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] andSelectedTitleColor:[UIColor redColor]];
    scrollBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollBar];
    
    
    NSMutableArray *muarr = [NSMutableArray array];
    for (int i = 1; i <= 7; i++) {
        Class cls = NSClassFromString([NSString stringWithFormat:@"Test%dViewController",i]);
        UIViewController *vc = [[cls alloc]init];
        [muarr addObject:vc];
    }
    
    _menu = [[MenuViewController alloc] init];
    _menu.viewControllers = muarr;

    //如果不需要可以不添加此属性
    _menu.scrollBar = scrollBar;
    //😄frame一定要设
    _menu.view.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50);
    [self.view addSubview:_menu.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
