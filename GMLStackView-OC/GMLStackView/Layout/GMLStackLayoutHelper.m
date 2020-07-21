//
//  GMLStackLayoutHelper.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackLayoutHelper.h"
#import "GMLStackViewProtocol.h"
#import "GMLStackSubviewAttributes.h"

@interface GMLStackLayoutHelper ()

@property (nonatomic, assign) BOOL isSetLayout;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) NSArray<UIView *> *arrangedSubviews;

@property (nonatomic, strong) NSMutableDictionary<NSString *, GMLStackSubviewAttributes *> *currentViewAttributesDict;
@end

@implementation GMLStackLayoutHelper

#pragma mark - Public
- (void)updateLayoutWithSize:(CGSize)size {
    self.size = size;
    switch (self.stackView.axis) {
        case UILayoutConstraintAxisHorizontal:
            
            break;
        case UILayoutConstraintAxisVertical:
            
            break;
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    self.size = size;
    
}

#pragma mark - Private
//- (CGSize)_stackViewFixedSize {
//    BOOL flagWidth = NO;
//    BOOL flagHeight = NO;
//
//    [self.stackView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.firstAttribute == NSLayoutAttributeWidth) {
//            <#statements#>
//        }
//    }];
//    if () {
//        <#statements#>
//    }
//}

- (void)_handleSubviewsLayout {
    [self _clear];
    [_arrangedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GMLStackSubviewAttributes *attributes = [self _currentAttributesAtView:obj];
        if (!attributes.needUpdateExpectedSize) {
            return;
        }
        attributes.expectedSize = [obj sizeThatFits:self.size];
        attributes.insets = UIEdgeInsetsMake(0, 0, 0, [self.stackView customSpacingAfterView:obj]);
    }];
}

- (void)_clear {
    
}



- (NSMutableArray *)_updateHorizontalLayout {
    
    
    
//    switch (self.stackView.distribution) {
//        case UIStackViewDistributionFill:
//            <#code#>
//            break;
//        case UIStackViewDistributionFillEqually:
//            <#code#>
//            break;
//        case UIStackViewDistributionFillProportionally:
//            <#code#>
//            break;
//        case UIStackViewDistributionEqualSpacing:
//            <#code#>
//            break;
//        case UIStackViewDistributionEqualCentering:
//            <#code#>
//            break;
//    }
}



- (GMLStackSubviewAttributes *)_currentAttributesAtView:(UIView *)view {
    NSString *key = [NSString stringWithFormat:@"%p", view];
    GMLStackSubviewAttributes *attributes = _currentViewAttributesDict[key];
    if (attributes == nil) {
        attributes = GMLStackSubviewAttributes.new;
        self.currentViewAttributesDict[key] = attributes;
    }
    return attributes;
}

#pragma mark - Getter & Setter
- (NSArray<UIView *> *)arrangedSubviews {
    if (_arrangedSubviews == nil) {
        _arrangedSubviews = self.stackView.arrangedSubviews;
    }
    return _arrangedSubviews;
}

- (NSMutableDictionary<NSString *,GMLStackSubviewAttributes *> *)currentViewAttributesDict {
    if (_currentViewAttributesDict == nil) {
        _currentViewAttributesDict = NSMutableDictionary.dictionary;
    }
    return _currentViewAttributesDict;
}

@end
