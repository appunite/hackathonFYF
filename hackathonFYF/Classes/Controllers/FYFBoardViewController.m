//
//  FYFBoardViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Controllers
#import "FYFBoardViewController.h"

//Views
#import "FYFBoardView.h"

@interface FYFBoardViewController ()

@end

@implementation FYFBoardViewController {
    FYFBoardView *_boardView;
    CountdownView * _countdownView;
}

- (void)loadView {
    // get app frame
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    // create and assign view
    FYFBoardView* view = [[FYFBoardView alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
    _countdownView = [[CountdownView alloc] initWithFrame:rect];
    [_countdownView setAnimationDelegate:self];
    [view addSubview:_countdownView];
    
    // save weak referance
    _boardView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // reconnect view if needed
    if (![[FYFSocketManager sharedManager] isConnected]) {
        [[FYFSocketManager sharedManager] reconnect];
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCountdownMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_countdownView startAnimation];
                                                  }];
}

#pragma mark -
#pragma mark Private

#pragma mark - 
#pragma mark CountdownView

- (void)countdownViewdidFinishCounting:(CountdownView *)countdownView {
    NSLog(@"move bitch!");
}

@end
