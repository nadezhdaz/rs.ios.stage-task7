//
//  UIButton+BackgroundColor.h
//  AuthorizationScreen
//
//  Created by Надежда Зенкова on 04.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BackgroundColor)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
