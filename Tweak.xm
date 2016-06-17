
@interface UIStatusBarItemView : UIView
+ (id)createViewForItem:(id)arg1 withData:(id)arg2 actions:(int)arg3 foregroundStyle:(id)arg4;
- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4;
- (void)setVisible:(BOOL)arg1;
- (void)setVisible:(BOOL)arg1 frame:(id)arg2 duration:(double)arg3;
@end

@interface UIStatusBarBreadcrumbItemView : UIStatusBarItemView
- (void)showSignalItem;
@end

@interface UIStatusBarDataNetworkItemView : UIStatusBarItemView
@property (getter=isVisible, nonatomic) BOOL visible;
@end

%hook UIStatusBarBreadcrumbItemView

- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4 {
    id orig = %orig;
    UIButton *button = MSHookIvar<UIButton *>(orig, "_button");
    UIImage *img = [UIImage imageWithContentsOfFile:@"/Library/breadcrumb10/left@2x.png"];
    [button setImage:img forState:UIControlStateNormal];
    [self showSignalItem];
    return orig;
}

- (id)shortenedTitleWithCompressionLevel:(int)arg1 {
    id orig = %orig;
    [self showSignalItem];
    
    NSArray *comps = [orig componentsSeparatedByString:@" "];
    if (comps.count > 2) {
        return comps[2];
    }
    
    return orig;
}

%new
- (void)showSignalItem {
    NSArray *siblings = self.superview.subviews;
    for (UIView *v in siblings) {
        if ([v class] == NSClassFromString(@"UIStatusBarDataNetworkItemView")) {
            UIStatusBarDataNetworkItemView *item = (UIStatusBarDataNetworkItemView *)v;
//            item.alpha = 1.0;
//            item.visible = YES;
            item.frame = CGRectMake(self.frame.origin.x + self.frame.size.width + 5, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
        }
    }
}

%end

%hook UIStatusBarDataNetworkItemView

- (void)setVisible:(BOOL)arg1 {
    %orig(YES);
}

%end
