//
//  ViewController.m
//  TreeGraphicsChanllenge
//
//  Created by Игорь Савельев on 09/11/14.
//  Copyright (c) 2014 Leonspok. All rights reserved.
//

#import "ViewController.h"
#import "TreeView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TreeView *treeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_treeView buildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id)sender {
    [_treeView animate];
}

@end
