//
//  TurnViewToImage.m
//  test
//
//  Created by YjjTT on 2018/9/13.
//  Copyright © 2018年 YjjTT. All rights reserved.
//

#import "TurnViewToImage.h"

@implementation TurnViewToImage

+ (UIImage *)turnToImageByScore:(CGFloat)score{
    @autoreleasepool {
        CGFloat decimal = score - floor(score);
        NSLog(@"%@---%@", @(score), @(decimal));//会有精度问题,但不影响
        TurnViewToImage *grayIV = [[TurnViewToImage alloc] initWithImage:[UIImage imageNamed:@"emptyStar"]];
        grayIV.frame = CGRectMake(0, 0, 100, 100);
        UIImageView *yellowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fillStar"]];
        yellowIV.frame = grayIV.bounds;
        UIBezierPath *holePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, grayIV.bounds.size.width*decimal, grayIV.bounds.size.height)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        [maskLayer setFillRule:kCAFillRuleEvenOdd];
        maskLayer.path = holePath.CGPath;
        [yellowIV.layer setMask:maskLayer];
        [grayIV addSubview:yellowIV];
        UIGraphicsBeginImageContextWithOptions(grayIV.bounds.size, NO, 0.0);
        [grayIV.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}



@end
