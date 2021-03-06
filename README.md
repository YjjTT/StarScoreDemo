# StarScoreDemo
支持小数和富文本的星星评分,目前不支持点击,只支持显示

## 绘制支持小数的星星

- UIBezierPath绘制图形

```objective-c
UIBezierPath *holePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, grayIV.bounds.size.width*decimal, grayIV.bounds.size.height)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        [maskLayer setFillRule:kCAFillRuleEvenOdd];
        maskLayer.path = holePath.CGPath;
```

## 富文本显示星星

- 使用正则表达式遍历字符串取出`[…]`的字符串

```objective-c
NSString *pattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5\\d*(\\.\\d*)?)[M|G]B]+\\]";
```

- 使用NSRegularExpression遍历字符串将符合规则的字符串加入数组中

```objective-c
NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [regular matchesInString:attr.string options:NSMatchingReportProgress range:NSMakeRange(0, attr.string.length)];
```

- NSTextCheckingResult遍历数组, 如果字符串可以直接转换成图片,则直接转换,不需要绘制,否则则转换成float浮点数绘制小星星

```objective-c
for (NSTextCheckingResult *result in arr) {
        NSString *matchstring = [attr.string substringWithRange:result.range];
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        if ([[EMOJI allKeys] containsObject:matchstring]) {
            attachment.image = [UIImage imageNamed:EMOJI[matchstring]];
            attachment.bounds = CGRectMake(0, -2.0, 16.0, 16.0);
            [imageArr insertObject:attachment atIndex:0];
            [rangeArr insertObject:result atIndex:0];
        }else{
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
```

- 替换表情富文本

```objective-c
 for (NSTextCheckingResult *result in rangeArr) {
        NSTextAttachment *attchment = imageArr[i];
        [attr replaceCharactersInRange:result.range withAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
    }
```

## 最后的效果

![绘制小星星](https://github.com/YjjTT/ImageFile/raw/master/img/20180913173405.png)

![富文本](https://github.com/YjjTT/ImageFile/raw/master/img/20180913173347.png)

------

## 小结

喜欢的给个star,感谢!





