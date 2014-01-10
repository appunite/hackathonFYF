
//
//  FYFBoardViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Controllers
#import "FYFBoardViewController.h"
#import "FYFSocketManager.h"

//Views
#import "FYFBoardView.h"

@interface FYFBoardViewController () {
    ESTBeaconManager * _beaconManager;
    BOOL _canRange;
}

@end

@implementation FYFBoardViewController {
    FYFBoardView *_boardView;
    CountdownView * _countdownView;
    LoserView * _loserView;
    SuccessView * _successView;
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
    
    _successView = [[SuccessView alloc] initWithFrame:rect];
    [_successView setAnimationDelegate:self];
    [view addSubview:_successView];
    
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
    

    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCountdownMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_boardView removeBeacons];
                                                      [_countdownView startAnimation];
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
                                                      [_boardView removeBeacons];
                                                      [_boardView addBeacons:5];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:FYFSocketManagerCapturedMessageNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [_successView startAnimation];
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
    
    
}

#pragma mark -
#pragma mark Private

#pragma mark - 
#pragma mark CountdownView

- (void)countdownViewdidFinishCounting:(CountdownView *)countdownView {
    _canRange = ([countdownView isEqual:_countdownView]);
}
    
   

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    
    if([beacons count] > 0 && _canRange) {
        
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"rssi != 0"];
        NSArray * noZeroRssi = [beacons filteredArrayUsingPredicate:predicate];
        
        NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:NO];
        NSArray * sortedBeacons = [noZeroRssi sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        ESTBeacon * beacon = [sortedBeacons firstObject];
        
        if (beacon.rssi <= -50) {
            [[FYFSocketManager sharedManager] announcePresenceOfBeaconWithMinor:beacon.minor];
        }
    }
}


@end
