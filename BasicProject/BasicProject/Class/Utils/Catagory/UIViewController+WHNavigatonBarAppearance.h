//
//  UIViewController+WHNavigatonBarAppearance.h
//  WasteHouse
//
//  Created by snowlu on 2018/5/19.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WHNavigatonBarAppearance)


/**
 *  push 方法
 *
 *  @param viewControllerClass
 */
- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass ;

/**
 
 */
- (void)addPopBackBarButtonItem;

-(void)popBack;

/**
 

 @param title <#title description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)backBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 

 @param title <#title description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)leftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 

 @param image <#image description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

/**
 

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

/**
 

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param font <#font description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;


/**
 

 @param image <#image description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

/**
 

 @param view <#view description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonWithView:(UIView *)view;


/**
 

 @param title <#title description#>
 @return <#return value description#>
 */
- (UILabel *)navTitleLabelWithTitle:(NSString *)title;


/**
 

 @param image <#image description#>
 @param selectedImage <#selectedImage description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action;


/**
 

 @param image <#image description#>
 @param selectedImage <#selectedImage description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action;

@end
