//
//  main.m
//  XLsn0wBox
//
//  Created by ginlong on 2018/2/9.
//  Copyright © 2018年 ginlong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// 设置一个C函数，用来接收崩溃信息
//void UncaughtExceptionHandler(NSException *exception);
void UncaughtExceptionHandler(NSException *exception) {
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithContentsOfFile:[caches stringByAppendingPathComponent:@"zplan_crash.plist"]];
    
    if (!dictM) {
        dictM = [NSMutableDictionary dictionary];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *timestampInfo = @{[timestamp stringByAppendingString:@"name"] : name,
                                    [timestamp stringByAppendingString:@"_reason"] : reason,
                                    [timestamp stringByAppendingString:@"__symbols"] : symbols
                                    };
    NSDictionary *dict = @{timestamp : timestampInfo};
    
    [dictM setValuesForKeysWithDictionary:dict];
    [dictM writeToFile:[caches stringByAppendingPathComponent:@"zplan_crash.plist"] atomically:YES];
    
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } @catch (NSException *exception) {
            UncaughtExceptionHandler(exception);
        } @finally {
            //Code that gets executed whether or not an exception is thrown
        }
    }
}
