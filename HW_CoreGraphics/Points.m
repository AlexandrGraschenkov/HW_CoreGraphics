//
//  Points.m
//  Tree
//
//  Created by Михаил on 01.05.14.
//  Copyright (c) 2014 Михаил. All rights reserved.
//

#import "Points.h"

@implementation Points

- (id)initWithPoint:(CGPoint)point angle:(float)angle
{
    self = [super init];
    if (self) {
        self.point = point;
        self.angle = angle;
    }
    return self;
}

@end
