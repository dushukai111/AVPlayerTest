//
//  ViewController.m
//  AVPlayerTest
//
//  Created by Kaige on 15/6/29.
//  Copyright (c) 2015年 杜书凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toPlayVideo:(id)sender {
    [self performSegueWithIdentifier:@"toVideo" sender:self];
    
}

-(BOOL)shouldAutorotate{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
