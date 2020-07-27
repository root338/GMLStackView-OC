//
//  GMLStackView.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackView.h"
#import "GMLStackLayoutHelper.h"

@interface GMLStackView ()

@property (nonatomic, strong) NSMutableArray<UIView *> *mArrangedSubviews;

@property (nonatomic, strong) GMLStackLayoutHelper *helper;

@end

@implementation GMLStackView

- (instancetype)initWithArrangedSubviews:(NSArray *)views {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _mArrangedSubviews = [NSMutableArray arrayWithArray:views?:@[]];
        for (UIView *view in views) {
            [self addSubview:view];
        }
    }
    return self;
}

- (void)addArrangedSubview:(UIView *)view {
    if (view == nil) return;
    [self.mArrangedSubviews addObject:view];
    [self addSubview:view];
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
    [self addSubview:view];
}

- (void)setCustomSpacing:(CGFloat)spacing afterView:(UIView *)arrangedSubview {
    
}

- (CGFloat)customSpacingAfterView:(UIView *)arrangedSubview {
    return 0;
}

#pragma mark - override system method

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.helper sizeThatFits:size];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.helper setContentLayoutWithSize:self.bounds.size];
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

- (GMLStackLayoutHelper *)helper {
    if (_helper == nil) {
        _helper = GMLStackLayoutHelper.new;
        _helper.stackView = self;
    }
    return _helper;
}

@end
