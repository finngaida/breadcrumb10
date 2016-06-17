
@interface UIStatusBarItemView : UIView
+ (id)createViewForItem:(id)arg1 withData:(id)arg2 actions:(int)arg3 foregroundStyle:(id)arg4;
- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4;
@end

@interface UIStatusBarBreadcrumbItemView : UIStatusBarItemView
- (id)_backAppTitle;
- (id)_buttonTitle;
- (id)_collapsedButtonTitle;
- (void)activateBreadcrumb:(id)arg1;
@end

%hook _UIStatusBarSystemNavigationItemButton
- (id)imageRectForContentRect:(id)arg1{
    %log;
    return %orig;
}
%end

%hook UIStatusBarBreadcrumbItemView

+ (id)createViewForItem:(id)arg1 withData:(id)arg2 actions:(int)arg3 foregroundStyle:(id)arg4 {
    %log;
    return %orig;
}

- (id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4 {
    %log;
    return %orig;
}

- (id)_backAppTitle {
    id orig = %orig;
    %log(orig);
    return orig;
}

- (id)_buttonTitle {
    id orig = %orig;
    %log(orig);
    return orig;
}

- (id)_collapsedButtonTitle {
    id orig = %orig;
    %log(orig);
    return orig;
}

- (void)activateBreadcrumb:(id)arg1 {
    %log;
    return %orig;
}

- (id)destinationText{
    %log;
    return %orig;
}
- (id)shortenedTitleWithCompressionLevel:(int)arg1{
    %log;
    return %orig;
}

%end

%hook UIStatusBarSystemNavigationItemView
- (struct CGSize)_buttonSize{
    %log;
    return %orig;
}
%end
