
#import <UIKit/UIKit.h>

@interface DragButton : UIView

@property (nonatomic, strong) NSArray *buttons_array;
@property (nonatomic, copy) void(^myBlock)();

@property (nonatomic, assign) CGFloat buttonY;
@property (nonatomic, assign) CGFloat buttonX;

@end
