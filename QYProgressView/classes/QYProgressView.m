//
//  QYProgressView.m
//  QYProgressView
//
//  Created by liuming on 16/8/8.
//  Copyright © 2016年 burning. All rights reserved.
//

#import "QYProgressView.h"

@interface QYProgressView ()

@property(nonatomic, strong) CAShapeLayer* progressLayer;
@end

@implementation QYProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initProgressLayer];
    }
    return self;
}

- (void)awakeFromNib { [self initProgressLayer]; }
- (void)initConfig
{
    if (self.fillColor == nil)
    {
        self.fillColor = [UIColor clearColor];
    }

    if (self.strokeColor == nil)
    {
        self.strokeColor = [UIColor greenColor];
    }

    if (self.progressWith <= 0)
    {
        self.progressWith = 2;
    }
}
- (void)initProgressLayer
{
    [self initConfig];
    self.progressLayer = [[CAShapeLayer alloc] init];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.position = CGPointMake(0, 0);
    double startAngle = -M_PI_2;
    double endAngle = -M_PI_2 + M_PI * 2;
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100)
                                                              radius:50
                                                          startAngle:startAngle
                                                            endAngle:endAngle
                                                           clockwise:YES];
    self.progressLayer.path = [bezierPath CGPath];

    self.progressLayer.strokeStart = 0;
    self.progressLayer.strokeEnd = 0;
    self.progressLayer.strokeColor = self.strokeColor.CGColor;
    self.progressLayer.fillColor = self.fillColor.CGColor;
    self.progressLayer.lineWidth = self.progressWith;
    self.progressLayer.opacity = 1;
    self.progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.progressLayer];
}

- (void)setProgress:(double)progress
{
    progress = MAX(0, progress);
    progress = MIN(1, progress);
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressLayer.strokeEnd = self.progress;
    self.progressLayer.strokeColor = self.strokeColor.CGColor;
    self.progressLayer.fillColor = self.fillColor.CGColor;
    self.progressLayer.lineWidth = self.progressWith;
}
@end
