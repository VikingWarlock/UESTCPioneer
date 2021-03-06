//
//  AppDelegate.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
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
#import "PersonalViewController.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"logout" object:nil];
    
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
    
    //运营商和时间的风格
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //白色
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    
    
    if(IS_IOS7)[[UINavigationBar appearance]setBarTintColor:kNavigationBarColor];
    else [[UINavigationBar appearance] setTintColor:kNavigationBarColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    RootViewController *main = [[RootViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    
    
    /////////////// APN register
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    
    
    ////////////// Application launched through APN
    NSDictionary *RemoteNotify=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (RemoteNotify) {
        // 处理远程推送
    }
    
    ////////////////
//@这是注册界面和登陆界面的代码，暂时用宏定义隐藏起来
#if debugMode

#else
    NSUserDefaults * defaultData = [NSUserDefaults standardUserDefaults];
    BOOL login = [defaultData boolForKey:@"login"];
    if (!login){
        LoginViewController *loginViewController  = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
        nav.navigationBar.translucent=NO;
        self.window.rootViewController=nav;
        
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        return YES;
        
    }
#endif
    
    //调试模式
#if debugMode
    [Unread setUnreadNum:10 ForKey:kUnreadMoodShare];
    [Unread setUnreadNum:10 ForKey:kUnreadPioneerKey];
    
    [constant setUserId:@"001002200011"];
    [constant setUserName:@"IOS test"];
    [constant setName:@"TestName"];
#endif
    
    
    
   
    
    [self login];
    // Override point for customization after application launch.
    
    

    
    
    
    
    

    
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

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController *)controller directionsAllowedForPanningOnView:(UIView *)view{
//    NSLog(@"aaa");
    
    
    //@根据要求，除了首页，其他页面不能右滑
    if (tab.selectedIndex){
        return NO;
    }
    
    return PPRevealSideDirectionRight|PPRevealSideDirectionLeft;
}

//-(PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController *)controller directionsAllowedForPanningOnView:(UIView *)view{
////    UPMainViewController *up = (UPMainViewController*)tab.selectedViewController;
////    [up.view setUserInteractionEnabled:NO];
//        [tab.selectedViewController.view setUserInteractionEnabled:NO];
//    NSLog(@"will");
//    return PPRevealSideDirectionLeft | PPRevealSideDirectionRight |PPRevealSideDirectionTop|PPRevealSideDirectionBottom;
//}

//- (BOOL)pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer *)gesture forView:(UIView *)view{
////    if ([gesture isMemberOfClass:[UIPanGestureRecognizer class]]){
////    if (gesture.state){
//        NSLog(@"changed,%d",gesture.state);
////    }
////    NSLog(@"gesture,%@",gesture);
////        NSLog(@"view:%@",view);
////    }
//
//    return NO;
//}
-(void)pprevealSideViewController:(PPRevealSideViewController *)controller panningHorizontally:(UIGestureRecognizer *)gesture{
    
    for (UIView *view in tab.selectedViewController.view.subviews){
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *sc=(UIScrollView*)view;
            [sc setScrollEnabled:NO];
        }
    }
    
//    NSLog(@"panning");
//    [tab.view setUserInteractionEnabled:];
//    for (UIView *view in tab.view.subviews){
//        [view setUserInteractionEnabled:NO];
//    }
//    NSLog(@"%@",tab.view.subviews);
//    [tab.view setUserInteractionEnabled:NO];
//    UPMainViewController *up=(UPMainViewController*)tab.selectedViewController;
//    [up.tableView setScrollEnabled:NO];
}


-(void)pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController{
//    NSLog(@"push");
//    [pushedController.view setUserInteractionEnabled:YES];
//    for (UIView *view in tab.view.subviews){
//        if ([view isKindOfClass:[UITableView class]]){
//            NSLog(@"aaa:%@",view);
////            [view setUserInteractionEnabled:NO];
//        }
//    }
//    UPMainViewController *up=(UPMainViewController*)tab.selectedViewController;
//    [up.view setUserInteractionEnabled:NO];
//    NSLog(@"push");
    [tab.selectedViewController.view setUserInteractionEnabled:NO];
//    ]
    
}


-(void)pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController{
//    [centerController se]
        [tab.selectedViewController.view setUserInteractionEnabled:YES];
    for (UIView *view in tab.selectedViewController.view.subviews){
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *sc=(UIScrollView*)view;
            [sc setScrollEnabled:YES];
        }
    }
//        NSLog(@"pop");
//    NSLog(@"pop");
//    UPMainViewController *up=(UPMainViewController*)tab.selectedViewController;
//    [up.view setUserInteractionEnabled:YES];
//    [centerController.view setUserInteractionEnabled:NO];

}





#pragma mark - login success
-(void)login{
    
    //@用户信息
                NSUserDefaults * defaultData = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo=[defaultData objectForKey:@"personalInfo"];
    [constant setPersonalInfo:userInfo];
    [constant setName:userInfo[@"name"]];
    [constant setUserId:userInfo[@"userID"]];
    [constant setUserName:userInfo[@"userName"]];
    
    
    PioneerViewController *main = [[PioneerViewController alloc]init];
    CommunicationViewController *communicationViewController =[[CommunicationViewController alloc] init];
    PartyDataViewController *partyDataViewController = [[PartyDataViewController alloc]init];
    PersonalViewController *personalViewController =  [[PersonalViewController alloc]init];
    
    
    
    
    
    
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
    nav.delegate=self;
    //    [tab.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [nav.navigationBar setTranslucent:NO];
    //    [nav.navigationBar setTintColor:kNavigationBarColor];
    //    [nav.navigationBar setBarTintColor:[UIColor redColor]];
    [constant setCenterController:nav];
    
    
    self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
    nav.revealSideViewController.delegate=self;
    
    [self.revealSideViewController preloadViewController:[[LeftMenuTableViewController alloc]init] forSide:PPRevealSideDirectionLeft withOffset:70];
    
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    self.window.rootViewController = self.revealSideViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    
    


}

-(void)logout{
    LoginViewController *loginViewController  = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    nav.navigationBar.translucent=NO;
    self.window.rootViewController=nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    
}

#pragma mark - navigationController delegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[LeveyTabBarController class]]){
        LeveyTabBarController *v = (LeveyTabBarController*)viewController;
        [v.selectedViewController viewWillAppear:animated];
    }
}




@end
