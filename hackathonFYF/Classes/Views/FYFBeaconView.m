//
//  FYFBeaconView.m
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFBeaconView.h"

@implementation FYFBeaconView {
    CALayer *layer;
}

- (id)init {
    self = [super init];

    if (self) {
        // Initialization code
        _mainColor = [self randomColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 4.0f, 4.0f)];
    if (_available) {
        [[UIColor clearColor] setFill];
    } else {
        [[_mainColor colorWithAlphaComponent:0.8f] setFill];
    }
    
    [bezierPath setLineWidth:5.0f];
    [[_mainColor colorWithAlphaComponent:0.8f] setStroke];
    [bezierPath stroke];
    [bezierPath fill];
    

}

- (UIColor *)randomColor {
    
    
    
    
    CGFloat hue = ( arc4random() % 256 / 256.0 ) + 0.2;  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.8;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.8;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

- (void)setAvailable:(BOOL)available {
    _available = available;
    [self setNeedsDisplay];
}

- (void)startAnimating {
    CAKeyframeAnimation *firstBounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    CAMediaTimingFunction *easeInOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    firstBounceAnimation.values = @[@0.05, @1.25, @0.8, @1.1, @0.9, @1.0];
    firstBounceAnimation.duration = 2.0f;
    firstBounceAnimation.timingFunctions = @[easeInOut, easeInOut, easeInOut, easeInOut, easeInOut, easeInOut];
    firstBounceAnimation.repeatCount = 1;
    [self.layer addAnimation:firstBounceAnimation forKey:@"popIn"];
    [self performSelector:@selector(startBouncing) withObject:nil afterDelay:2.3f];
}

- (void)startBouncing {
    [self.layer removeAnimationForKey:@"popIn"];
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    CAMediaTimingFunction *easeInOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bounceAnimation.values = @[@1.0f,@0.9, @1.0f, @0.85, @1.0f, @0.9f, @1.0f];
    bounceAnimation.duration = 3.0f;
    bounceAnimation.timingFunctions = @[easeInOut, easeInOut, easeInOut, easeInOut, easeInOut, easeInOut];
    bounceAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
}

- (void)stopAnimating {
    [self.layer removeAnimationForKey:@"bounce"];
}



@end
