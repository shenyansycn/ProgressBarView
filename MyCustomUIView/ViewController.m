//
//  ViewController.m
//  MyCustomUIView
//
//  Created by ShenYan on 2017/4/25.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomView.h"
#import "CodeLayoutViewController.h"
#import "XibLayoutViewController.h"


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
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)codeLayoutBtnClick:(UIButton *)sender {
    CodeLayoutViewController *vc = [[CodeLayoutViewController alloc] initWithNibName:@"CodeLayoutViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)xibLayoutBtnClick:(UIButton *)sender {
    XibLayoutViewController *vc = [[XibLayoutViewController alloc] initWithNibName:@"XibLayoutViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
