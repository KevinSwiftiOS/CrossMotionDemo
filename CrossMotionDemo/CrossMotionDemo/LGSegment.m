//
//  LGSegment.m
//  CrossMotionDemo
//
//  Created by Kevin on 16/9/4.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "LGSegment.h"
//宏定义
#define LG_ScreenW [UIScreen mainScreen].bounds.size.width
#define LG_ScreenH [UIScreen mainScreen].bounds.size.height
#define LG_BannerColor [UIColor redColor]
#define LG_ButtonColor_Selected [UIColor redColor]
#define LG_ButtonColor_UnSelected [UIColor blackColor]

@implementation LGSegment
#pragma mark 初始化
-(id)init{
    if(self = [super init]){
        [self commitInit];
    }
    return self;
}
//三种不同的初始化方法 一种是从代码中进行初始化 一种是从sb中进行初始化
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self commitInit];
    }
return self;
}
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commitInit];
    }
    return self;
}
-(NSMutableArray *)buttonList{
    if(!_buttonList){
        _buttonList = [NSMutableArray new];
    }
    return _buttonList;
}
-(NSMutableArray *)titleList{
    if(!_titleList){
        _titleList = [NSMutableArray new];
    }
    return _titleList;
}
-(void)commitInit{
    //按钮名称
    NSMutableArray *titleList = [[NSMutableArray alloc]initWithObjects:@"全部",@"代发货",@"已发货", nil];
    _titleList = titleList;
    [self titleList];
    [self createItem:_titleList];
    [self buttonList];
    
}
+(instancetype)initWithTitleList:(NSMutableArray *)titleList{
    LGSegment *segment = [[LGSegment alloc]initWithTitleList:titleList];
    segment.titleList = titleList;
    return segment;
}
-(void)createItem:(NSMutableArray *)item{
    NSInteger count = self.titleList.count;
    CGFloat marginX = (self.frame.size.width - count * 60) / (count + 1);
    for(int i = 0; i < count;i++) {
        //按钮x坐标计算 i为列数
        NSString *temp = self.titleList[i];
        CGFloat buttonX = marginX + i * (60 + marginX);
        UIButton *buttonItem = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, 0, 60, self.frame.size.height)];
        //设置
        buttonItem.tag = i + 1;
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        [buttonItem setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        [_buttonList addObject:buttonItem];
        //第一个按钮默认是选中的
        if(i == 0){
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [self createBanner:firstX];
        }
        //左边和右边的
        buttonX += marginX;
    }
}
//设置边缘角
-(void)createBanner:(CGFloat)firstX{
    //初始化
    CALayer *LGLayer = [[CALayer alloc]init];
    LGLayer.backgroundColor = LG_BannerColor.CGColor;
    LGLayer.frame = CGRectMake(firstX, self.frame.size.height - 6, 60, 2);
    //设定frame和圆角处理
    LGLayer.cornerRadius = 4.0;
    [self.layer addSublayer:LGLayer];
    self.LGLayer = LGLayer;
}
-(void)buttonClick:(UIButton *)btn{
    //获取被点击的按钮后 设置背景颜色
    [btn setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self viewWithTag:1];
        UIButton *btn2 = (UIButton *)[self viewWithTag:2];
        UIButton *btn3 = (UIButton *)[self viewWithTag:3];
        UIButton *btn4 = (UIButton *)[self viewWithTag:4];
        CGFloat bannerX = btn.center.x;
    [self bannerMoveTo:bannerX];
    switch (btn.tag) {
        case 1:
            [self didSelectButton:btn1];
            [self.delegate scrollToPage:0];
            break;
        case 2:
            [self didSelectButton:btn2];
            [self.delegate scrollToPage:1];
            break;
        case 3:
            [self didSelectButton:btn3];
            [self.delegate scrollToPage:2];
            break;
        case 4:
            [self didSelectButton:btn4];
            [self.delegate scrollToPage:3];
            break;
        default:
            break;
    }
}
-(void)moveToOffsetX:(CGFloat)X{
     UIButton *btn1 = (UIButton *)[self viewWithTag:1];
     UIButton *btn2 = (UIButton *)[self viewWithTag:2];
     UIButton *btn3 = (UIButton *)[self viewWithTag:3];
     UIButton *btn4 = (UIButton *)[self viewWithTag:4];
    CGFloat bannerX = btn1.center.x;
    CGFloat offset = X;
    CGFloat addX = offset/LG_ScreenW * (btn2.center.x - btn1.center.x);
    bannerX += addX;
    [self bannerMoveTo:bannerX];
    if(bannerX == btn1.center.x){
        [self didSelectButton:btn1];
    }
    else if(bannerX == btn2.center.x){
        [self didSelectButton:btn2];
    }
    else if(bannerX == btn3.center.x){
        [self didSelectButton:btn3];
    }
    else{
        [self didSelectButton:btn4];
    }
    
}
-(void)bannerMoveTo:(CGFloat)bannerX{
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 100)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    animationGroup.delegate = self;
    //设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion = false;
    //设置保存动画的最新状态
    animationGroup.fillMode = kCAFillModeForwards;
    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
   //动画加入到changeLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}
//点击按钮后改变字体的按钮
-(void)didSelectButton:(UIButton *)btn{
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    UIButton *bt3 = (UIButton *)[self viewWithTag:3];
    UIButton *bt4 = (UIButton *)[self viewWithTag:4];
    UIButton *button = btn;
    switch (button.tag) {
        case 1:
            [bt1 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
        case 2:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
        case 3:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            break;
        case 4:
            [bt1 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt2 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt3 setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
            [bt4 setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

@end
