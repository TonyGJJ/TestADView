//
//  ViewController.m
//  TestADView
//
//  Created by 刘杨 on 15/4/21.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "CSIIADView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonAction:(UIButton *)sender {
    CSIIADView *adView = [[CSIIADView alloc] initSubView];
    [adView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
