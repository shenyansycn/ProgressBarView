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

}
@property (weak, nonatomic) IBOutlet MyCustomView *myCustomView;
@property (nonatomic, strong) NSTimer *durationTimer;

@end

@implementation XibLayoutViewController

-(void)progressTouchEnded:(float)progressPrecent {
//    NSLog(@"progressTouchEnded = %f", progressPrecent);
    
}
-(void)progressTouchMoved:(float)progressPrecent {
//    NSLog(@"progressTouchMoved = %f" , progressPrecent);
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [_myCustomView setProgressPrecent:22.988506];
    [_myCustomView setDamp:0.8f];
    _myCustomView.delegate = self;
    [_myCustomView setProgerssBarWidth:13.0f];

    // Do any additional setup after loading the view from its nib.
}


- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
