//
//  Points.h
//  HW_CoreGraphics
//
//  Created by Евгений Сергеев on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Points : NSObject

@property (nonatomic) CGPoint point;
@property (nonatomic) float angle;

- (id)initWithPoint:(CGPoint)point angle:(float)angle;

@end
