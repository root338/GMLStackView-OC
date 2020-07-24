//
//  GMLStackSubviewAttributes.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMLStackSubviewAttributes : NSObject

@property (nonatomic, assign) UIEdgeInsets insets;
/// 视图 frame
@property (nonatomic, assign) CGRect frame;
/// 视图占的总区域，frame + insets + 其它内部对外间距
@property (nonatomic, assign) CGRect occupiedArea;
/// 计算的期望大小
@property (nonatomic, assign) CGSize expectedSize;
/// 需要更新期望大小
@property (nonatomic, assign) BOOL needUpdateExpectedSize;
/// 关联的视图
@property (nullable, nonatomic, weak) UIView *linkView;
@end

NS_ASSUME_NONNULL_END
