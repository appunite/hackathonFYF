//
//  FYFBoardView.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFBoardView.h"
#import "FYFBeaconView.h"

@implementation FYFBoardView {
    UIImageView *_backgroundView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
        [self addSubview:_backgroundView];
        
        
    }
    return self;
}
- (void)addBeacons:(NSInteger)beaconsNumber {
    _beacons = [[NSMutableArray alloc] init];
    
    for (int i=0; i < beaconsNumber; i++) {
        FYFBeaconView *beacon = [[FYFBeaconView alloc] init];
        [beacon setAvailable:YES];
        [beacon startAnimating];
        [self addSubview:beacon];
        [_beacons addObject:beacon];
    }
    
    [self setNeedsDisplay];
}

- (void)removeBeacons {
     for (FYFBeaconView *b in _beacons) {
         [b removeFromSuperview];
     }
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backgroundView setFrame:self.bounds];
    
    CGSize beaconSize = CGSizeMake(30.0f, 30.0f);
    CGFloat x = 30.0f;
    CGFloat y = 50.0f;
    NSInteger i = 1;
    
    for (FYFBeaconView *b in _beacons) {
        y = 90.0f * i;
        CGRect rect = CGRectMake(x, y, beaconSize.width, beaconSize.height);
        [b setFrame:rect];
        if (i == 3) {
            x = CGRectGetMaxX(self.bounds) - 60.0f;
            y = 30.0f;
            i = 1;
        }
        i++;
    }
    
}

- (void)addBeacons {
    
}


@end
