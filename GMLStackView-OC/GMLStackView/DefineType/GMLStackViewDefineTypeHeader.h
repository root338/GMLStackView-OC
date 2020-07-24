//
//  GMLStackViewDefineTypeHeader.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#ifndef GMLStackViewDefineTypeHeader_h
#define GMLStackViewDefineTypeHeader_h

typedef NS_ENUM(NSInteger, GMLBool) {
    GMLBoolFalse = -1,
    GMLBoolNull = 0,
    GMLBoolTrue = 1,
};
/// 排方向
typedef NS_ENUM(NSInteger, GMLAxisDirection) {
    /// 头到尾方式的排
    GMLAxisDirectionHead,
    /// 尾到头方式的排
    GMLAxisDirectionTail,
};
/// 对标 UILayoutConstraintAxis
typedef NS_ENUM(NSInteger, GMLAxis) {
    /// 水平排
    GMLAxisHorizontal = 0,
    /// 垂直排
    GMLAxisVertical = 1,
};
/// 对标 UIStackViewDistribution
typedef NS_ENUM(NSInteger, GMLStackViewDistribution) {
    /// 填充满
    GMLStackViewDistributionFill = 0,
    /// 长度相等填充满
    GMLStackViewDistributionFillEqually,
    /// 等比例填充满
    GMLStackViewDistributionFillProportionally,
    /// 等间距填充满
    GMLStackViewDistributionEqualSpacing,
    /// 等中心间距填充满
    GMLStackViewDistributionEqualCentering,
};
/// 对标 UIStackViewAlignment
typedef NS_ENUM(NSInteger, GMLStackViewAlignment) {
    /// 填充满
    GMLStackViewAlignmentFill,
    /// 头对齐
    GMLStackViewAlignmentLeading,
    GMLStackViewAlignmentTop = GMLStackViewAlignmentLeading,
    GMLStackViewAlignmentFirstBaseline,
    /// 中对齐
    GMLStackViewAlignmentCenter,
    /// 尾对齐
    GMLStackViewAlignmentTrailing,
    GMLStackViewAlignmentBottom = GMLStackViewAlignmentTrailing,
    GMLStackViewAlignmentLastBaseline,
};

#endif /* GMLStackViewDefineTypeHeader_h */
