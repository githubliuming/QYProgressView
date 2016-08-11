//
//  QYProgressView.h
//  QYProgressView
//
//  Created by liuming on 16/8/8.
//  Copyright © 2016年 burning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYProgressView : UIView

/**
 *  进度
 */
@property(nonatomic, assign) double progress;
/**
 *  环形进度条内部填充色
 */
@property(nonatomic, strong) UIColor* fillColor;
/**
 *  进度条颜色
 */
@property(nonatomic, strong) UIColor* strokeColor;
/**
 *  进度条宽度
 */
@property(nonatomic, assign) double progressWith;

@end
