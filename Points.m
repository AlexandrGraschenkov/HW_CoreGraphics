//
//  Points.m
//  Tree
//
//  Created by Айдар on 13.11.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
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
