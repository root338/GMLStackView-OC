//
//  GMLStackLayoutProtocol.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMLStackLayoutProtocol <NSObject>

@property (nonatomic, copy, readonly) NSArray<__kindof UIView *> *arrangedSubviews;

@end

NS_ASSUME_NONNULL_END
