//
//  NavigationController.m
//  AVPlayerTest
//
//  Created by Kaige on 15/6/30.
//  Copyright (c) 2015年 杜书凯. All rights reserved.
//

#import "NavigationController.h"
#import "VideoViewController.h"
@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}
-(NSUInteger)supportedInterfaceOrientations{
    return self.topViewController.supportedInterfaceOrientations;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
