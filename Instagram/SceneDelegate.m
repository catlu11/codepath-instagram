//
//  SceneDelegate.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "SceneDelegate.h"
#import "Parse/Parse.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    PFUser *user = [PFUser currentUser];
    if (user != nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tabNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"TabNavigationController"];
        self.window.rootViewController = tabNavigationController;
    }
}

@end
