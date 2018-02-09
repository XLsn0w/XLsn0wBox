
#import <UIKit/UIKit.h>
#import "AniTabBarShared.h"

@class AniTabBar;

@protocol AniTabBarDelegate <NSObject>

- (void)tabBar:(AniTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface AniTabBar : UITabBar
/** 代理 */
@property (nonatomic, weak) id<AniTabBarDelegate> ani_delegate;

/** selectedIndex (默认为0) */
@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame
                  norImageArr:(NSArray *)norImageArr
                  SelImageArr:(NSArray *)selImageArr
                     TitleArr:(NSArray *)titleArr
                       Config:(AniTabBarShared *)config;


@end
