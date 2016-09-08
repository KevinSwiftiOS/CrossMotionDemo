//
//  LGSegment.m
//  CrossMotionDemo
//
//  Created by hznucai on 2016/9/5.
//  Copyright © 2016年 hznucai. All rights reserved.
//

#import "LGSegment.h"
#define LG_ScreenW [UIScreen mainScreen].bounds.size.width
#define LG_ScreenH [UIScreen mainScreen].bounds.size.height
#define LG_BannerColor [UIColor redColor]
#define LG_ButtonColor_Selected [UIColor redColor]
#define LG_ButtonColor_UnSelected [UIColor blackColor]
@implementation LGSegment
#pragma 初始化
-(id)init{
    if(self = [super init]){
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame: frame]){
        [self commonInit];
        
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
//初始化
-(void)commonInit{
    NSMutableArray *titleList = [[NSMutableArray alloc]initWithObjects:@"热点",@"视频",@"体育",nil];
    _titleList = titleList;
    [self createItem:_titleList];
    [self buttonList];
    
}
+(instancetype)initWithTitleList:(NSMutableArray *)titleList{
    LGSegment *segment = [[LGSegment alloc]initWithTitleList:titleList];
    segment.titleList = titleList;
    return segment;
}
-(void)createItem:(NSMutableArray *)item{
    NSInteger count = _titleList.count;
    CGFloat marginX = (self.frame.size.width - count * 60) / (count + 1);
    for(int i = 0; i < count;i++){
        NSString *temp = _titleList[i];
        //按钮的X坐标进行计算 i为列数
        CGFloat buttonX = marginX + i * (60 + marginX);
        UIButton *buttonItem = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, 0, 60, self.frame.size.height)];
        //进行设置
        buttonItem.tag = i + 1;
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        [buttonItem setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        //第一个是默认被选中的按钮
        if(i == 0){
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [self createBanner:firstX];
        }
        buttonX += marginX;
    }
}
-(void)createBanner:(CGFloat)firstX{
    //初始化
    CALayer *LGLayer = [[CALayer alloc]init];
    LGLayer.backgroundColor = [LG_BannerColor CGColor];
    LGLayer.frame = CGRectMake(firstX, self.frame.size.height - 6, 60, 2);
    //圆角的处理
    LGLayer.cornerRadius = 4;
    //增加到UIView的layer上面去
    [self.layer addSublayer:LGLayer];
    _LGLayer = LGLayer;
}
-(void)buttonClick:(UIButton *)button{
    [button setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
    UIButton *btn1 = (UIButton *)[self viewWithTag:1];
    UIButton *btn2 = (UIButton *)[self viewWithTag:2];
    UIButton *btn3 = (UIButton *)[self viewWithTag:3];
    UIButton *btn4 = (UIButton *)[self viewWithTag:4];
    CGFloat bannerX = button.center.x;
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
