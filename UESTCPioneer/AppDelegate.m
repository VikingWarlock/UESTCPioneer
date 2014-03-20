//
//  AppDelegate.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "AppDelegate.h"
#import "PioneerViewController.h"
#import "PPRevealSideViewController.h"
#import "LeveyTabBarController.h"
#import "LeftMenuTableViewController.h"
#import "CommunicationViewController.h"
#import "PartyNoticeViewController.h"
#import "PersonalViewController.h"
#import "PartyDataViewController.h"
#import "constant.h"
#import "PartyNoticeViewController.h"
#import "UPMainViewController.h"




@interface AppDelegate()<PPRevealSideViewControllerDelegate,UINavigationControllerDelegate>{
    LeveyTabBarController *tab;
}
@end

@interface NSManagedObjectContext()
+ (void) MR_setDefaultContext:(NSManagedObjectContext *)moc;
+ (void) MR_setRootSavingContext:(NSManagedObjectContext *)context;
@end

@implementation AppDelegate
//@synthesize leveyTabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //    RootViewController *main = [[RootViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    ///////////////CoreDate Init
    [MagicalRecord setupCoreDataStack];
    
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    
    NSError *error = nil;
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Store.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }
    
    [managedObjectStore createManagedObjectContexts];
    
    
    
    
    
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedObjectStore.mainQueueManagedObjectContext];
    
    [PublicMethod refreshStaticCoreData];
    
    /////////////// APN register
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    
    
    ////////////// Application launched through APN
    NSDictionary *RemoteNotify=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (RemoteNotify) {
        // 处理远程推送
    }
    
    ////////////////
    PioneerViewController *main = [[PioneerViewController alloc]init];
    CommunicationViewController *communicationViewController =[[CommunicationViewController alloc] init];
    PartyDataViewController *partyDataViewController = [[PartyDataViewController alloc]init];
    PersonalViewController *personalViewController =  [[PersonalViewController alloc]init];
    
    
    
    if(IS_IOS7)[[UINavigationBar appearance]setBarTintColor:kNavigationBarColor];
    else [[UINavigationBar appearance] setTintColor:kNavigationBarColor];
    
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"home_highlighted.png"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"home_highlighted"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"chat.png"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"chat_highlighted.png"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"chat_highlighted"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"file.png"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"file_highlighted.png"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"file_highlighted"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"personal.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"personal_highlighted.png"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"personal_highlighted.png"] forKey:@"Seleted"];
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
    
    
    NSArray *titleArray = @[@"首页",@"交流",@"资料",@"个人"];
    
    
    tab = [[LeveyTabBarController alloc] initWithViewControllers:@[main,communicationViewController,partyDataViewController,personalViewController] imageArray:imgArr titles:titleArray];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:tab];
    [tab.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
    [nav.navigationBar setTranslucent:NO];
    tab.navigationController.delegate=self;
    
    //    [nav.navigationBar setTintColor:kNavigationBarColor];
    //    [nav.navigationBar setBarTintColor:[UIColor redColor]];
    [constant setCenterController:nav];

    
    self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
    nav.revealSideViewController.delegate=self;
    
    [self.revealSideViewController preloadViewController:[[LeftMenuTableViewController alloc]init] forSide:PPRevealSideDirectionLeft withOffset:70];
    
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView];
    self.window.rootViewController = self.revealSideViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    
    //运营商和时间的风格
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [Unread setUnreadNum:10 ForKey:kUnreadMoodShare];
    
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
    [MagicalRecord cleanUp];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma Remote Notification
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

#pragma Local Notification
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    
}

#pragma mark - PPRevealSideViewController delegate

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController *)controller directionsAllowedForPanningOnView:(UIView *)view{

    return PPRevealSideDirectionRight|PPRevealSideDirectionLeft;
}


-(void)pprevealSideViewController:(PPRevealSideViewController *)controller panningHorizontally:(UIGestureRecognizer *)gesture{
    
    for (UIView *view in tab.selectedViewController.view.subviews){
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *sc=(UIScrollView*)view;
            [sc setScrollEnabled:NO];
        }
    }

}


-(void)pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController{

    [tab.selectedViewController.view setUserInteractionEnabled:NO];

    
}

-(void)pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController{

        [tab.selectedViewController.view setUserInteractionEnabled:YES];
    for (UIView *view in tab.selectedViewController.view.subviews){
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *sc=(UIScrollView*)view;
            [sc setScrollEnabled:YES];
        }
    }

}

#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[LeveyTabBarController class]]){
        LeveyTabBarController *l = (LeveyTabBarController*)viewController;
        [l.selectedViewController viewWillAppear:animated];
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[LeveyTabBarController class]]){
        LeveyTabBarController *l = (LeveyTabBarController*)viewController;
        [l.selectedViewController viewDidAppear:animated];
    }
}
@end
