//
//  FYFBoardViewController.h
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ESTBeaconManager.h"

//Views
#import "CountdownView.h"
#import "LoserView.h"
#import "SuccessView.h"

@interface FYFBoardViewController : UIViewController<CountdownViewDelegate> 

@end
