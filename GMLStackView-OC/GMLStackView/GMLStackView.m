//
//  GMLStackView.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackView.h"

@interface GMLStackView ()

@property (nonatomic, strong) NSMutableArray<UIView *> *mArrangedSubviews;

@end

@implementation GMLStackView

- (instancetype)initWithArrangedSubviews:(NSArray *)views {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _mArrangedSubviews = [NSMutableArray arrayWithArray:views?:@[]];
    }
    return self;
}

- (void)addArrangedSubview:(UIView *)view {
    if (view == nil) return;
    [self.mArrangedSubviews addObject:view];
}

- (void)removeArrangedSubview:(UIView *)view {
    if (view == nil) return;
    NSInteger oldCount = _mArrangedSubviews.count;
    [_mArrangedSubviews removeObject:view];
    NSInteger newCount = _mArrangedSubviews.count;
    if (oldCount != newCount) {
        [view removeFromSuperview];
    }
    
}

- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)stackIndex {
    if (view == nil) return;
    [self.mArrangedSubviews insertObject:view atIndex:stackIndex];
}

#pragma mark - override system method

- (CGSize)sizeThatFits:(CGSize)size {
    
    return size;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
}

#pragma mark - Private
- (void)updateContentSubviewsLayoutWithSize:(CGSize)size isSetLayout:(BOOL)isSetLayout {
    
}

#pragma mark - Getter & Setter

- (NSArray *)arrangedSubviews {
    return [NSArray arrayWithArray:_mArrangedSubviews?:@[]];
}

- (NSMutableArray<UIView *> *)mArrangedSubviews {
    if (_mArrangedSubviews == nil) {
        _mArrangedSubviews = NSMutableArray.array;
    }
    return _mArrangedSubviews;
}

@end
