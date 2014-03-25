//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#define kTabBarHeight 52.0f

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface LeveyTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation LeveyTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr titles:(NSArray*)titleArray
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
		
        //		_containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-kTabBarHeight)];
        //        _containerView=[[UIView alloc]init];
        
        
		
		_transitionView = [[UIView alloc] init];
		_transitionView.backgroundColor =  [UIColor whiteColor];
		
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, 320.0f, kTabBarHeight) buttonImages:arr titles:titleArray];
		_tabBar.delegate = self;
        
        
        
        
        
		
        leveyTabBarController = self;
	}
	return self;
}

//- (void)loadView
//{
//	[super loadView];
//
//	[_containerView addSubview:_transitionView];
//	[_containerView addSubview:_tabBar];
//
//

////
////

//
//	self.view = _containerView;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:_transitionView];
    [_transitionView setClipsToBounds:YES];
    
    [_transitionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_transitionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_transitionView)]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_transitionView]|" options:0 metrics:@{@"kTabBarHeight":@(kTabBarHeight)} views:NSDictionaryOfVariableBindings(_transitionView)]];
    
    
    [self.view addSubview:_tabBar];
    [_tabBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_transitionView][_tabBar(==kTabBarHeight)]|" options:0 metrics:@{@"kTabBarHeight":@(kTabBarHeight)} views:NSDictionaryOfVariableBindings(_tabBar,_transitionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tabBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tabBar)]];
    
    
    self.selectedIndex = 0;
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}


- (void)dealloc
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (LeveyTabBar *)tabBar
{
	return _tabBar;
}
- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
    
}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}


- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    UIViewController *viewcontroller = (UIViewController *)[_viewControllers objectAtIndex:index];
    [[viewcontroller view] removeFromSuperview];
    [viewcontroller willMoveToParentViewController:nil];
    [viewcontroller removeFromParentViewController];
    [viewcontroller didMoveToParentViewController:nil];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    //    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc  atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    //    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before changing index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    
    UIViewController *targetViewController = [self.viewControllers objectAtIndex:index];
    
    // If target index is equal to current index.
    
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0)
    {
        if ([targetViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)targetViewController popToRootViewControllerAnimated:YES];
        }
        return;
    }
    //    NSLog(@"Display View.");
    _selectedIndex = index;
    
    //	[_transitionView.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:(id)YES];
    for(UIView *view in _transitionView.subviews){
        [view willMoveToSuperview:nil];
        [view removeFromSuperview];
        [view didMoveToSuperview];
    }
    
    
    //    targetViewController.view.hidden = NO;
    CGRect bo =_transitionView.bounds;
    bo.size.height-=kTabBarHeight;
	targetViewController.view.frame = bo;
	if ([targetViewController.view isDescendantOfView:_transitionView])
	{
        //		[_transitionView bringSubviewToFront:targetViewController.view];
        [targetViewController.view willMoveToSuperview:_transitionView];
        [_transitionView addSubview:targetViewController.view];
        [targetViewController.view didMoveToSuperview];
        //        [targetViewController.view willMoveToSuperview:_transitionView];
	}
	else
	{
        //        [targetViewController.view setFrame:CGRectMake(0, 0, 320, 200)];
        //                NSLog(@"%@",targetViewController.view.subviews);
		[_transitionView addSubview:targetViewController.view];
        
        UIView *targetView=targetViewController.view;
        [targetView setClipsToBounds:YES];
        [targetView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_transitionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[targetView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(targetView)]];
        [_transitionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[targetView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(targetView)]];
        //        NSLog(@"%@",_transitionView.constraints);
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:targetViewController];
    }
}

-(void)setTabBarItemWithImageDicationary:(NSDictionary*)imageArray ForIndex:(NSInteger)index{
    [_tabBar setTabBarItemWithImageDicationary:imageArray ForIndex:index];
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	[self displayViewAtIndex:index];
}
@end
