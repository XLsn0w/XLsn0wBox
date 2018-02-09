//
//  NumberSeparator.m
//  XLsn0wBox
//
//  Created by ginlong on 2018/2/9.
//  Copyright © 2018年 ginlong. All rights reserved.
//

#import "NumberSeparator.h"

@implementation NumberSeparator

+ (NSString *)changeNumberSeparatorWithNum:(NSString *)num {
    NSMutableString *tempNum = num.mutableCopy;
    NSRange range = [num rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length > 0) {///如果存在小数点 index就说小数点的位置
        index = range.location;
    } else {
        index = num.length;///反之index就是输入数字的长度
    }
    
    while ((index - 3) > 0) {
        index -= 3;
        [tempNum insertString:@"." atIndex:index];
    }
    tempNum = [tempNum stringByReplacingOccurrencesOfString:@"." withString:@","].mutableCopy;
    return tempNum;
    
}

// 将数字转为每隔3位整数由逗号“,”分隔的字符串
- (NSString *)separateNumberUseCommaWith:(NSString *)number {
    /// 前缀
    NSString *prefix = @"￥";
    /// 后缀
    NSString *suffix = @"元";
    // 分隔符
    NSString *divide = @",";
    NSString *integer = @"";
    NSString *radixPoint = @"";

    BOOL contains = NO;
    if ([number containsString:@"."]) {
    
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [number componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
        } else {
            integer = number;
            }
    // 将整数按各个字符为一组拆分成数组
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < integer.length; i ++) {
        NSString *subString = [integer substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
        }
    // 将整数数组倒序每隔3个字符添加一个逗号“,”
    NSString *newNumber = @"";
    for (NSInteger i = 0 ; i < integerArray.count ; i ++) {
        NSString *getString = @"";
        NSInteger index = (integerArray.count-1) - i;
        if (integerArray.count > index) {
            getString = [integerArray objectAtIndex:index];
            }
        BOOL result = YES;
        if (index == 0 && integerArray.count%3 == 0) {
            
            result = NO;
            }
        if ((i+1)%3 == 0 && result) {
            newNumber = [NSString stringWithFormat:@"%@%@%@",divide,getString,newNumber];
            } else {
                newNumber = [NSString stringWithFormat:@"%@%@",getString,newNumber];
                }
        }
    if (contains) {
        newNumber = [NSString stringWithFormat:@"%@.%@",newNumber,radixPoint];
        }
    if (![prefix isEqualToString:@""]) {
        newNumber = [NSString stringWithFormat:@"%@%@",prefix,newNumber];
        }
    if (![suffix isEqualToString:@""]) {
        newNumber = [NSString stringWithFormat:@"%@%@",newNumber,suffix];
        }
    return newNumber;
}

@end
