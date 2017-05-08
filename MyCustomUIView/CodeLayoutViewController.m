//
//  CodeLayoutViewController.m
//  MyCustomUIView
//
//  Created by ShenYan on 2017/5/5.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import "CodeLayoutViewController.h"
#import "MyCustomView.h"

@interface CodeLayoutViewController ()

@end

@implementation CodeLayoutViewController

-(void)progressTouchEnded:(float)progressPrecent {
    
}
-(void)progressTouchMoved:(float)progressPrecent {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self _drawCircle];
}
- (void)_drawCircle {
    
    
    int x = self.view.frame.size.width * 1 / 8;
    
    
    int width = self.view.frame.size.width * 3 /4;
    int y = (self.view.frame.size.height - width) / 2;
    int height = width;
    
    
    MyCustomView * cvCircle = [[MyCustomView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    //    [cvCircle setProgressPrecent:30];
    [cvCircle setDamp:0.5];
    cvCircle.isCanTouch = true;
    cvCircle.delegate = self;
    
    
    //
    
    //add subview
    [self.view addSubview:cvCircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
