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
    LoserView * _loserView;
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
    
    _loserView = [[LoserView alloc] initWithFrame:rect];
    [_loserView setAnimationDelegate:self];
    [view addSubview:_loserView];
    
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
    
    [_boardView addBeacons:5];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCountdownMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_countdownView startAnimation];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerOccupatedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_loserView startAnimation];
                                                  }];
}

#pragma mark -
#pragma mark Private

#pragma mark - 
#pragma mark CountdownView

- (void)countdownViewdidFinishCounting:(CountdownView *)countdownView {
    if ([countdownView isEqual:_countdownView]) {
        NSLog(@"move bitch!");
    } else {
        NSLog(@"lose bitch!");
    }
}

@end
