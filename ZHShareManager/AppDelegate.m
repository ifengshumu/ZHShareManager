//
//  AppDelegate.m
//  ZHShareManager
//
//  Created by 李志华 on 2018/12/25.
//  Copyright © 2018 CoderApple. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHShareManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ZHShareManager setSocialShareAppkey:@"5b99e678a40fa35d54500152"];
    [ZHShareManager setPlaform:SharePlatformTypeSina appKey:@"3941711954"  appSecret:@"04b48b876faeb56783c32669824ebdad" redirectURL:nil];
    [ZHShareManager setPlaform:SharePlatformTypeWxSession appKey:@"wx2d9k20b542hjf6e8" appSecret:@"33c342cab90deb204c1c8768cc00c36c" redirectURL:nil];
    [ZHShareManager setPlaform:SharePlatformTypeQQ appKey:@"1175789568" appSecret:nil redirectURL:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
