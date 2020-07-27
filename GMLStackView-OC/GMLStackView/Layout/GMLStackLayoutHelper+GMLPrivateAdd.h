//
//  GMLStackLayoutHelper+GMLPrivateAdd.h
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/27.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackLayoutHelper.h"

NS_ASSUME_NONNULL_BEGIN
@class GMLStackSubviewAttributes;

typedef CGRect (^GMLStackSubviewLayoutCalculate) (CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx);

@interface GMLStackLayoutHelper (GMLPrivateAdd)

- (GMLStackSubviewLayoutCalculate)getCurrentStackSubviewLayoutCalculate;

@end

NS_ASSUME_NONNULL_END
