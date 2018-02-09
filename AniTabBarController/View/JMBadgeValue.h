
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMBadgeValueType) {
    JMBadgeValueTypePoint, //点
    JMBadgeValueTypeNew, //new
    JMBadgeValueTypeNumber, //number
};

@interface JMBadgeValue : UIView

@property (nonatomic, strong) UILabel *badgeL;
@property (nonatomic, assign) JMBadgeValueType type;

@end
