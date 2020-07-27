//
//  GMLStackSubviewAttributes.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GMLStackSubviewAreaStatus) {
    GMLStackSubviewAreaStatusNotCalculated,
    GMLStackSubviewAreaStatusNormal,
    GMLStackSubviewAreaStatusOutArea,
};

@interface GMLStackSubviewAttributes : NSObject<NSCopying>
/// 视图超出可用范围
@property (nonatomic, assign) GMLStackSubviewAreaStatus areaStatus;

@property (nonatomic, assign) UIEdgeInsets insets;
/// 视图 frame
@property (nonatomic, assign) CGRect frame;
/// 计算的期望大小
@property (nonatomic, assign) CGSize expectedSize;
/// 需要更新期望大小
@property (nonatomic, assign) BOOL needUpdateExpectedSize;
/// 关联的视图
@property (nullable, nonatomic, weak) UIView *linkView;
@end

NS_ASSUME_NONNULL_END
