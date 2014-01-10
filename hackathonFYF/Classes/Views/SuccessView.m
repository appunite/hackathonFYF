//
//  SuccessView.m
//  hackathonFYF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "SuccessView.h"

@implementation SuccessView


- (void)startAnimation {
    
    [self animationWithText:@"GREAT!" completion:^(BOOL finished) {
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self animationWithText:@"Bitch!" completion:^(BOOL finished) {
                if ([self.animationDelegate respondsToSelector:@selector(countdownViewdidFinishCounting:)]) {
                    [self.animationDelegate countdownViewdidFinishCounting:self];
                }
                
                [UIView animateWithDuration:0.5 animations:^{
                    [_counterLabel setAlpha:0];
                }];
            }];
        });
    }];
}

@end
