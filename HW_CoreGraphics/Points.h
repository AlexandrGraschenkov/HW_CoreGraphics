//
//  Points.h
//  HW_CoreGraphics
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Points : NSObject

@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) float angle;

- (id)initWithPoint:(CGPoint)point angle:(float)angle;


@end
