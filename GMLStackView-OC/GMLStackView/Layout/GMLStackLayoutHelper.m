//
//  GMLStackLayoutHelper.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackLayoutHelper.h"
#import "GMLGeometry.h"
#import "GMLStackViewLayoutInfo.h"
#import "GMLStackViewProtocol.h"
#import "GMLStackSubviewAttributes.h"
#import "GMLStackLayoutHelper+GMLPrivateAdd.h"

@interface GMLStackLayoutHelper ()
/// 是否是在计算
@property (nonatomic, assign) BOOL isAreaCalculation;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) NSArray<UIView *> *arrangedSubviews;
@property (nonatomic, strong) NSArray<NSString *> *arrangedSubviewsMemoryAddress;

@property (nonatomic, strong) NSMutableDictionary<NSString *, GMLStackSubviewAttributes *> *currentViewAttributesDict;
@property (nonatomic, assign) GMLStackViewLayoutInfo *currentLayoutInfo;

@property (nonatomic, copy) GMLStackSubviewLayoutCalculate layoutCalculate;
/// 缓存的 stackView 布局信息
@property (nonatomic, strong) GMLStackViewLayoutInfo *cacheStackViewInfo;
@end

@implementation GMLStackLayoutHelper

#pragma mark - Public
- (void)setContentLayoutWithSize:(CGSize)size {
    self.size = size;
    _isAreaCalculation = NO;
    [self _handleSubviewsLayout];
}

- (CGSize)sizeThatFits:(CGSize)size {
    self.size = size;
    _isAreaCalculation = YES;
    [self _handleSubviewsLayout];
    return self.currentLayoutInfo.contentSize;
}

#pragma mark - Private

- (void)_handleSubviewsLayout {
    [self _autoClear];
    if (self.arrangedSubviews.count == 0) {
        return;
    }
    [self _calculateSubviewsYourselfArea];
    self.layoutCalculate = [self getCurrentStackSubviewLayoutCalculate];
    [self _calculateSubviewsInStackViewArea];
    if (!self.isAreaCalculation) {
        [self _enumerateViewsUsingBlock:^(GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop) {
            if (!CGRectEqualToRect(obj.linkView.frame, obj.frame)) {
                obj.linkView.frame = obj.frame;
            }
        }];
    }
}
/// 自动选择性清除
- (void)_autoClear {
    
    NSArray *arrangedSubviews = self.stackView.arrangedSubviews;
    if (_arrangedSubviews == nil || ![_arrangedSubviews isEqualToArray:arrangedSubviews]) {
        _arrangedSubviews = arrangedSubviews;
        _arrangedSubviewsMemoryAddress = nil;
    }
}

/// 清除所有数据
- (void)_clearAllData {
    _cacheStackViewInfo = nil;
    _layoutCalculate = nil;
    _currentLayoutInfo = nil;
    _currentViewAttributesDict = nil;
    _arrangedSubviewsMemoryAddress = nil;
    _arrangedSubviews = nil;
}

#pragma mark - 子视图布局属性计算同时获取整体布局基本信息
/// 计算子视图自身区域
- (void)_calculateSubviewsYourselfArea {
    id<GMLStackViewProtocol> stackView = self.stackView;
    CGFloat mSpacing = stackView.spacing;
    NSUInteger lastIndex = _arrangedSubviews.count - 1;
    GMLAxis axis = stackView.axis;
    GMLStackViewLayoutInfo *info = self.currentLayoutInfo;
    void (^setSubMaxArea) (CGSize, UIEdgeInsets) = ^(CGSize size, UIEdgeInsets inset) {
        switch (axis) {
            case GMLAxisHorizontal: {
                CGFloat maxHeight = GMLMaxVerticalValue(size.height, inset);
                if (info.maxHeight < maxHeight) {
                    info.maxHeight = maxHeight;
                }
                break;
            }
            case GMLAxisVertical: {
                CGFloat maxWidth = GMLMaxHorizontalValue(size.width, inset);
                if (info.maxWidth < maxWidth) {
                    info.maxWidth = maxWidth;
                }
                break;
            }
        }
    };
    [_arrangedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GMLStackSubviewAttributes *attributes = [self _currentAttributesAtIndex:idx];
        if (!attributes.needUpdateExpectedSize) {
            setSubMaxArea(attributes.expectedSize, attributes.insets);
            return;
        }
        attributes.linkView = obj;
        attributes.expectedSize = [obj sizeThatFits:self.size];
        UIEdgeInsets insets = UIEdgeInsetsZero;
        CGFloat spacing = (lastIndex == idx) ? 0 : ([stackView customSpacingAfterView:obj]?: mSpacing);
        switch (axis) {
            case GMLAxisHorizontal:
                insets.right = spacing;
                break;
            case GMLAxisVertical:
                insets.bottom = spacing;
                break;
        }
        attributes.insets = insets;
        info.totalSpacing += spacing;
        setSubMaxArea(attributes.expectedSize, attributes.insets);
    }];
}

#pragma mark - 子视图在父视图中的frame计算
/// 计算子视图在 stackView 中的区域
- (void)_calculateSubviewsInStackViewArea {
    self.currentLayoutInfo.contentSize = [self _handleViewAttributesFrameUsingBlock:^CGRect(CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop) {
        CGRect frame = self.layoutCalculate(availableRect, obj, idx);
        return frame;
    }];
}

#pragma mark - 一些其它私有辅助方法集
/// 获取 stackView 可用区域
- (CGRect)_stackViewAvailableRect {
    CGSize stackViewSize;
    if (_isAreaCalculation) {
        switch (_stackView.axis) {
            case GMLAxisHorizontal:
                stackViewSize = CGSizeMake(_size.width, MIN(_size.height, _currentLayoutInfo.maxHeight + GMLEdgeInsetsGetVertical(_stackView.insets)));
                break;
            case GMLAxisVertical:
                stackViewSize = CGSizeMake(MIN(_size.width, _currentLayoutInfo.maxWidth + GMLEdgeInsetsGetHorizontal(_stackView.insets)), _size.height);
                break;
        }
    }else {
        stackViewSize = _size;
    }
    CGRect availableRect = GMLSizeLessInset(stackViewSize, _stackView.insets);
    return availableRect;
}

/// 遍历视图属性设置每个视图的frame
/// 在该方法最后会自动处理超出可用区域的内容，且在超出可用区域后停止计算后续部分(在排列的轴上)
- (CGSize)_handleViewAttributesFrameUsingBlock:(CGRect (NS_NOESCAPE ^) (CGRect availableRect, GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop))block {
    if (!block) return CGSizeZero;
    GMLAxis axis = _stackView.axis;
    __block CGRect availableRect = [self _stackViewAvailableRect];
    /// 是否超出整个区域
    __block BOOL isOutAxisArea = NO;
    __block CGFloat contentWidth = 0;
    __block CGFloat contentHeight = 0;
    switch (axis) {
        case GMLAxisHorizontal:
            contentHeight = GMLMaxVerticalValue(CGRectGetHeight(availableRect), _stackView.insets);
            break;
        case GMLAxisVertical:
            contentWidth = GMLMaxHorizontalValue(CGRectGetWidth(availableRect), _stackView.insets);
            break;
    }
    [self _enumerateViewsUsingBlock:^(GMLStackSubviewAttributes *obj, NSUInteger idx, BOOL *stop) {
        GMLStackSubviewAreaStatus status = GMLStackSubviewAreaStatusNotCalculated;
        if (isOutAxisArea) {
            /// 超出排列区域，不计算后续 view 区域
            obj.areaStatus = status;
            return;
        }
        CGRect frame = block(availableRect, obj, idx, stop);
        /// 当前视图是否超出可视区域
        BOOL outOfAvailableArea = NO;
        if (CGRectContainsRect(availableRect, frame)) {
            obj.frame = frame;
            status = GMLStackSubviewAreaStatusNormal;
        }else {
            CGFloat viewX = CGRectGetMinX(frame);
            CGFloat viewY = CGRectGetMinY(frame);
            CGFloat maxX = CGRectGetMaxX(availableRect);
            CGFloat maxY = CGRectGetMaxY(availableRect);
            BOOL xOut = viewX >= maxX;
            BOOL yOut = viewY >= maxY;
            BOOL maxXOut = CGRectGetMaxX(frame) > maxX;
            BOOL maxYOut = CGRectGetMaxY(frame) > maxY;
            if (xOut) {
                frame.origin.x = maxX;
                frame.size.width = 0;
            }else if (maxXOut) {
                frame.size.width = CGRectGetWidth(availableRect);
            }
            if (yOut) {
                frame.origin.y = maxY;
                frame.size.height = 0;
            }else if (maxYOut) {
                frame.size.height = CGRectGetHeight(availableRect);
            }
            outOfAvailableArea = maxXOut || maxYOut;
            switch (axis) {
                case GMLAxisHorizontal:
                    isOutAxisArea = maxXOut;
                    break;
                case GMLAxisVertical:
                    isOutAxisArea = maxYOut;
                    break;
            }
            status = GMLStackSubviewAreaStatusOutArea;
        }
        obj.frame = frame;
        obj.areaStatus = status;
        switch (axis) {
            case GMLAxisHorizontal: {
                CGFloat x = CGRectGetMaxX(frame) + obj.insets.right;
                availableRect.size.width = CGRectGetMaxX(availableRect) - x;
                availableRect.origin.x = x;
                contentWidth = x;
                break;
            }
            case GMLAxisVertical: {
                CGFloat y = CGRectGetMaxY(frame) + obj.insets.bottom;
                availableRect.size.height = CGRectGetMaxY(availableRect) - y;
                availableRect.origin.y = y;
                contentHeight = y;
                break;
            }
        }
    }];
    return CGSizeMake(contentWidth, contentHeight);
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

#pragma mark - 获取布局属性信息的存储对象
/// 获取指定view的属性
- (GMLStackSubviewAttributes *)_currentAttributesAtIndex:(NSInteger)index {
    if (index >= self.arrangedSubviewsMemoryAddress.count || index < 0) {
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
- (void)setStackView:(UIView<GMLStackViewProtocol> *)stackView {
    if (_stackView == stackView) return;
    _stackView = stackView;
    [self _clearAllData];
}

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
