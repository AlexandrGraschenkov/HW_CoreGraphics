//
//  TreeView.m
//  Tree
//
//  Created by Айдар on 13.11.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import "TreeView.h"
#import "Points.h"

@implementation TreeView

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *arrWidth = [NSArray arrayWithObjects:@10.0f, @8.0f, @6.0f, @4.0f, @2.5f, @1.5f, @1.0f, @0.5f, @0.25f, nil];
    NSArray *arrHeight = [NSArray arrayWithObjects:@160.0f, @100.0f, @65.0f, @35.0f, @20.0f, @12.0f, @7.0f, @4.0f, @2.0f, nil];
    NSMutableArray *points1 = [NSMutableArray arrayWithObject:[[Points alloc] initWithPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)) angle:0]];
    NSMutableArray *points2 = [NSMutableArray new];
    for (int lvl = 0; lvl < 9; lvl++) {
        for (Points *p in points1) {
            CGContextMoveToPoint(context, p.point.x, p.point.y);
            CGPoint vector = CGPointMake(0, -[arrHeight[lvl] doubleValue]);
            vector = CGPointApplyAffineTransform(vector, CGAffineTransformMakeRotation(p.angle));
            CGPoint endPoint = CGPointMake(p.point.x + vector.x, p.point.y + vector.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            Points *np1 = [[Points alloc] initWithPoint:endPoint angle:p.angle + 0.35];
            Points *np2 = [[Points alloc] initWithPoint:endPoint angle:p.angle - 0.35];
            [points2 addObject:np1];
            [points2 addObject:np2];
        }
        points1 = points2;
        points2 = [NSMutableArray new];
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, [arrWidth[lvl] doubleValue]);
        CGContextStrokePath(context);
    }
}

@end
