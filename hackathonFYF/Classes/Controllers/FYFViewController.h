//
//  FYFViewController.h
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"


@interface FYFViewController : UIViewController<ESTBeaconManagerDelegate> {
    UILabel * _beaconLabel;
}

@end
