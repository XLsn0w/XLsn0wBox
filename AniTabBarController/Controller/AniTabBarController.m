
#import "AniTabBarController.h"

@interface AniTabBarController () <AniTabBarDelegate>

@end

@implementation AniTabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(AniTabBarShared *)config{
    self.viewControllers = controllers;
    self.tabBar = [[AniTabBar alloc] initWithFrame:self.tabBar.frame norImageArr:norImageArr SelImageArr:selImageArr TitleArr:titleArr Config:config];
    self.tabBar.delegate = self;
    
    
    [self setValue:self.tabBar forKeyPath:@"tabBar"];

    
    [AniTabBarShared shared].tabBarController = self;
    
    //KVO
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.tabBar.selectedIndex = selectedIndex;
}

- (void)tabBar:(AniTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
}

- (void)dealloc {
    JMLog(@"被销毁了");
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
