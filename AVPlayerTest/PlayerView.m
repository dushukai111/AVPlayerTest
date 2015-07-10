//
//  PlayerView.m
//  AVPlayerTest
//
//  Created by Kaige on 15/6/29.
//  Copyright (c) 2015年 杜书凯. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(Class)layerClass{
    return [AVPlayerLayer class];
}
-(void)setPlayer:(AVPlayer *)player{
    [(AVPlayerLayer*)self.layer setPlayer:player];
}
-(AVPlayer *)player{
    return ((AVPlayerLayer*)self.layer).player;
}
@end
