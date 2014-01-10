//
//  FYFViewController.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFViewController.h"


@interface FYFViewController () {
    ESTBeaconManager * _beaconManager;
}
@end

@implementation FYFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _beaconManager = [[ESTBeaconManager alloc] init];
    _beaconManager.delegate = self;
    _beaconManager.avoidUnknownStateBeacons = YES;
    
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    [_beaconManager startEstimoteBeaconsDiscoveryForRegion:region];
    
    _beaconLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    [_beaconLabel setTextAlignment:NSTextAlignmentCenter];
    [_beaconLabel setNumberOfLines:0];
    [self.view addSubview:_beaconLabel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Beacons delegate

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    
    if([beacons count] > 0) {
        
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"rssi != 0"];
        NSArray * noZeroRssi = [beacons filteredArrayUsingPredicate:predicate];
        
        NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:NO];
        NSArray * sortedBeacons = [noZeroRssi sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        ESTBeacon * beacon = [sortedBeacons firstObject];
        
        if (beacon.proximity == CLProximityNear) {
            [_beaconLabel setText:[NSString stringWithFormat:@"Nearest beacon:\nMajor:%@\nMinor:%@\nDistance:%@, %ld",beacon.major, beacon.minor, beacon.distance, (long)beacon.rssi]];
        }
    }
}

@end
