//
//  GMLStackLayoutHelper+GMLPrivateAdd.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/27.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackLayoutHelper+GMLPrivateAdd.h"
#import "GMLGeometry.h"
#import "GMLStackViewProtocol.h"
#import "GMLStackSubviewAttributes.h"

@implementation GMLStackLayoutHelper (GMLPrivateAdd)

- (GMLStackSubviewLayoutCalculate)getCurrentStackSubviewLayoutCalculate {
    switch (self.stackView.axis) {
        case GMLAxisHorizontal:
            switch (self.stackView.distribution) {
                case GMLStackViewDistributionFill:
                    switch (self.stackView.alignment) {
                        case GMLStackViewAlignmentFill:
                            return [self horizontalFillAndFill];
                        case GMLStackViewAlignmentTop:
                            
                            break;
                        case GMLStackViewAlignmentFirstBaseline:
                            
                            break;
                        case GMLStackViewAlignmentCenter:
                            
                            break;
                        case GMLStackViewAlignmentBottom:
                            
                            break;
                        case GMLStackViewAlignmentLastBaseline:
                            
                            break;
                    }
                case GMLStackViewDistributionFillEqually:
                    
                    break;
                case GMLStackViewDistributionFillProportionally:
                    
                    break;
                case GMLStackViewDistributionEqualSpacing:
                    
                    break;
                case GMLStackViewDistributionEqualCentering:
                    
                    break;
            }
            
            break;
        case GMLAxisVertical:
            switch (self.stackView.distribution) {
                case GMLStackViewDistributionFill:
                    switch (self.stackView.alignment) {
                        case GMLStackViewAlignmentFill:
                            return [self verticalFillAndFill];
                        case GMLStackViewAlignmentTop:
                            
                            break;
                        case GMLStackViewAlignmentFirstBaseline:
                            
                            break;
                        case GMLStackViewAlignmentCenter:
                            
                            break;
                        case GMLStackViewAlignmentBottom:
                            
                            break;
                        case GMLStackViewAlignmentLastBaseline:
                            
                            break;
                    }
                    break;
                case GMLStackViewDistributionFillEqually:
                    
                    break;
                case GMLStackViewDistributionFillProportionally:
                    
                    break;
                case GMLStackViewDistributionEqualSpacing:
                    
                    break;
                case GMLStackViewDistributionEqualCentering:
                    
                    break;
            }
            break;
    }
    return nil;
}

#pragma mark - GMLAxisHorizontal -> GMLStackViewDistributionFill
- (GMLStackSubviewLayoutCalculate)horizontalFillAndFill {
    return ^(CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx) {
        UIEdgeInsets insets = obj.insets;
        CGRect frame = CGRectMake(CGRectGetMinX(availableRect) + insets.left, CGRectGetMinY(availableRect) + insets.top, obj.expectedSize.width, GMLVerticalValue(CGRectGetHeight(availableRect), insets));
        return frame;
    };
}
- (GMLStackSubviewLayoutCalculate)horizontalFillAndTop {
    return ^(CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx) {
        UIEdgeInsets insets = obj.insets;
        CGRect frame = CGRectMake(CGRectGetMinX(availableRect) + insets.left, CGRectGetMinY(availableRect) + insets.top, obj.expectedSize.width, obj.expectedSize.height);
        return frame;
    };
}
//- (GMLStackSubviewLayoutCalculate)horizontalFillAndFirstBaseline {
//
//}
//- (GMLStackSubviewLayoutCalculate)horizontalFillAndCenter {
//
//}
//- (GMLStackSubviewLayoutCalculate)horizontalFillAndBottom {
//
//}
//- (GMLStackSubviewLayoutCalculate)horizontalFillAndLastBaseline {
//
//}

- (GMLStackSubviewLayoutCalculate)verticalFillAndFill {
    return ^(CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx) {
        UIEdgeInsets insets = obj.insets;
        CGRect frame = CGRectMake(CGRectGetMinX(availableRect) + insets.left, CGRectGetMinY(availableRect) + insets.top, GMLHorizontalValue(CGRectGetWidth(availableRect), insets), obj.expectedSize.height);
        return frame;
    };
}

@end
