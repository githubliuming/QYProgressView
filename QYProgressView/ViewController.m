//
//  ViewController.m
//  QYProgressView
//
//  Created by liuming on 16/8/8.
//  Copyright © 2016年 burning. All rights reserved.
//

#import "ViewController.h"
#import "QYProgressView.h"
@interface ViewController ()

@property(weak, nonatomic) IBOutlet QYProgressView* progressView;
@property(nonatomic, strong) CAShapeLayer* progressLayer;
@property(nonatomic, strong) UIColor* storeColor;
@property(nonatomic, assign) double progressWith;
@property(nonatomic, assign) double progress;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.progressLayer = [[CAShapeLayer alloc] init];
    self.progressLayer.frame = CGRectMake(50, 50, 100, 100);
    self.progressLayer.position = CGPointMake(100, 100);

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
    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.lineWidth = 5;
    self.progressLayer.opacity = 1;
    self.progressLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:self.progressLayer];

    self.progressView.progressWith = 6;
    self.progressView.strokeColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChange:(id)sender
{
    UISlider* silderView = (UISlider*)sender;
    self.progressLayer.strokeEnd = silderView.value;
    self.progressView.progress = silderView.value;
}
@end
