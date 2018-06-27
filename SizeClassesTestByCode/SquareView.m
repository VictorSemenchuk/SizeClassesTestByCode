//
//  SquareView.m
//  SizeClassesTestByCode
//
//  Created by Victor Macintosh on 26/06/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "SquareView.h"

@interface SquareView ()

- (void)setupViews;

@end

@implementation SquareView

- (id)initWithColor:(UIColor *)color {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = color;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    //view
    
    self.layer.cornerRadius = 10.0;
    self.clipsToBounds = YES;
    
    //button
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Tap" forState:UIControlStateNormal];
    button.layer.cornerRadius = 3.0;
    button.clipsToBounds = YES;
    button.translatesAutoresizingMaskIntoConstraints = false;
    
    [self addSubview:button];
    
    NSLayoutConstraint *widthConstraint = [button.widthAnchor constraintEqualToConstant:100.0];
    widthConstraint.identifier = @"ButtonWidthConstraint";
    
    NSLayoutConstraint *heightConstraint = [button.heightAnchor constraintEqualToConstant:20.0];
    heightConstraint.identifier = @"ButtonHeightConstraint";
    
    NSLayoutConstraint *centerXConstraint = [button.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    centerXConstraint.identifier = @"ButtonCenterXConstraint";
    
    NSLayoutConstraint *centerYConstraint = [button.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    centerYConstraint.identifier = @"ButtonCenterYConstraint";
    
    [NSLayoutConstraint activateConstraints:@[widthConstraint, heightConstraint, centerXConstraint, centerYConstraint]];
    
}

- (void)tapButton:(UIButton *)sender {
    NSLog(@"Tap");
}

@end
