//
//  ViewController.m
//  HW_CoreGraphics
//
//  Created by Alexander on 19.04.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyTree *myView = [[MyTree alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
}


@end
