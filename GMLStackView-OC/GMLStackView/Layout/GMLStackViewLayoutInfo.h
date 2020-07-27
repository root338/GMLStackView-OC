//
//  GMLStackViewLayoutInfo.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMLStackViewDefineTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class GMLStackSubviewAttributes;

@interface GMLStackViewLayoutInfo : NSObject<NSCopying>
/// 计算后的内容大小
@property (nonatomic, assign) CGSize contentSize;
/// 间距总长
@property (nonatomic, assign) CGFloat totalSpacing;
/// 最大宽度，垂直排列时有效
@property (nonatomic, assign) CGFloat maxWidth;
/// 最大高度，水平排列时有效
@property (nonatomic, assign) CGFloat maxHeight;

@property(nullable, nonatomic, copy) NSArray<UIView *> *arrangedSubviews;
@property(nonatomic) UIEdgeInsets insets;
@property(nonatomic) CGFloat spacing;

@property(nonatomic) GMLAxis axis;
@property(nonatomic) GMLStackViewDistribution distribution;
@property(nonatomic) GMLStackViewAlignment alignment;
/// 忽略隐藏的视图，设置为 YES 时，子视图的布局会忽略隐藏视图
@property(nonatomic, readonly) BOOL ignoreHiddenView;

@property (nullable, nonatomic, copy) NSArray<GMLStackSubviewAttributes *> *subviewAttributes;


@end

NS_ASSUME_NONNULL_END
