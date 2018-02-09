
#import "AniTabBarShared.h"

#import "AniTabBarController.h"
#import "JMTabBarButton.h"
#import "ExtensionHeader.h"

@implementation AniTabBarShared

static AniTabBarShared *share = nil;
+ (instancetype)shared {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        share = [[self alloc] init] ;
    }) ;
    return share ;
}

- (instancetype)init {
    if ([super init]) {
        [self configNormal];
    }
    return self;
}

- (void)configNormal {
    _norTitleColor = [UIColor colorWithHexString:@"#808080"];
    _selTitleColor = [UIColor colorWithHexString:@"#d81e06"];
    _isClearTabBarTopLine = YES;
    _tabBarTopLineColor = [UIColor lightGrayColor];
    _tabBarBackground = [UIColor whiteColor];
    _typeLayout = JMConfigTypeLayoutNormal;
    _imageSize = CGSizeMake(28, 28);
    _badgeTextColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _badgeBackgroundColor = [UIColor colorWithHexString:@"#FF4040"];
    _titleFont = 12.f;
    _titleOffset = 2.f;
    _imageOffset = 2.f;
}

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (JMTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (JMTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.x += badgeOffset.x;
        btn.badgeValue.badgeL.y += badgeOffset.y;
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (JMTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.textColor = badgeTextColor;
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (JMTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.backgroundColor = badgeBackgroundColor;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (JMTabBarButton *btn in arrM) {
        btn.badgeValue.badgeL.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius AtIndex:(NSInteger)index {
    JMTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index{
    JMTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = JMBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index {
    JMTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = @"new";
    tabBarButton.badgeValue.type = JMBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index {
    JMTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.badgeL.text = badgeValue;
    tabBarButton.badgeValue.type = JMBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    [self getTabBarButtonAtIndex:index].badgeValue.hidden = YES;
}

- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(JMConfigCustomBtnBlock)btnClickBlock {    
    btn.tag = index;
    [btn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnClickBlock = btnClickBlock;
    [self.tabBarController.tabBar addSubview:btn];
}

- (void)customBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(sender, sender.tag);
    }
}

- (JMTabBarButton *)getTabBarButtonAtIndex:(NSInteger)index {
    NSArray *subViews = self.tabBarController.tabBar.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[JMTabBarButton class]] && i == index) {
            JMTabBarButton *tabBarBtn = (JMTabBarButton *)tabBarButton;
            return tabBarBtn;
        }
    }
    return nil;
}

- (NSMutableArray *)getTabBarButtons {
    NSArray *subViews = self.tabBarController.tabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[JMTabBarButton class]]) {
            JMTabBarButton *tabBarBtn = (JMTabBarButton *)tabBarButton;
            [tempArr addObject:tabBarBtn];
        }
    }
    return tempArr;
}

@end
