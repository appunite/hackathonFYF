//
//  CountdownView.m
//  hackathonFYF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "CountdownView.h"

@implementation CountdownView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _counterLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_counterLabel setTextColor:[UIColor blackColor]];
        [_counterLabel setTextAlignment:NSTextAlignmentCenter];
        [_counterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:180]];
        [_counterLabel setAlpha:0];
        [self addSubview:_counterLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_counterLabel setFrame:self.bounds];
}

- (void)startAnimation {
    
    [self animationWithText:@"3" completion:^(BOOL finished) {
        [self animationWithText:@"2" completion:^(BOOL finished) {
            [self animationWithText:@"1" completion:^(BOOL finished) {
                [self animationWithText:@"GO!" completion:^(BOOL finished) {
                    if ([self.animationDelegate respondsToSelector:@selector(countdownViewdidFinishCounting:)]) {
                        [self.animationDelegate countdownViewdidFinishCounting:self];
                    }
                }];
            }];
        }];
    }];
}

- (void)animationWithText:(NSString*)text completion:(void (^)(BOOL))completion {
    [_counterLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)];
    [_counterLabel setAlpha:1];
    [_counterLabel setText:text];
    
    [UIView animateWithDuration:1 animations:^{
        [_counterLabel setAlpha:0];
        [_counterLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, .25, .25)];
        
    } completion:completion];
}

@end
