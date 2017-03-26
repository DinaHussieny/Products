//
//  AppDelegate.m
//  Products
//
//  Created by Dina Hussieny on 3/17/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import "AppDelegate.h"
#import "ProductsViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ProductsViewController *productsViewController = [[ProductsViewController alloc] init];
     UINavigationController *productsNavigationController = [[UINavigationController alloc] initWithRootViewController:productsViewController];
       self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = productsNavigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
