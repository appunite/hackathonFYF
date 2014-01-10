//
//  FYFLocationObject.m
//  hackathonFYF
//
//  Created by Emil Wojtaszek on 10.01.2014.
//  Copyright (c) 2014 AppUnite.com. All rights reserved.
//

#import "FYFLocationObject.h"

@implementation FYFLocationObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"body": @"body",
        @"title": @"title"
    };
}

@end
