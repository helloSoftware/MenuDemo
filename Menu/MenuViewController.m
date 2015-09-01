//
//  MenuViewController.m
//  StarWardrobe
//
//  Created by pop on 14-9-1.
//  Copyright (c) 2014年 pop. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()< UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 *  真正实现分页的view
 */
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MenuViewController

- (void)viewDidLoad {

    
    [super viewDidLoad];
    
    NSLog(@"%tu", self.viewControllers.count);
    
    [self setupCollectionView];
}

- (void)setScrollBar:(ScrollBar *)scrollBar{

    _scrollBar = scrollBar;
    
    __weak typeof(self) cls = self;
    
    _scrollBar.btnClickBlock = ^(NSInteger index){
    
        [cls.collectionView setContentOffset:CGPointMake(index * cls.view.frame.size.width, cls.view.frame.origin.y) animated:YES];
    };
}

- (void)setupCollectionView{
    
        //frame
        CGRect frame = self.view.bounds;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        //item的size
        layout.itemSize = frame.size;
        
        //滑动方向 横向滑动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.bounces = NO;
        self.collectionView.pagingEnabled = YES;
    
        //注册
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

        [self.view addSubview:self.collectionView];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"self.viewControllers.count");

    return self.viewControllers.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIViewController *vc = self.viewControllers[indexPath.item];
    [self addChildViewController:vc];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self.scrollBar respondsToSelector:@selector(btnClick:)]) {
        [self.scrollBar performSelector:@selector(btnClick:) withObject:self.scrollBar.buttons[index]];
    }
#pragma clang diagnostic pop
 
}

@end
