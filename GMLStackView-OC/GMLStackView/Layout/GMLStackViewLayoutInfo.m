//
//  GMLStackViewLayoutInfo.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackViewLayoutInfo.h"

@interface GMLStackViewLayoutInfo ()

@end

@implementation GMLStackViewLayoutInfo


#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone {
    GMLStackViewLayoutInfo *info = [[self class] new];
    info.contentSize = self.contentSize;
    info.totalSpacing = self.totalSpacing;
    info.maxWidth = self.maxWidth;
    info.maxHeight = self.maxHeight;
    info.arrangedSubviews = self.arrangedSubviews;
    info.insets = self.insets;
    info.spacing = self.spacing;
    info.axis = self.axis;
    info.distribution = self.distribution;
    info.alignment = self.alignment;
    info.ignoreHiddenView = self.ignoreHiddenView;
    info.subviewAttributes = self.subviewAttributes;
    return info;
}

#pragma mark - Private
- (void)_clear {
}

#pragma mark - Getter & Setter
//- (void)setStackView:(UIView<GMLStackViewProtocol> *)stackView {
//    if (stackView == _stackView) { return; }
//    stackView = _stackView;
//    [self _clear];
//}

@end
