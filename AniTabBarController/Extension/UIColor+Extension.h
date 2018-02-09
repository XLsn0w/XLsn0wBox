
#import <UIKit/UIKit.h>

@interface UIColor (Extension)

//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color
                          Alpha:(CGFloat)alpha;

@end
