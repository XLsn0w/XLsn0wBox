///Animation TabBarController

#import <UIKit/UIKit.h>
#import "AniTabBarShared.h"
#import "AniTabBar.h"

@interface AniTabBarController : UITabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(AniTabBarShared *)config;

/** tabBar */
@property (nonatomic, strong) AniTabBar *tabBar;

@end
