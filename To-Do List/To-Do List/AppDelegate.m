//
//  AppDelegate.m
//  To-Do List
//
//  Created by soriyany on 2/13/13.
//  Copyright (c) 2013 soriyany. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "ScannerZBarViewController.h"
#import "Items.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar_bg"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Seed Items
    [self sampleItems];
    //initailize list view controller
    ListViewController *listViewController =[[ListViewController alloc]init];
    
    //initialize navigation controller
    UINavigationController *listNavigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
    //listNavigationController.tabBarItem.image = [UIImage imageNamed:@"KS_nav_ui"];
    
    //scanner view controller
    ScannerZBarViewController *scannerViewController = [[ScannerZBarViewController alloc]init];
    
    UINavigationController *scannerNavigationController = [[UINavigationController alloc]initWithRootViewController:scannerViewController];
    
    //initialize Tab Bar Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //Configure Tab Bar Controller
    [tabBarController setViewControllers:@[listNavigationController,scannerNavigationController]];
    //[tabBarController setViewControllers:@[scannerNavigationController]];
    
    //TabBar Background
    UIImage *tabBackground = [[UIImage imageNamed:@"navbar_bg"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set background for all UITabBars
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"AmericanTypewriter" size:15.0f], UITextAttributeFont,
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       [UIColor blackColor], UITextAttributeTextShadowColor,
                                                       [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                                       nil] forState:UIControlStateNormal];
    // Set background for only this UITabBar
    [[tabBarController tabBar] setBackgroundImage:tabBackground];
    //initialize Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //Configure Window
    [self.window setRootViewController:tabBarController];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)sampleItems {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud boolForKey:@"UserDefaultsSeedItems"]) {
        // Load Seed Items
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"seed" ofType:@"plist"];
        NSArray *sampleItems = [NSArray arrayWithContentsOfFile:filePath];
        // Items
        NSMutableArray *items = [NSMutableArray array];
        // Create List of Items
        for (int i = 0; i < [sampleItems count]; i++) {
            NSDictionary *sampleItem = [sampleItems objectAtIndex:i];
            // Create Item
            Items *item = [Items createItemWithName:[sampleItem objectForKey:@"name"] andNote:[sampleItem objectForKey:@"note"]];
            // Add Item to Items
            [items addObject:item];
        }
        // Items Path
        NSString *itemsPath = [[self documentsDirectory] stringByAppendingPathComponent:@"sampleItems.plist"];
        // Write to File
        if ([NSKeyedArchiver archiveRootObject:items toFile:itemsPath]) {
            [ud setBool:YES forKey:@"UserDefaultsSeedItems"];
        }
    }
}
- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}

@end
