//
//  ViewController.m
//  SizeClassesTestByCode
//
//  Created by Victor Macintosh on 26/06/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ViewController.h"
#import "SquareView.h"

@interface ViewController () <SquareViewDelegate>

@property (retain, nonatomic) SquareView *redSquareView;
@property (retain, nonatomic) SquareView *blueSquareView;
@property (retain, nonatomic) NSMutableArray *wC;
@property (retain, nonatomic) NSMutableArray *wR;
@property (retain, nonatomic) NSLayoutConstraint *heightConstraint;
@property (retain, nonatomic) NSLayoutConstraint *widthConstraint;
@property (assign, nonatomic) CGFloat margin;

- (void)setupViews;

@end

//MARK:- Lifecycle

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.wC = [[NSMutableArray alloc] init];
    self.wR = [[NSMutableArray alloc] init];
    self.margin = 20.0;
    
    [self setupViews];
}

//MARK:- Setup views

- (void)setupViews {
    
    self.redSquareView = [[SquareView alloc] initWithColor:UIColor.redColor];
    self.redSquareView.translatesAutoresizingMaskIntoConstraints = NO;
    self.redSquareView.tag = 1001;
    self.redSquareView.delegate = self;
    [self.view addSubview:self.redSquareView];
    
    self.blueSquareView = [[SquareView alloc] initWithColor:UIColor.blueColor];
    self.blueSquareView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueSquareView.tag = 1002;
    self.blueSquareView.delegate = self;
    [self.view addSubview:self.blueSquareView];
    
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    
    //Setup common constraints
    
    NSLayoutConstraint *redSquareLeadingConstraint = [self.redSquareView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:self.margin];
    redSquareLeadingConstraint.identifier = @"redSquareLeadingConstraint";
    NSLayoutConstraint *redSquareTopConstraint = [self.redSquareView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:self.margin];
    redSquareTopConstraint.identifier = @"redSquareTopConstraint";
    
    NSLayoutConstraint *blueSquareTrailingConstraint = [self.blueSquareView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-self.margin];
    blueSquareTrailingConstraint.identifier = @"blueSquareTrailingConstraint";
    NSLayoutConstraint *blueSquareBottomConstraint = [self.blueSquareView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor constant:-self.margin];
    blueSquareBottomConstraint.identifier = @"blueSquareBottomConstraint";
    
    //Setup width compact constraints

    NSLayoutConstraint *redSquareTrailingConstraintWC = [self.redSquareView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-self.margin];
    redSquareTrailingConstraintWC.identifier = @"redSquareTrailingConstraintWC";
    NSLayoutConstraint *redSquareHeightConstraintWC = [self.redSquareView.heightAnchor constraintLessThanOrEqualToAnchor:self.view.heightAnchor multiplier:0.5 constant:-1.5 * self.margin];
    redSquareHeightConstraintWC.identifier = @"redSquareHeightConstraintWC";
    self.heightConstraint = redSquareHeightConstraintWC;
    
    NSLayoutConstraint *blueSquareLeadingConstraintWC = [self.blueSquareView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:self.margin];
    blueSquareLeadingConstraintWC.identifier = @"blueSquareLeadingConstraintWC";
    NSLayoutConstraint *blueSquareTopConstraintWC = [self.blueSquareView.topAnchor constraintEqualToAnchor:self.redSquareView.bottomAnchor constant:self.margin];
    blueSquareTopConstraintWC.identifier = @"blueSquareTopConstraintWC";
    
    self.wC = [NSMutableArray arrayWithObjects:redSquareLeadingConstraint, redSquareTopConstraint, redSquareTrailingConstraintWC, redSquareHeightConstraintWC, blueSquareLeadingConstraintWC, blueSquareTopConstraintWC, blueSquareTrailingConstraint, blueSquareBottomConstraint, nil];
    
    //Setup width regular constraints
    
    NSLayoutConstraint *redSquareBottomConstraintWR = [self.redSquareView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor constant:-self.margin];
    redSquareBottomConstraintWR.identifier = @"redSquareBottomConstraintWR";
    NSLayoutConstraint *redSquareWidthConstraintWR = [self.redSquareView.widthAnchor constraintEqualToAnchor:guide.widthAnchor multiplier:0.5 constant:(-1.5 * self.margin)];
    redSquareWidthConstraintWR.identifier = @"redSquareWidthConstraintWR";
    self.widthConstraint = redSquareWidthConstraintWR;
    
    NSLayoutConstraint *blueSquareLeadingConstraintWR = [self.blueSquareView.leadingAnchor constraintEqualToAnchor:self.redSquareView.trailingAnchor constant:self.margin];
    blueSquareBottomConstraint.identifier = @"blueSquareLeadingConstraintWR";
    NSLayoutConstraint *blueSquareTopConstraintWR = [self.blueSquareView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:self.margin];
    blueSquareBottomConstraint.identifier = @"blueSquareTopConstraintWR";
    
    self.wR = [NSMutableArray arrayWithObjects:redSquareLeadingConstraint, redSquareTopConstraint, redSquareBottomConstraintWR, redSquareWidthConstraintWR, blueSquareLeadingConstraintWR, blueSquareTopConstraintWR, blueSquareTrailingConstraint, blueSquareBottomConstraint, nil];
    
}

//MARK:- TraitCollectionMethods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self updateConstraintsForNewTraitCollection:newCollection forSquare:self.redSquareView];
    [self updateConstraintsForNewTraitCollection:newCollection forSquare:self.blueSquareView];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        [NSLayoutConstraint deactivateConstraints:self.wR];
        [NSLayoutConstraint activateConstraints:self.wC];
    } else if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        [NSLayoutConstraint deactivateConstraints:self.wC];
        [NSLayoutConstraint activateConstraints:self.wR];
    } else {
        return;
    }

}

//MARK:- Updaring constraints methods

- (void)wasTappedButtonInSquareWithTag:(NSInteger)tag {
    SquareView *square = [self.view viewWithTag:tag];
    [self updateConstraintsBySender:square];
}

- (void)updateConstraintsBySender:(SquareView *)square {
    
    BOOL isFolded = square.isFolded;
    CGFloat constraintValue;
    
    if ([square isEqual:self.redSquareView]) {
        self.blueSquareView.isFolded = NO;
        if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = isFolded ? -1.5 * self.margin : -self.view.frame.size.height / 4;
        } else {
            constraintValue = isFolded ? -1.5 * self.margin : -self.view.frame.size.width / 4;
        }
    } else if ([square isEqual:self.blueSquareView]) {
        self.redSquareView.isFolded = NO;
        if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = isFolded ? -1.5 * self.margin : self.view.frame.size.height / 4 - 3 * self.margin;
        } else {
            constraintValue = isFolded ? -1.5 * self.margin : self.view.frame.size.width / 4 - 3 * self.margin;
        }
    } else {
        return;
    }
    
    self.heightConstraint.constant = constraintValue;
    self.widthConstraint.constant = constraintValue;
 
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

- (void)updateConstraintsForNewTraitCollection:(UITraitCollection*)traitCollection forSquare:(SquareView *)square {
    
    BOOL isFolded = square.isFolded;
    CGFloat constraintValue;
    
    if ([square isEqual:self.redSquareView]) {
        if (self.blueSquareView.isFolded) {
            return;
        }
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = !isFolded ? -1.5 * self.margin : -self.view.frame.size.width / 4;
        } else {
            constraintValue = !isFolded ? -1.5 * self.margin : -self.view.frame.size.height / 4;
        }
    } else if ([square isEqual:self.blueSquareView]) {
        if (self.redSquareView.isFolded) {
            return;
        }
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            constraintValue = !isFolded ? -1.5 * self.margin : self.view.frame.size.width / 4 - 3 * self.margin;
        } else {
            constraintValue = !isFolded ? -1.5 * self.margin : self.view.frame.size.height / 4 - 3 * self.margin;
        }
    } else {
        return;
    }
    
    self.heightConstraint.constant = constraintValue;
    self.widthConstraint.constant = constraintValue;
    
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
}

@end
