//
//  FYFBoardViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Controllers
#import "FYFBoardViewController.h"
#import "FYFStartGameViewController.h"

//Views
#import "FYFBoardView.h"

@interface FYFBoardViewController ()

@end

@implementation FYFBoardViewController {
    FYFBoardView *_boardView;
}

- (void)loadView {
    // get app frame
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    // create and assign view
    FYFBoardView* view = [[FYFBoardView alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
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
	
    [self _showReadyViewController];
}

#pragma mark -
#pragma mark Private

- (void)_showReadyViewController {
    FYFStartGameViewController *readyViewController = [[FYFStartGameViewController alloc] init];
    [self.navigationController presentViewController:readyViewController animated:YES completion:nil];
}


@end
