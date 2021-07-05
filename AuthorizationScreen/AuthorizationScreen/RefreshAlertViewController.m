//
//  RefreshAlertViewController.m
//  AuthorizationScreen
//
//  Created by Надежда Зенкова on 05.07.2021.
//

#import "RefreshAlertViewController.h"

@interface RefreshAlertViewController ()

@end

@implementation RefreshAlertViewController

+ (void)refreshFor:(AuthorizationViewController *)viewcontroller {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfully authorized!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *refreshAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [viewcontroller refresh];
    }];
    [alertController addAction:refreshAction];
    //addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in }))
    //var rootViewController = UIApplication.shared.keyWindow?.rootViewController
    [viewcontroller presentViewController:alertController animated:true completion:nil];
}

@end
