//
//  FYFLocationObject.h
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

//Frmaeworks
#import <Foundation/Foundation.h>

//Mantle
#import "Mantle.h"

@interface FYFLocationObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;

@end
