
#import "DragButton.h"
#import "UIView+VIewFrame.h"

#define Radius  150
#define Padding Radius-50
/*屏幕的宽度*/
#define kWJScreenWidth [UIScreen mainScreen].bounds.size.width
/*屏幕的高度*/
#define kWJScreenHeight  [UIScreen mainScreen].bounds.size.height
/**
 *   RGB颜色WJ
 */
#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**
 *   随机色
 */
#define WJRandomColor WJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation DragButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setButtons_array:(NSArray *)buttons_array
{
    _buttons_array = buttons_array;
    
    CGFloat Angle = M_PI/2/(buttons_array.count-1);
    
    for (NSInteger index = 0; index < buttons_array.count; index++) {
        //            NSLog(@"x/lf   %lf",M_PI,Angle);
        UIButton *button = [[UIButton alloc]init];
        button.size = CGSizeMake(50, 50);
        button.backgroundColor = WJRandomColor;
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%zd",index]] forState:0];
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
//        button.backgroundColor = [UIColor blackColor];
        
        // 创建个帧动画的对象
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        animation.values = [self getAnimationValusWithButton:button andNSInteger:index andRaduis:Angle];
        animation.duration = 1.0;

        CAKeyframeAnimation *animatetionSalse = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animatetionSalse.duration = 1.0;
        animatetionSalse.values = @[@0.0,@0.2,@0.4,@0.6,@0.8,@1.0];
        
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        basicAnimation.duration = 1.0;
        basicAnimation.toValue = [NSNumber numberWithFloat:4 * M_PI];
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
        group.animations = @[animatetionSalse,animation,basicAnimation];
        group.duration = 1.0;
        group.removedOnCompletion = NO;
        [button.layer addAnimation:group forKey:nil];
        
        
    }
}
-(NSArray *)getAnimationValusWithButton:(UIButton *)button andNSInteger:(NSInteger)index andRaduis:(CGFloat)Angle

{
    CGPoint one ;
    CGPoint two;
    if (self.buttonY < 0.4*kWJScreenHeight) {
        button.x = cosf(index*Angle)*Radius;
        button.y = sin(index*Angle)*Radius;
        NSLog(@"%lf %lf",cosf(index*Angle),Angle);
        one= CGPointMake(0, 0);
        two = CGPointMake(cosf(index*Angle)*Radius+25, sin(index*Angle)*Radius+25);
    }else{
        button.x = cosf(-index*Angle)*Radius;
        button.y = sin(-index*Angle)*Radius+Padding;
        one = CGPointMake(0, Radius);
        two = CGPointMake(cosf(-index*Angle)*Radius+25, sin(-index*Angle)*Radius+Padding+25);
    }
    if (self.buttonX != 10) {
        button.x = cosf(M_PI/2+ index*Angle)*Radius+Padding;
        button.y = sin(M_PI/2+index*Angle)*Radius;
        one = CGPointMake(Radius, 0);
        two = CGPointMake(cosf(M_PI/2+ index*Angle)*Radius+25+Padding, sin(M_PI/2+index*Angle)*Radius+25);
        if (self.buttonY >= 0.4*kWJScreenHeight) {
            button.x = cosf(M_PI+ index*Angle)*Radius+Padding;
            button.y = sin(M_PI+index*Angle)*Radius+Padding;
            one = CGPointMake(Radius, Radius);
            two = CGPointMake(cosf(M_PI+ index*Angle)*Radius+25+Padding, sin(M_PI+index*Angle)*Radius+25+Padding);
        }
    }
    
    NSValue *oneValue = [NSValue valueWithCGPoint:one];
    NSValue *twoValue = [NSValue valueWithCGPoint:two];
    return @[oneValue,twoValue];
}
-(void)setMyBlock:(void (^)())myBlock
{
    _myBlock = myBlock;
    CGFloat Angle = M_PI/2/(self.buttons_array.count-1);
    for (NSInteger index = 0;index < self.subviews.count;index++ ) {
        UIButton *button = self.subviews[index];
        // 创建个帧动画的对象
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        NSArray *array =[self getAnimationValusWithButton:button andNSInteger:index andRaduis:Angle];
        animation.values = @[array.lastObject,array.firstObject];
        animation.duration = 1.0;
        
        CAKeyframeAnimation *animatetionSalse = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animatetionSalse.duration = 1.0;
        animatetionSalse.values = @[@1.0,@0.8,@0.6,@0.4,@0.2,@0.0];
        
        
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        basicAnimation.duration = 1.0;
        basicAnimation.toValue = [NSNumber numberWithFloat:4 * M_PI];
        
        CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
        group.animations = @[animatetionSalse,animation,basicAnimation];
        group.duration = 1.0;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        [button.layer addAnimation:group forKey:nil];
    }
}
@end
