//
//  WaitingForPlayersView.m
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "WaitingForPlayersView.h"

@implementation WaitingForPlayersView

- (void)startAnimation {
    
    [self animationWithText:@"Waiting for players!" completion:^(BOOL finished) {
    }];
}

@end
