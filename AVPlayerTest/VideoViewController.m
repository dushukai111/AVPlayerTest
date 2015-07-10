//
//  VideoViewController.m
//  AVPlayerTest
//
//  Created by Kaige on 15/6/29.
//  Copyright (c) 2015年 杜书凯. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController (){
    BOOL isPaused;
    float totalSeconds;
}

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    
    isPaused=YES;
    self.progressView.progress=0.0;
    self.slideView.value=0.0;
    NSString *url=@"http://lx.cdn.baidupcs.com/file/2f1e3b526742378f498adf619de50ff0?bkt=p2-nb-520&xcode=83db52e6618b775eb92668b57f1f930f93078e134345a6a6ed03e924080ece4b&fid=4061453976-250528-915851660462189&time=1435638855&sign=FDTAXERLBH-DCb740ccc5511e5e8fedcff06b081203-WMVl8suRCXsUD1ft39frTNtSw04%3D&to=hc&fm=Nin,B,T,t&sta_dx=1519&sta_cs=28851&sta_ft=mp4&sta_ct=5&newver=1&newfm=1&flow_ver=3&sl=83034188&expires=8h&rt=sn-gp&r=456251166&mlogid=2188522939&vuk=3961185482&vbdid=1998991816&fin=%E3%80%90%E5%BE%AE%E4%BF%A1new_films%E6%9B%B4%E5%A4%9A%E7%94%B5%E5%BD%B1%E3%80%91fulian2.mp4&fn=%E3%80%90%E5%BE%AE%E4%BF%A1new_films%E6%9B%B4%E5%A4%9A%E7%94%B5%E5%BD%B1%E3%80%91fulian2.mp4&slt=pm&uta=0&rtype=1&iv=0";
    self.playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player=[AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player=self.player;
    self.playBtn.enabled=NO;
    
    [self.activityView startAnimating];
    
    UITapGestureRecognizer *playerViewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPlayerViewTap:)];
    self.playerView.userInteractionEnabled=YES;
    [self.playerView addGestureRecognizer:playerViewTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidEndPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)onPlayerViewTap:(UIGestureRecognizer*)gesture{
    if (self.topView.alpha==0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.alpha=0.5;
            self.bottomView.alpha=1.0;
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.alpha=0;
            self.bottomView.alpha=0.0;
        }];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            totalSeconds=(float)self.playerItem.duration.value/self.playerItem.duration.timescale;
            [self initValues];//初始化视图的值
            
            [self.activityView stopAnimating];
            self.activityView.hidden=YES;
            self.playBtn.enabled=YES;
            [self.playBtn setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
            [self.player play];
            [self addPlayerStateListener];
            
            
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
            
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //计算缓冲进度
        NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
        float progress=result*1.0/totalSeconds;
        self.progressView.progress=progress;
        
    }
}
-(void)initValues{
    //设置totalTimeLabel值
    self.totalTimeLabel.text=[self getTimeBySeconds:(long)totalSeconds];
    
    //设置slide值范围
    self.slideView.minimumValue=0.0;
    self.slideView.maximumValue=totalSeconds;
}
-(NSString*)getTimeBySeconds:(long)seconds{
    NSInteger hour=seconds/3600;
    NSInteger minute=(seconds-hour*3600)/60;
    NSInteger second=seconds-hour*3600-minute*60;
    NSString *hourStr=hour>=10?[NSString stringWithFormat:@"%d",hour]:[NSString stringWithFormat:@"0%d",hour];
    NSString *minuteStr=minute>=10?[NSString stringWithFormat:@"%d",minute]:[NSString stringWithFormat:@"0%d",minute];
    NSString *secondStr=second>=10?[NSString stringWithFormat:@"%d",second]:[NSString stringWithFormat:@"0%d",second];
    NSString *timeStr=[NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
    return timeStr;
}
-(void)addPlayerStateListener{
    __weak VideoViewController *videoControl=self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time){
        CGFloat currentSeconds=CMTimeGetSeconds(videoControl.playerItem.currentTime);
        
        videoControl.currentTimeLabel.text=[videoControl getTimeBySeconds:(long)currentSeconds];
        videoControl.slideView.value=currentSeconds;
    }];
}
-(void)playerDidEndPlay{
    //播放结束
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPlayBtnClick:(id)sender {
    if (isPaused) {
        isPaused=NO;
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player play];
    }
    else{
        isPaused=YES;
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
    }
}

@end
