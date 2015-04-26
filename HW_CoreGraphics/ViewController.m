//
//  ViewController.m
//  HW_CoreGraphics
//
//  Created by Alexander on 19.04.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) MyCanvas *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myView = [[MyCanvas alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_myView];
}

-(void)releaseOutlets{
    _myView=nil;
}
-(void)viewDidUnload{
    [super viewDidUnload];
    [self releaseOutlets];
}
-(void)dealloc{
    [self releaseOutlets];
}



@end
