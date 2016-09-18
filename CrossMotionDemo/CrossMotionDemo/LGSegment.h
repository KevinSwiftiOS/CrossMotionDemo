//
//  LGSegment.h
//  CrossMotionDemo
//
//  Created by Kevin on 16/9/4.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SegmentDelegate<NSObject>
@optional
-(void)scrollToPage:(int)page;
@end
@interface LGSegment:UIView{
    
    id<SegmentDelegate>delegate;
}
@property(nonatomic,weak)id<SegmentDelegate>delegate;
@property(nonatomic,assign)CGFloat maxWidth;
@property(nonatomic,strong)NSMutableArray *titleList;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,weak)CALayer *LGLayer;
@property(nonatomic,assign)CGFloat bannerNowX;
//初始化的方法
+(instancetype)initWithTitleList:(NSMutableArray *)titleList;
-(id)initWithTitleList:(NSMutableArray *)titleList;
-(void)moveToOffsetX:(CGFloat)X;

@end
