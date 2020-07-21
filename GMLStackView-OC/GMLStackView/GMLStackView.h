//
//  GMLStackView.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMLStackViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface GMLStackView<__covariant ObjectType: UIView *> : UIView

@property(nonatomic, readonly, copy) NSArray<__kindof ObjectType> *arrangedSubviews;

@property(nonatomic) UIEdgeInsets insets;
@property(nonatomic) CGFloat spacing;
@property(nonatomic) UILayoutConstraintAxis axis;
@property(nonatomic) UIStackViewDistribution distribution;
@property(nonatomic) UIStackViewAlignment alignment;
/// 忽略隐藏的视图，设置为 YES 时，子视图的布局会忽略隐藏视图
@property(nonatomic) BOOL ignoreHiddenView;

- (void)addArrangedSubview:(ObjectType)view;
- (void)removeArrangedSubview:(ObjectType)view;
- (void)insertArrangedSubview:(ObjectType)view atIndex:(NSUInteger)stackIndex;

- (void)setCustomSpacing:(CGFloat)spacing afterView:(UIView *)arrangedSubview;
- (CGFloat)customSpacingAfterView:(UIView *)arrangedSubview;

- (instancetype)initWithArrangedSubviews:(NSArray<__kindof ObjectType> *)views;

@end

NS_ASSUME_NONNULL_END
