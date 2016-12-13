
//-----------------------------------------

#import "UIViewExtend.h"

@implementation UIView (Extend)

/**
 @功能:在视图上添加菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    
    if ( nil != view ) {
        [self removeActivityIndicatorView];
    }
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    aiv.frame = CGRectMake( (self.frame.size.width - ACTIVITYWIDTH) / 2.0,
                           (self.frame.size.height - ACTIVITYHRIGHT) / 2.0,
                           ACTIVITYWIDTH, ACTIVITYHRIGHT);
    aiv.tag = ACTIVITYTAG;
    [aiv startAnimating];
    [self addSubview:aiv];
}

/**
 @功能:删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView
{
    UIView *subView = [self viewWithTag:ACTIVITYTAG];
    [subView removeFromSuperview];
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText
{
    UIView *view = [self viewWithTag:HUDTAG];
    
    if ( nil != view ) {
        [self removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
//    HUD.color = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:174.0f/255.0f alpha:0.8f];
//    HUD.opacity = 0.5f;
    HUD.tag = HUDTAG;
    HUD.labelText = labelText;
    [self addSubview:HUD];
    [HUD show:YES];
}

/**
 @功能:删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView
{
    UIView *subView = [self viewWithTag:HUDTAG];
    [subView removeFromSuperview];
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay
{
    
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDLABELTAG;
//    HUD.color = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:174.0f/255.0f alpha:0.8f];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabelText = labelText;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:isPad ? 18 : 14];
    [self addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}


@end
