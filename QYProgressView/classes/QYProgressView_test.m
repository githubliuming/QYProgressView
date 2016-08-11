//
//  QYProgressView.m
//  QYProgressView
//
//  Created by liuming on 16/8/8.
//  Copyright © 2016年 burning. All rights reserved.
//

#import "QYProgressView_test.h"
@interface QYProgressView_test ()

@property(nonatomic, strong) CAShapeLayer *cycleLayer;
@end
@implementation QYProgressView_test

- (void)drawRect:(CGRect)rect { [self repaintedCycleLayer]; }
- (void)repaintedCycleLayer
{
    CGPoint center = CGPointMake((CGRectGetMidX(self.frame) + CGRectGetWidth(self.frame)) / 2.0,
                                 (CGRectGetMidY(self.frame) + CGRectGetHeight(self.frame)) / 2.0);
    CGFloat radius = 90;
    CGFloat startA = -M_PI_2;                       //设置进度条起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //设置进度条终点位置

    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _cycleLayer = [CAShapeLayer layer];  //创建一个track shape layer
    _cycleLayer.frame = self.bounds;
    _cycleLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _cycleLayer.strokeColor = [[UIColor redColor] CGColor];  //指定path的渲染颜色,这里可以设置任意不透明颜色
    _cycleLayer.opacity = 1;                                 //背景颜色的透明度
    _cycleLayer.lineCap = kCALineCapRound;                   //指定线的边缘是圆的
    _cycleLayer.lineWidth = 10;                              //线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startA
                                                      endAngle:endA
                                                     clockwise:YES];  //上面说明过了用来构建圆形
    _cycleLayer.path = [path CGPath];  //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_cycleLayer];
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];

    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);  // 分段设置渐变色
    leftLayer.locations = @[ @0.3, @0.9, @1 ];
    leftLayer.colors = @[ (id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor ];
    [gradientLayer addSublayer:leftLayer];

    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[ @0.3, @0.9, @1 ];
    rightLayer.colors = @[ (id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor ];
    [gradientLayer addSublayer:rightLayer];

    [gradientLayer setMask:_cycleLayer];  //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
}

- (void)setProgress:(double)progress
{
    _progress = progress;
    _cycleLayer.opaque = 0;
    [self setNeedsLayout];
}
@end
