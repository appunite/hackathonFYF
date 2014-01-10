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
    FYFBeaconView *_beacon;
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
        
        _beacon = [[FYFBeaconView alloc] init];
        [self performSelector:@selector(addBeacon) withObject:nil afterDelay:3.0f];
        
        
        
    }
    return self;
}

- (void)addBeacon {
    [self addSubview:_beacon];
    [_beacon startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backgroundView setFrame:self.bounds];
    [_beacon setFrame:CGRectMake(80.0, 80.0f, 30.0f, 30.0f)];
}

- (void)addBeacons {
    
}


@end
