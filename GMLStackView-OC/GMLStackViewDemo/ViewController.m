//
//  ViewController.m
//  GMLStackView-OC
//
//  Created by apple on 2020/7/20.
//  Copyright © 2020 GML. All rights reserved.
//

#import "ViewController.h"
#import "GMLStackView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMLStackView *stackView = [[GMLStackView alloc] initWithArrangedSubviews:@[
        [self labelWithText:@"测试"],
        [self buttonWithTitle:@"测试,测试,测试,测试"],
        [self labelWithText:@"测试,测试,测试,测试,测试,测试,测试,测试"],
    ]];
//    stackView.axis = GMLAxisVertical;
    CGSize stackViewSize = [stackView sizeThatFits:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    NSLog(@"%@", NSStringFromCGSize(stackViewSize));
    CGRect stackViewFrame = CGRectMake(0, 100, stackViewSize.width, stackViewSize.height);
    stackView.frame = stackViewFrame;
    [self.view addSubview:stackView];
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = UILabel.new;
    label.text = text;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

@end
