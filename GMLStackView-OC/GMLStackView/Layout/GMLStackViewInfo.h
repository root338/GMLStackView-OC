//
//  GMLStackViewInfo.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GMLStackViewProtocol;
@interface GMLStackViewInfo : NSObject

@property (nullable, nonatomic, weak) UIView<GMLStackViewProtocol> *stackView;

@property (nonatomic, strong) NSNumber *fixedWidth;
@property (nonatomic, strong) NSNumber *fixedHeight;


@end

NS_ASSUME_NONNULL_END
