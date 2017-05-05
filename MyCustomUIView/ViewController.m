//
//  ViewController.m
//  MyCustomUIView
//
//  Created by ShenYan on 2017/4/25.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)progressTouchEnded:(float)progressPrecent {
//    NSLog(@"progressTouchEnded: %f", progressPrecent);
}

-(void)progressTouchMoved:(float)progressPrecent {
//    NSLog(@"progressTouchMoved: %f", progressPrecent);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [self _drawCircle];
    
    
}

- (void)_drawCircle {
    

    int x = self.view.frame.size.width * 1 / 8;
    
    
    int width = self.view.frame.size.width * 3 /4;
    int y = (self.view.frame.size.height - width) / 2;
    int height = width;
    

    MyCustomView * cvCircle = [[MyCustomView alloc] initWithFrame:CGRectMake(x, y, width, height)];

    [cvCircle setProgressPrecent:25];
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


@end
