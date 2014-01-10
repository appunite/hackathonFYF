//
//  FYFBoardView.h
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYFBoardView : UIView
@property (strong, nonatomic) NSMutableArray *beacons;
- (void)addBeacons:(NSInteger)beaconsNumber;
@end
