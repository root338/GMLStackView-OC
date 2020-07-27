//
//  GMLStackLayoutHelper.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GMLStackViewProtocol;
@interface GMLStackLayoutHelper : NSObject

@property (nullable, nonatomic, weak) UIView<GMLStackViewProtocol> *stackView;

- (void)setContentLayoutWithSize:(CGSize)size;
- (CGSize)sizeThatFits:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
