//
//  Tool.m
//  test
//
//  Created by YjjTT on 2018/9/13.
//  Copyright © 2018年 YjjTT. All rights reserved.
//

#import "Tool.h"
#import <UIKit/UIKit.h>
#import "TurnViewToImage.h"

#define EMOJI     @{@"[黄星]":@"fillStar",@"[灰星]":@"emptyStar"}

@implementation Tool
+ (NSMutableAttributedString *)replaceStringToAttributedString:(NSString *)replaceString{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:replaceString attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:16.0f],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //使用正则表达式遍历字符串取出格式为 "[...]" 的字符串
    NSString *pattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5\\d*(\\.\\d*)?)[M|G]B]+\\]";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [regular matchesInString:attr.string options:NSMatchingReportProgress range:NSMakeRange(0, attr.string.length)];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:0];
    for (NSTextCheckingResult *result in arr) {
        NSString *matchstring = [attr.string substringWithRange:result.range];
        //将遍历出来的表情文字转化为表情富文本
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        if ([[EMOJI allKeys] containsObject:matchstring]) {
            attachment.image = [UIImage imageNamed:EMOJI[matchstring]];
            //设置表情图片大小
            attachment.bounds = CGRectMake(0, -2.0, 16.0, 16.0);
            [imageArr insertObject:attachment atIndex:0];
            [rangeArr insertObject:result atIndex:0];
        }else{
            // 绘制星星 性能太低 有待调整
            NSRange startRange = [matchstring rangeOfString:@"["];
            NSRange endRange = [matchstring rangeOfString:@"]"];
            NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
            NSString *resultStr = [matchstring substringWithRange:range];
            float degree = [resultStr floatValue];
            UIImage *image = [TurnViewToImage turnToImageByScore:degree];
            attachment.image = image;
            attachment.bounds = CGRectMake(0, -2.0, 16.0, 16.0);
            [imageArr insertObject:attachment atIndex:0];
            [rangeArr insertObject:result atIndex:0];
        }
    }
    int i = 0;
    //替换表情富文本
    for (NSTextCheckingResult *result in rangeArr) {
        NSTextAttachment *attchment = imageArr[i];
        [attr replaceCharactersInRange:result.range withAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
        i++;
    }
    return attr;
}
@end
