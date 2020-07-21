//
//  GMLStackViewInfo.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackViewInfo.h"

@interface GMLStackViewInfo ()

@end

@implementation GMLStackViewInfo

#pragma mark - Private
- (void)_clear {
    _fixedWidth = nil;
    _fixedHeight = nil;
}

#pragma mark - Getter & Setter
- (void)setStackView:(UIView<GMLStackViewProtocol> *)stackView {
    if (stackView == _stackView) { return; }
    stackView = _stackView;
    [self _clear];
}



@end
