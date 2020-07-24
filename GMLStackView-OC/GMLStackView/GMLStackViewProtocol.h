//
//  GMLStackViewProtocol.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMLStackViewDefineTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GMLStackViewProtocol <NSObject>

@property(nonatomic, readonly, copy) NSArray<__kindof UIView *> *arrangedSubviews;
@property(nonatomic, readonly) UIEdgeInsets insets;
@property(nonatomic, readonly) CGFloat spacing;

@property(nonatomic) GMLAxis axis;
@property(nonatomic) GMLAxisDirection axisDirection;
@property(nonatomic) GMLStackViewDistribution distribution;
@property(nonatomic) GMLStackViewAlignment alignment;
/// 忽略隐藏的视图，设置为 YES 时，子视图的布局会忽略隐藏视图
@property(nonatomic, readonly) BOOL ignoreHiddenView;

- (CGFloat)customSpacingAfterView:(UIView *)arrangedSubview;
@end

NS_ASSUME_NONNULL_END
