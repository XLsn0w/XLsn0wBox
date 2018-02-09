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

@end
