
//
//  FYFBoardViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

// Frameworks
#import "AudioToolbox/AudioServices.h"

//Controllers
#import "FYFBoardViewController.h"
#import "FYFSocketManager.h"

//Views
#import "FYFBoardView.h"
#import "WaitingForPlayersView.h"

@interface FYFBoardViewController () {
    ESTBeaconManager * _beaconManager;
    BOOL _canRange;
}

@end

@implementation FYFBoardViewController {
    FYFBoardView *_boardView;
    CountdownView * _countdownView;
    CountdownView * _goView;
    LoserView * _loserView;
    SuccessView * _successView;
    WaitingForPlayersView *_waitingView;
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
    
    _goView = [[CountdownView alloc] initWithFrame:rect];
    [_goView setAnimationDelegate:self];
    [view addSubview:_goView];
    
    _loserView = [[LoserView alloc] initWithFrame:rect];
    [_loserView setAnimationDelegate:self];
    [view addSubview:_loserView];
    
    _successView = [[SuccessView alloc] initWithFrame:rect];
    [_successView setAnimationDelegate:self];
    [view addSubview:_successView];
    
    _waitingView = [[WaitingForPlayersView alloc] initWithFrame:rect];
    [_waitingView setAnimationDelegate:self];
    [view addSubview:_waitingView];
    
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
    

    // add pop gesture recognizer
    [self.navigationController.interactivePopGestureRecognizer setDelegate:(id<UIGestureRecognizerDelegate>)self];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];

    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCountdownMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSString * time = [NSString stringWithFormat:@"%@",[[note userInfo] objectForKey:@"time"]];
                                                      [_waitingView removeFromSuperview];
													  [_countdownView startAnimationWithTime:time];
                                                      
                                                      [_boardView removeBeacons];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerOccupatedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_loserView startAnimation];
                                                  }];

    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerStartedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_goView startAnimationWithTime:@"GO!"];
                                                      [_boardView addBeacons:5];
                                                      
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCapturedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_successView startAnimation];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerWaitingMessageNotification

                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_waitingView startAnimation];
                                                  }];
    
    
    
    _beaconManager = [[ESTBeaconManager alloc] init];
    _beaconManager.delegate = self;
    _beaconManager.avoidUnknownStateBeacons = YES;
    _canRange = NO;
    
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    [_beaconManager startRangingBeaconsInRegion:region];
    [_beaconManager startEstimoteBeaconsDiscoveryForRegion:region];

    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerFinishedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      [_boardView removeBeacons];
                                                  }];
    
	// testing
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark -
#pragma mark Private

#pragma mark - 
#pragma mark CountdownView

- (void)countdownViewdidFinishCounting:(CountdownView *)countdownView {
    _canRange = ([countdownView isEqual:_goView]);
}
    
   

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    
    if([beacons count] > 0 && _canRange) {
        
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"rssi != 0"];
        NSArray * noZeroRssi = [beacons filteredArrayUsingPredicate:predicate];
        
        NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:NO];
        NSArray * sortedBeacons = [noZeroRssi sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        ESTBeacon * beacon = [sortedBeacons firstObject];
        
        if (beacon.rssi >= -52) {
            _canRange = NO;
            [[FYFSocketManager sharedManager] announcePresenceOfBeaconWithMinor:beacon.minor];
        }
    }
}


@end
