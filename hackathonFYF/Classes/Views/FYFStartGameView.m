//
//  FYFStartGameView.m
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFStartGameView.h"

@implementation FYFStartGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _readyButton = [[UIButton alloc] init];
        [_readyButton setBackgroundColor:[UIColor redColor]];
        [_readyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_readyButton setTitle:@"Ready" forState:UIControlStateNormal];
        [self addSubview:_readyButton];

    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [_readyButton setFrame:CGRectMake(0, 0, 200.0f, 40.0f)];
    [_readyButton setCenter:self.center];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
