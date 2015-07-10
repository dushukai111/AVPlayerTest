//
//  VideoViewController.h
//  AVPlayerTest
//
//  Created by Kaige on 15/6/29.
//  Copyright (c) 2015年 杜书凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
@interface VideoViewController : UIViewController
@property (strong,nonatomic)AVPlayer *player;
@property (strong,nonatomic)AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UISlider *slideView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)goBack:(id)sender;

- (IBAction)onPlayBtnClick:(id)sender;
@end
