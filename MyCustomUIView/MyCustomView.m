//
//  MyCustomView.m
//  MyCustomUIView
//
//  Created by ShenYan on 2017/4/25.
//  Copyright © 2017年 China.com. All rights reserved.
//

#import "MyCustomView.h"
#import <math.h>

#define PI M_PI //圆周率常量
#define RADIAN 180/M_PI

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]

@interface MyCustomView ()
{
    CGFloat angleY;
    float downX;
    float downY;
    float downAngle;
    float preAngle;//角度
    float angle;//角度
    Boolean move;
    Boolean isShowIndicateBar;
    Boolean touchDown;
    Boolean drawindicateBar;
    NSTimer *timer;
    
    float scrollDamp;
    
    float preProgressBarRadianY;
}


////圆圈或弧线的边线的颜色，默认为黑色
@property (nonatomic,strong) UIColor* progressBarColor;

@property (nonatomic, strong) UIColor *progressBarBackgroundColor;
//手指指示器移动时候的颜色
@property (nonatomic,strong) UIColor* indicateBarSelectColor;
//
@property (nonatomic,strong) UIColor* indicateBarNormalColor;

@property (nonatomic,strong) UIColor* indicateBarBackgroundColor;

@property(nonatomic,strong) UIColor *middleCircleColor;

//
////线的宽度,默认为1.0
@property (nonatomic,assign) CGFloat myLineWidth;

////圆圈或弧线的圆周中心点坐标，默认为当前视图的中心点，即(self.frame.size.width/2,self.frame.size.height/2)
@property (nonatomic,assign) CGPoint myDot;

//圆圈或弧线的半径，默认采用当前视图尺寸（self.frame.size）来计算半径
//计算规则：
//如果 self.frame.size.width > self.frame.size.height ，
//那么 半径＝self.frame.size.height/2
//否则 半径＝self.frame.size.width/2
//也就是取高、宽中值小的那个的1/2作为半径
@property (nonatomic,assign) CGFloat progressBarRadius;
@property (nonatomic,assign) CGFloat indicateBarRadius;

//圆圈或弧线的范围，用弧度来计算，圆一周总弧度为2*PI(即360度角)。默认值为（0,2*PI）
//angle.x ：弧线起点的弧度
//angle.y ：弧线终点的弧度
//
//
//               ^ 1.5*PI弧度
//               ｜
//               ｜
//               ｜
//               ｜
//               ｜
// 1*PI弧度       ｜
// -------------------------------->0弧度(2*PI弧度)
//               ｜
//               ｜
//               ｜
//               ｜
//               ｜
//               ｜0.5*PI弧度
//
//
//
//
@property (nonatomic,assign) CGPoint progressBarRadian;
@property (nonatomic,assign) CGPoint indicateBarRadian;

//画弧线方向，为0表示顺时针，为1表示逆时针，默认值为0.
//方向不同，画出的弧线也会不同，例如：
//假设 参数myAngle定义为(0 , 0.5*PI)
//如果 参数myClockWise=0，即将从上图中0弧度开始，沿顺时针方向画弧线到0.5*PI弧度位置，即画了一条90度角的弧线
//如果 参数myClockWise=1，即将从上图中0弧度开始，沿逆时针方向经过1.5*PI弧度、1*PI弧度，然后一直画弧线到0.5*PI弧度位置，相当于画了一条270度角的弧线
@property (nonatomic,assign) int myClockWise;

@end


@implementation MyCustomView

-(void)setDamp:(float)damp {
    if (damp < 0) {
        damp = 0;
    }
    if (damp > 1) {
        damp = 1;
    }
    scrollDamp = damp;
}

-(void)setProgressPrecent:(float)progress {
    if (progress > 100.0f) {
        progress = 100.0f;
    }
    if (progress < 0.0f) {
        progress = 0.0f;
    }
    _progressBarRadian.y += (progress / 100 * 360.0f) * PI / 180.0f;
    
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesBegan");
    [timer invalidate];
    angleY = 0.0f;
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    downX = point.x;
    downY = point.y;
    isShowIndicateBar = true;
    float x = point.x;
    float y = point.y;
    [self getDownAngleX:x Y:y];
    touchDown = true;
    drawindicateBar = true;
    [self setNeedsDisplay];
    
    
}
-(void)getDownAngleX: (float) x Y:(float) y {
    float cos = [self computeCosX:x Y:y];
    if (x < self.frame.size.width / 2.0f) {
        downAngle = M_PI * RADIAN + acos(cos) * RADIAN;
    } else {
        downAngle = M_PI * RADIAN - acos(cos) * RADIAN;
    }
    
    preAngle = downAngle;
    
}
-(float)computeCosX: (float) x Y:(float) y{
    float width = x - self.frame.size.width / 2.0f;
    float height = y - self.frame.size.height / 2.0f;
    float slope = sqrt(width * width + height * height);
    return height / slope;
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    float x1 = point.x;
    float y1 = point.y;
    [self getAngleX:x1 Y:y1];
    [self sendProgressTouchMoved];
    [self setNeedsDisplay];
    
}

-(void)getAngleX: (float) x Y:(float) y {
    float cos = [self computeCosX:x Y:y];
    if (x < self.frame.size.width / 2.0f) {
        angle = M_PI * RADIAN + acos(cos) * RADIAN;
    } else {
        angle = M_PI * RADIAN - acos(cos) * RADIAN;
    }
    if (fabsf(preAngle - angle) > 200.0f) {
        preAngle = angle;
        return;
    }
    
    
    [self process];
    
    preAngle = angle;
}


-(void) process {
    
    //角度计算
    float ix = angle - 35.0f;
    float newIX = (ix < 0)?360.0f-fabsf(ix):ix;
    
    float indicateAngleX = newIX;
    
    float iy =angle + 35.0f;
    float newIY = iy > 360.0f?iy - 360.0f:iy;
    float indicateAngleY = newIY;
    
    
    _indicateBarRadian.x = (indicateAngleX / 180.0f + 1.5f) * PI;
    _indicateBarRadian.y = (indicateAngleY / 180.0f + 1.5f) * PI;
    
    
    float tmpAngle = (angle - preAngle) * scrollDamp;
    
    _progressBarRadian.y += (tmpAngle) / 180.0f * PI ;
    
    if (_progressBarRadian.y < (-90.0f/180.0f*PI) ){
        _progressBarRadian.y =(-90.0f/180.0f*PI) ;
    }
    if (_progressBarRadian.y > 270.0f / 180.0f * PI){
        _progressBarRadian.y = 269.99f / 180.0f * PI;
    }
    if (isnan(_progressBarRadian.y)){
        NSLog(@"angle y is nan");
        _progressBarRadian.y = preProgressBarRadianY;
    } else {
        preProgressBarRadianY = _progressBarRadian.y;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesEnded");
    
    isShowIndicateBar = false;
    
    touchDown = false;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
    
    
    [self sendProgressTouchEnded];
    [self setNeedsDisplay];
    
}

-(void)sendProgressTouchEnded{
    if ([self.delegate respondsToSelector:@selector(progressTouchEnded:)]) {
        float progressPrecent = (_progressBarRadian.y * 180.0f / PI + 90.0f);
        if (progressPrecent > 359.8f){
            progressPrecent = 360.0f;
        }
        [self.delegate progressTouchEnded:progressPrecent / 360.0f *100.0f];
    }

}
-(void)sendProgressTouchMoved{
    if ([self.delegate respondsToSelector:@selector(progressTouchMoved:)]) {
        float progressPrecent = (_progressBarRadian.y * 180.0f / PI + 90.0f);
        if (progressPrecent > 359.8f){
            progressPrecent = 360.0f;
        }
        [self.delegate progressTouchMoved:progressPrecent / 360.0f *100.0f];
    }
    
}

-(void)delayMethod{
//    NSLog(@"delayMethodEnd");
    drawindicateBar = false;
    [self setNeedsDisplay];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesCancelled");
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    NSLog(@"motionBegan");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    NSLog(@"motionEnded");
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    NSLog(@"motionCancelled");
}
#pragma mark --------------->系统方法区<---------------
-(instancetype)init{
    self=[super init];
    if(self){
        
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    //圆心坐标点
    _myDot.x =self.frame.size.width/2.0f;
    _myDot.y =self.frame.size.height/2.0f;
    //线宽
    _myLineWidth=13;
    
    //圆半径
    _progressBarRadius=(self.frame.size.width>self.frame.size.height)?(self.frame.size.height/2.0f-10.0f):(self.frame.size.width/2.0f-10.0f);
    _indicateBarRadius=_progressBarRadius - _myLineWidth * 3.0f / 2.0f;
    //弧度
    _progressBarRadian.y=-0.5f * PI;
    //方向
    _myClockWise=0;
    _progressBarColor = UIColorFromRGB(0x01afef);
    
    _progressBarBackgroundColor = UIColorFromRGB(0x666666);
    
    _indicateBarSelectColor = UIColorFromRGB(0xcccccc);
    
    _indicateBarBackgroundColor = UIColorFromRGB(0x4f4f4f);
    
    _middleCircleColor = UIColorFromRGB(0x565959);
    
    self.backgroundColor = UIColorFromRGB(0x5a5d5d);
    
    scrollDamp = 0.5f;

    
    return self;
    
}


-(void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    //画背景
    CGContextSetFillColorWithColor(context, _indicateBarBackgroundColor.CGColor);
    //    CGContextSetStrokeColorWithColor(context, _indicateBarBackgroundColor.CGColor);
    CGContextAddArc(context, _myDot.x, _myDot.y, _progressBarRadius, 0, 2.0f * PI, _myClockWise);
    CGContextDrawPath(context, kCGPathFill);
    
    
    if (touchDown){
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        //    CGContextSetStrokeColorWithColor(context, _indicateBarBackgroundColor.CGColor);
        CGContextAddArc(context, _myDot.x, _myDot.y, _progressBarRadius - _myLineWidth * 3.0f + _myLineWidth / 2.0f, 0, 2.0f * PI, _myClockWise);
        CGContextDrawPath(context, kCGPathFill);
    }
    
    CGContextSetStrokeColorWithColor(context, _progressBarBackgroundColor.CGColor);
    CGContextSetLineWidth(context, _myLineWidth);//线的宽度
    CGContextAddArc(context, _myDot.x, _myDot.y, _progressBarRadius, 0, 2.0f * PI, _myClockWise);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    //画弧线
    CGContextSetStrokeColorWithColor(context, _progressBarColor.CGColor);
    CGContextSetLineWidth(context, _myLineWidth);//线的宽度
    CGContextAddArc(context, _myDot.x, _myDot.y, _progressBarRadius, -0.5f * PI, _progressBarRadian.y, _myClockWise);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    
    //    CGContextSetStrokeColorWithColor(context, _indicateBarBackgroundColor.CGColor);
    //    CGContextSetLineWidth(context, _myLineWidth * 2);//线的宽度
    //    CGContextAddArc(context, _myDot.x, _myDot.y, _indicateBarRadius, 0 * PI, 2 * PI, _myClockWise);
    //    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    if (drawindicateBar) {
        if (touchDown){
            CGContextSetStrokeColorWithColor(context, _indicateBarSelectColor.CGColor);
        } else {
            CGContextSetStrokeColorWithColor(context, _progressBarBackgroundColor.CGColor);
        }
        CGContextSetLineWidth(context, _myLineWidth * 2.0f);//线的宽度
        CGContextAddArc(context, _myDot.x, _myDot.y, _indicateBarRadius, _indicateBarRadian.x, _indicateBarRadian.y, _myClockWise);
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
    }
    
    //    CGContextSetStrokeColorWithColor(context, _middleCircleColor.CGColor);
    //    CGContextAddArc(context, _myDot.x, _myDot.y, _progressBarRadius - _myLineWidth, 0, 2 * PI, _myClockWise);
    //    CGContextDrawPath(context, kCGPathFill);
    //    
}



@end
