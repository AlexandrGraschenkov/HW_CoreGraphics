//
//  Points.m
//  HW_CoreGraphics
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
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
