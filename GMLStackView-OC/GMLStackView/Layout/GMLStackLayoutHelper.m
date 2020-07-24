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

#import "GMLGeometry.h"

typedef struct {
    UIEdgeInsets marginInset;
    CGFloat totalSpacing;
    
} _YMStackLayoutInfo;

@interface GMLStackLayoutHelper ()

@property (nonatomic, assign) BOOL isSetLayout;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) NSArray<UIView *> *arrangedSubviews;
@property (nonatomic, strong) NSArray<NSString *> *arrangedSubviewsMemoryAddress;

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

//- (CGSize)sizeThatFits:(CGSize)size {
//    self.size = size;
//
//}

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
    
    
}

- (void)_clear {
    
}
/// 计算子视图自身区域
- (void)_calculateSubviewsYourselfArea {
    id<GMLStackViewProtocol> stackView = self.stackView;
    CGFloat mSpacing = stackView.spacing;
    NSUInteger lastIndex = _arrangedSubviews.count - 1;
    __block CGFloat totalSpace = 0;
    [_arrangedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GMLStackSubviewAttributes *attributes = [self _currentAttributesAtIndex:idx];
        if (!attributes.needUpdateExpectedSize) {
            return;
        }
        attributes.linkView = obj;
        attributes.expectedSize = [obj sizeThatFits:self.size];
        UIEdgeInsets insets = UIEdgeInsetsZero;
        CGFloat spacing = (lastIndex == idx) ? 0 : ([stackView customSpacingAfterView:obj]?: mSpacing);
        switch (stackView.axis) {
            case UILayoutConstraintAxisHorizontal:
                insets.right = spacing;
                break;
            case UILayoutConstraintAxisVertical:
                insets.bottom = spacing;
                break;
        }
        attributes.insets = insets;
        totalSpace += spacing;
    }];
}
/// 计算子视图在 stackView 中的区域
- (void)_calculateSubviewsInStackViewArea {
    switch (self.stackView.distribution) {
        case GMLStackViewDistributionFill:
            <#code#>
            break;
        case GMLStackViewDistributionFillEqually:
            <#code#>
            break;
        case GMLStackViewDistributionFillProportionally:
            <#code#>
            break;
        case GMLStackViewDistributionEqualSpacing:
            <#code#>
            break;
        case GMLStackViewDistributionEqualCentering:
            <#code#>
            break;
    }
}
- (void)_calculateSubviewsInStackViewAreaFill {
    id<GMLStackViewProtocol> stackView = self.stackView;
    __block CGRect availableRect = GMLSizeLessInset(_size, stackView.insets);
    [self _enumerateViewsUsingBlock:^(GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop) {
        
    }];
}

/// 遍历所有布局视图
/// 增加该方法为了增加视图布局优先级时可以进行再处理
- (void)_enumerateViewsUsingBlock:(void (NS_NOESCAPE ^)(GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop))block {
    if (!block) return;
    BOOL stop = NO;
    for (NSInteger i = 0; i < _arrangedSubviewsMemoryAddress.count; i++) {
        block([self _currentAttributesAtIndex:i], i, &stop);
        if (stop) { break; }
    }
}

/// 获取指定view的属性
- (GMLStackSubviewAttributes *)_currentAttributesAtIndex:(NSInteger)index {
    if (index >= _arrangedSubviewsMemoryAddress.count || index < 0) {
        return nil;
    }
    NSString *key = _arrangedSubviewsMemoryAddress[index];
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

- (NSArray<NSString *> *)arrangedSubviewsMemoryAddress {
    if (_arrangedSubviewsMemoryAddress == nil) {
        NSMutableArray *arr = NSMutableArray.array;
        [self.arrangedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = [NSString stringWithFormat:@"%p", obj];
            [arr addObject:key];
        }];
        _arrangedSubviewsMemoryAddress = [arr copy];
    }
    return _arrangedSubviewsMemoryAddress;
}

@end
