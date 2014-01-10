//
//  CountdownView.h
//  hackathonFYF
//
//  Created by Piotrek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountdownView;

@protocol CountdownViewDelegate <NSObject>
- (void)countdownViewdidFinishCounting:(CountdownView*)countdownView;
@end

@interface CountdownView : UIView {
    UILabel * _counterLabel;
}

@property (nonatomic, weak) id<CountdownViewDelegate> animationDelegate;

- (void)startAnimation;

@end
