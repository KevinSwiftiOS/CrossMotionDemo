//
//  LGSegment.h
//  CrossMotionDemo
//
//  Created by hznucai on 2016/9/5.
//  Copyright © 2016年 hznucai. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SegmentDelegate<NSObject>
@optional
-(void)scrollToPage:(int)page;
@end
@interface LGSegment : UIView{
    id<SegmentDelegate>delegate;
}
@property(nonatomic,assign)CGFloat maxWidth;
@property(nonatomic,strong)NSMutableArray *titleList;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,weak)CALayer *LGLayer;
@property(nonatomic,assign)CGFloat bannerNowX;
+(instancetype)initWithTitleList:(NSMutableArray *)titleList;
-(id)initWithTitleList:(NSMutableArray *)titleList;
-(void)moveToOffsetX:(CGFloat)X;
@end

