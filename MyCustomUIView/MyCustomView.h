//
//  MyCustomView.h
//  MyCustomUIView
//
//  Created by ShenYan on 2017/4/25.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressUPdateProtocol.h"


@interface MyCustomView : UIView
{
    
}
//0-100
//@property (nonatomic, assign) float progress;

@property (nonatomic) Boolean isCanTouch;

-(void)setProgressPrecent:(float) progress;
-(void)setProgerssBarWidth: (float) width;
-(void)setDamp: (float) damp;

@property (nonatomic, weak) id<ProgressUpdateProtocol> delegate;
@end



