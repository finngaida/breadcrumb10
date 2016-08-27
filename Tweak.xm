
@interface UIStatusBarItemView : UIView
+ (id)createViewForItem:(id)arg1 withData:(id)arg2 actions:(int)arg3 foregroundStyle:(id)arg4;
- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4;
- (void)setVisible:(BOOL)arg1;
- (void)setVisible:(BOOL)arg1 frame:(id)arg2 duration:(double)arg3;
@end

@interface UIStatusBarBreadcrumbItemView : UIStatusBarItemView
//- (void)longPress:(UILongPressGestureRecognizer *)press;
@end

@interface UIStatusBarDataNetworkItemView : UIStatusBarItemView
@property (getter=isVisible, nonatomic) BOOL visible;
@end

@interface UIStatusBarForegroundView : UIView
@end

@interface UIStatusBarServer : NSObject
+ (void)removeStatusBarItem:(int)arg1;
@end

NSTimer *timer;

%hook UIStatusBarBreadcrumbItemView

- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4 {
    id orig = %orig;
    UIButton *button = MSHookIvar<UIButton *>(orig, "_button");
    UIImage *img = [UIImage imageWithContentsOfFile:@"/Library/breadcrumb10/left@2x.png"];
    [button setImage:img forState:UIControlStateNormal];
    
    //[orig addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    return orig;
}

//%new
//- (void)longPress:(UILongPressGestureRecognizer *)press {
    //if (press.state == UIGestureRecognizerStateEnded) {
        //[UIStatusBarServer removeStatusBarItem:0];
    //}
//}

- (id)shortenedTitleWithCompressionLevel:(int)arg1 {
    id orig = %orig;
    
    NSMutableString *name = [NSMutableString new];
    NSArray *components = [orig componentsSeparatedByString:@" "];
    
    if (components.count > 2) {
        for (int i = 2; i < components.count; i++) {
            [name appendFormat:@" %@", components[i]];
        }
    }

    return name;
}

%end

%hook UIStatusBarForegroundView

- (void)layoutSubviews {
    %orig;
    
    for (UIView *w in self.subviews) {
        if ([w class] == NSClassFromString(@"UIStatusBarBreadcrumbItemView")) {
            for (UIView *v in self.subviews) {
                if ([v class] == NSClassFromString(@"UIStatusBarDataNetworkItemView")) {
                    UIStatusBarDataNetworkItemView *item = (UIStatusBarDataNetworkItemView *)v;
                    item.alpha = 1.0;
                    item.frame = CGRectMake(w.frame.origin.x + w.frame.size.width + 5, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
                } else if ([v class] == NSClassFromString(@"UIStatusBarSignalStrengthItemView")) {
                    [v removeFromSuperview];
                }
            }
        }
    }

}

%end
