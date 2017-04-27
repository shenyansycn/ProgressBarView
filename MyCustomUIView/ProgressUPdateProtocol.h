//
//  ProgressUPdateProtocol.h
//  MyCustomUIView
//
//  Created by ShenYan on 2017/4/27.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgressUpdateProtocol <NSObject>

@required
-(void)progressUpdate:(float) progressPrecent;

@end
