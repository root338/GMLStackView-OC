//
//  GMLStackSubviewAttributes.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "GMLStackSubviewAttributes.h"

@implementation GMLStackSubviewAttributes

- (instancetype)init {
    self = [super init];
    if (self) {
        _needUpdateExpectedSize = YES;
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone {
    GMLStackSubviewAttributes *attributes = [[self class] new];
    attributes.areaStatus = self.areaStatus;
    attributes.insets = self.insets;
    attributes.frame = self.frame;
    attributes.expectedSize = self.expectedSize;
    attributes.needUpdateExpectedSize = self.needUpdateExpectedSize;
    attributes.linkView = self.linkView;
    return attributes;
}

#pragma mark - override system method
- (BOOL)isEqual:(GMLStackSubviewAttributes *)object {
    if (object == nil) return NO;
    if (![self isMemberOfClass:self.class]) return NO;
    if (CGSizeEqualToSize(self.expectedSize, object.expectedSize)
        && self.areaStatus == object.areaStatus
        && UIEdgeInsetsEqualToEdgeInsets(self.insets, object.insets)
        && self.linkView == object.linkView
        && self.needUpdateExpectedSize == object.needUpdateExpectedSize) {
        return YES;
    }
    return NO;
}

#pragma mark - Getter & Setter

- (void)setExpectedSize:(CGSize)expectedSize {
    _expectedSize = expectedSize;
    _needUpdateExpectedSize = NO;
}

@end
