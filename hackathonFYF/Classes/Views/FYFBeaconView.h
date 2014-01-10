//
//  FYFBeaconView.h
//  hackathonFYF
//
//  Created by Piotr Bernad on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYFBeaconView : UIView
@property (readonly, nonatomic) UIColor *mainColor;
@property (assign, nonatomic) BOOL available;
- (void)startAnimating;
- (void)stopAnimating;


@end
