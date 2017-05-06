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
@property (weak, nonatomic) IBOutlet MyCustomView *myCustomView;

@end

@implementation XibLayoutViewController

-(void)progressTouchEnded:(float)progressPrecent {
    
}
-(void)progressTouchMoved:(float)progressPrecent {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_myCustomView setProgressPrecent:30];
    [_myCustomView setDamp:0.8f];
    // Do any additional setup after loading the view from its nib.
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
