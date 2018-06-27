//
//  SquareView.h
//  SizeClassesTestByCode
//
//  Created by Victor Macintosh on 26/06/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SquareViewDelegate <NSObject>

- (void)wasTappedButtonInSquareWithTag:(NSInteger)tag;

@end

@interface SquareView : UIView

@property (assign, nonatomic) BOOL isFolded;
@property (weak, nonatomic) id<SquareViewDelegate> delegate;

- (id)initWithColor:(UIColor *)color;

@end
