//
//  ViewController.m
//  CrossMotionDemo
//
//  Created by Kevin on 16/9/4.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "ViewController.h"
#import "TotalViewController.h"
#import "paymentsViewController.h"
#import "DispatchViewController.h"
#import "ConnisignViewController.h"
#import "LGSegment.h"
#pragma mark 宏定义
#define LG_SCREENH [UIScreen mainScreen].bounds.size.height
#define LG_SCREENW [UIScreen mainScreen].bounds.size.width
//scrollView的高度
#define LG_SrollViewH 220
//segment的高度
#define LG_SegmentH 40

@interface ViewController ()<UIScrollViewDelegate,SegmentDelegate>
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,strong)LGSegment *segment;
@property(nonatomic,weak)CALayer *LGLayer;
@end

@implementation ViewController
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _buttonList = [NSMutableArray new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self segment];
    [self setContentView];
    [self addChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载头部的视图
-(void)setSegment{
    //进行初始化
    LGSegment *segment = [[LGSegment alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    segment.delegate = self;
    [self.view addSubview:segment];
    [self.buttonList addObject:segment.buttonList];
    self.LGLayer = segment.LGLayer;
}
//加载scrollView的颜色
-(void)setContentView{
    //上部的segment的高度为50 因此要空出一部分的距离
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, LG_SCREENH)];
    [self.view addSubview:sv];
    sv.bounces = false;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = true;
    sv.userInteractionEnabled = true;
    sv.showsHorizontalScrollIndicator = false;
    sv.delegate = self;
    for(int i = 0; i < self.childViewControllers.count;i++){
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * LG_SCREENW, 0, self.view.frame.size.width, LG_SCREENH);
        [sv addSubview:vc.view];
    }
    sv.contentSize = CGSizeMake(LG_SCREENW * 4, 0);
    _contentView = sv;
}
//加载三个ViewController
-(void)addChildViewController{
    TotalViewController *vc1 = [TotalViewController new];
    paymentsViewController *vc2 = [paymentsViewController new];
    ConnisignViewController *vc3 = [ConnisignViewController new];
    DispatchViewController *vc4 = [DispatchViewController new];
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    [self addChildViewController:vc4];
    
}
#pragma mark uiscrollViewDelegate 
-(void)scrollToPage:(int)page{
 //通过scrollView的滚动得到来获得他的pageContent
    CGPoint offset = _contentView.contentOffset;
    offset.x = self.view.frame.size.width * page;
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.contentOffset = offset;
    }];
}
//只要调用scrollView就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    [_segment moveToOffsetX:offsetX];
    
}
@end
