//
//  TreeView.m
//  TreeGraphicsChanllenge
//
//  Created by Игорь Савельев on 09/11/14.
//  Copyright (c) 2014 Leonspok. All rights reserved.
//

#import "TreeView.h"

#define DEPTH 10
#define START_LENGTH 130
#define ANGLE M_PI/18
#define CURVE_FACTOR 1.3
#define ANIMATION_STEP_DURATION 0.5f

@implementation TreeView {
    NSArray *treeLayers;
    CALayer *maskLayer;
    NSMutableArray *lines;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)buildView {
    CGVector (^rotateVector)(CGVector vector, CGFloat angle) = ^CGVector(CGVector vector, CGFloat angle) {
        CGVector vect = CGVectorMake(vector.dx*cos(angle)-vector.dy*sin(angle), vector.dx*sin(angle)+vector.dy*cos(angle));
        CGFloat vectorLength = sqrt(vect.dx*vect.dx+vect.dy*vect.dy);
        vect.dx /= vectorLength;
        vect.dy /= vectorLength;
        return vect;
    };
    
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:DEPTH];
    for (int i = 0; i < DEPTH; i++) {
        points[i] = [NSMutableArray arrayWithCapacity:(NSInteger)pow(2, i)];
    }
    points[0][0] = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height-START_LENGTH)];
    
    NSArray *lineWidths = @[@10.0f, @8.0f, @6.0f, @4.0f, @2.5f, @1.5f, @1.0f, @0.75f, @0.5f, @0.25f];
    CGVector currentVector = CGVectorMake(0.0f, -1.0f);
    
    lines = [NSMutableArray arrayWithCapacity:DEPTH];
    for (int i = 0; i < DEPTH; i++) {
        lines[i] = [NSMutableArray arrayWithCapacity:(NSInteger)pow(2, i)];
    }
    
    maskLayer = [CALayer layer];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height)];
    [linePath addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)+START_LENGTH*currentVector.dx, self.bounds.size.height+START_LENGTH*currentVector.dy)];
    [shapeLayer setPath:linePath.CGPath];
    [shapeLayer setLineWidth:[lineWidths[0] doubleValue]];
    [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setLineCap:kCALineCapRound];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setStrokeEnd:0.0f];
    [maskLayer addSublayer:shapeLayer];
    
    lines[0][0] = shapeLayer;
    
    for (int i = 1; i < DEPTH; i++) {
        NSInteger scale = (NSInteger)pow(2, i);
        for (int j = 0; j < scale; j++) {
            if (i >= 2) {
                CGPoint startPoint = [points[i-2][j/4] CGPointValue];
                CGPoint endPoint = [points[i-1][j/2] CGPointValue];
                currentVector = CGVectorMake(endPoint.x-startPoint.x, endPoint.y-startPoint.y);
                BOOL left = (j/2%2 == 0);
                currentVector = rotateVector(currentVector, left? -CURVE_FACTOR*ANGLE : CURVE_FACTOR*ANGLE);
            }
            
            BOOL left = (j%2 == 0);
            
            CGFloat currentLength = START_LENGTH/pow(1.4, i);
            CGVector newVector = rotateVector(currentVector, left? -ANGLE : ANGLE);
            
            CGPoint previousPoint = [points[i-1][j/2] CGPointValue];
            CGPoint newPoint = CGPointMake(previousPoint.x+currentLength*newVector.dx, previousPoint.y+currentLength*newVector.dy);
            
            points[i][j] = [NSValue valueWithCGPoint:newPoint];
            
            /******/
            CGPoint currentPoint = previousPoint;
            CGPoint nextPoint = newPoint;
            
            CGVector sourceVector = CGVectorMake(nextPoint.x-currentPoint.x, nextPoint.y-currentPoint.y);
            CGVector rotatedVector = rotateVector(sourceVector, left? CURVE_FACTOR*ANGLE : -CURVE_FACTOR*ANGLE);
            
            CGFloat vectorLength = sqrt(sourceVector.dx*sourceVector.dx+sourceVector.dy*sourceVector.dy)/3;
            CGPoint bezierPoint = CGPointMake(currentPoint.x+vectorLength*rotatedVector.dx, currentPoint.y+vectorLength*rotatedVector.dy);
            
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint:currentPoint];
            [linePath addQuadCurveToPoint:nextPoint controlPoint:bezierPoint];
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            [shapeLayer setPath:linePath.CGPath];
            [shapeLayer setLineWidth:[lineWidths[i] doubleValue]];
            [shapeLayer setFillColor:[UIColor clearColor].CGColor];
            [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
            [shapeLayer setLineCap:kCALineCapRound];
            [shapeLayer setLineJoin:kCALineJoinRound];
            [shapeLayer setStrokeEnd:0.0f];
            lines[i][j] = shapeLayer;
            [maskLayer addSublayer:shapeLayer];
        }
    }
    
    self.layer.mask = maskLayer;
}

- (void)animate {
    for (CALayer *layer in [maskLayer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }
    
    [self buildView];
    
    for (int i = 0; i < DEPTH; i++) {
        NSInteger amount = (NSInteger)pow(2, i);
        for (int j = 0; j < amount; j++) {
            CAShapeLayer *layer = lines[i][j];
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = ANIMATION_STEP_DURATION;
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            pathAnimation.fillMode = kCAFillModeForwards;
            pathAnimation.removedOnCompletion = NO;
            
            int t = j;
            CFTimeInterval delay = 0.0f;
            int k = i;
            while (k >= 0) {
                NSInteger n = (NSInteger)pow(2, k);
                if (k == i) {
                    delay += ABS(n/2-t)*(ANIMATION_STEP_DURATION/n);
                } else {
                    delay += ABS(n/2-t)*(ANIMATION_STEP_DURATION/n)+ANIMATION_STEP_DURATION;
                }
                t /= 2;
                k--;
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [layer addAnimation:pathAnimation forKey:[NSString stringWithFormat:@"strokeEndAnimation%d%d", i, j]];
            });
        }
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat locations[2] = { 0.0, 1.0 };
    
    NSArray *colors = @[(id)[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor,
                        (id)[UIColor colorWithRed:0.3f green:0.0f blue:0.7f alpha:1.0f].CGColor];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,(CFArrayRef)colors, locations);
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), rect.size.height);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, rect.size.height, 0);
}

@end
