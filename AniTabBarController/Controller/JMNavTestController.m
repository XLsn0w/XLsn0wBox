
#import "JMNavTestController.h"
#import "ExtensionHeader.h"

@interface JMNavTestController ()

@end

@implementation JMNavTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"超强自定义导航栏";
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JMTabBarBundle" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:@"back" ofType:@"png"];
    [btn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(4, 30, 4, 0);
    btn.imageView.frame = CGRectMake(0, 0, 10, 10);
    btn.frame = CGRectMake(0, 0, 50, 20);
    btn.backgroundColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end



















