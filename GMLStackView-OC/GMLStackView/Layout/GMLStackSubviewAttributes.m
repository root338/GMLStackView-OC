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

- (void)setExpectedSize:(CGSize)expectedSize {
    _expectedSize = expectedSize;
    _needUpdateExpectedSize = NO;
}

@end
