//
//  RefreshAlertViewController.h
//  AuthorizationScreen
//
//  Created by Надежда Зенкова on 05.07.2021.
//

#import <UIKit/UIKit.h>
#import "AuthorizationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RefreshAlertViewController : UIViewController

+ (void)refreshFor:(AuthorizationViewController *)viewcontroller;

@end

NS_ASSUME_NONNULL_END
