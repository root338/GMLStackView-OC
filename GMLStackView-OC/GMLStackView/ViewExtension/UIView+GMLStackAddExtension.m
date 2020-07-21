//
//  UIView+GMLStackAddExtension.m
//  GMLStackViewDemo
//
//  Created by apple on 2020/7/21.
//  Copyright © 2020 GML. All rights reserved.
//

#import "UIView+GMLStackAddExtension.h"
#import <objc/runtime.h>

@interface UIView (_GMLStackAddExtension)

@property (nonatomic, strong) NSMutableDictionary *_gml_contentHuggingPriorityDict;
@property (nonatomic, strong) NSMutableDictionary *_gml_contentCompressionResistancePriorityDict;

@end

@implementation UIView (GMLStackAddExtension)

- (UILayoutPriority)gml_contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis {
    NSNumber *priority = self._gml_contentHuggingPriorityDict[@(axis)];
    if (priority) {
        return priority.floatValue;
    }
    return UILayoutPriorityDefaultLow;
}

- (void)gml_setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    NSMutableDictionary *dict = self._gml_contentHuggingPriorityDict;
    if (dict == nil) {
        dict = [NSMutableDictionary dictionaryWithCapacity:1];
        self._gml_contentHuggingPriorityDict = dict;
    }
    dict[@(axis)] = @(priority);
}

- (UILayoutPriority)gml_contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis {
    NSNumber *priority = self._gml_contentCompressionResistancePriorityDict[@(axis)];
    if (priority) {
        return priority.floatValue;
    }
    return UILayoutPriorityDefaultHigh;
}

- (void)gml_setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    NSMutableDictionary *dict = self._gml_contentCompressionResistancePriorityDict;
    if (dict == nil) {
        dict = [NSMutableDictionary dictionaryWithCapacity:1];
        self._gml_contentCompressionResistancePriorityDict = dict;
    }
    dict[@(axis)] = @(priority);
}

@end

@implementation UIView (_GMLStackAddExtension)

- (void)set_gml_contentHuggingPriorityDict:(NSMutableDictionary *)dict {
    objc_setAssociatedObject(self, @selector(_gml_contentHuggingPriorityDict), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)_gml_contentHuggingPriorityDict {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)set_gml_contentCompressionResistancePriorityDict:(NSMutableDictionary *)dict {
    objc_setAssociatedObject(self, @selector(_gml_contentCompressionResistancePriorityDict), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)_gml_contentCompressionResistancePriorityDict {
    return objc_getAssociatedObject(self, _cmd);
}

@end
