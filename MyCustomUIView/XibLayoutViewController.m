//
//  XibLayoutViewController.m
//  MyCustomUIView
//
//  Created by ShenYan on 2017/5/5.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import "XibLayoutViewController.h"
#import "MyCustomView.h"

@interface XibLayoutViewController ()
{
    float i;
}
@property (weak, nonatomic) IBOutlet MyCustomView *myCustomView;
@property (nonatomic, strong) NSTimer *durationTimer;

@end

@implementation XibLayoutViewController

-(void)progressTouchEnded:(float)progressPrecent {
    
}
-(void)progressTouchMoved:(float)progressPrecent {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [_myCustomView setProgressPrecent:22.988506];
    [_myCustomView setDamp:0.8f];
    i = 0.0f;
    
    
    [self startDurationTimer];
    // Do any additional setup after loading the view from its nib.
}

- (void)startDurationTimer
{
    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(monitorVideoPlayback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
}

- (void)monitorVideoPlayback
{
    //    double currentTime = floor([SZGVideoPlayerController getInstanceVideoPlayer].currentPlaybackTime);
    //    double totalTime = floor([SZGVideoPlayerController getInstanceVideoPlayer].duration);
    //    [self setTimeLabelValues:currentTime totalTime:totalTime];
    
    
    i++;
    
    
    NSLog(@"i--------%f",i);
    
    [self.myCustomView setProgressPrecent:i];
    
    //    self.videoControl.progressSlider.value = ceil(currentTime);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
