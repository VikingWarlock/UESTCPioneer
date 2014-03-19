//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titles:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor whiteColor];
//		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
//		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
//			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
            
//            UIImage *im = [[[imageArray objectAtIndex:i] objectForKey:@"Default"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 30, 18, 30)];
//            [btn setImage:im forState:UIControlStateNormal];
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];

            

            
            
           
      
             UIEdgeInsets insets= UIEdgeInsetsMake(6, 22, 35, 45);
            
            
			[btn setBackgroundImage:[self getCustomImage:imageArray[i][@"Default"] insets:insets] forState:UIControlStateNormal];
			[btn setBackgroundImage:[self getCustomImage:imageArray[i][@"Highlighted"] insets:insets] forState:UIControlStateHighlighted];
			[btn setBackgroundImage:[self getCustomImage:imageArray[i][@"Seleted"] insets:insets] forState:UIControlStateSelected];
      UIEdgeInsets titleInsets= UIEdgeInsetsMake(55, 20, 30, 20);
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btn setTitleColor:[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:192.0/255.0 green:51.0/255.0 blue:43.0/255.0 alpha:1] forState:UIControlStateHighlighted];
                        [btn setTitleColor:[UIColor colorWithRed:192.0/255.0 green:51.0/255.0 blue:43.0/255.0 alpha:1] forState:UIControlStateSelected];
            [btn setTitleEdgeInsets:titleInsets];
//            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 30, 18, 30)];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}



-(UIImage*)getCustomImage:(UIImage*)image insets:(UIEdgeInsets)insets{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGRect targetRect=CGRectMake(insets.left, insets.top, image.size.width-insets.right, image.size.height-insets.bottom);
    [image drawInRect:targetRect];
    UIImage *targetImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

-(CGRect)getCenterFrameWithSuperViewSize:(CGSize)superSize andSize:(CGSize)size{

    return CGRectMake((superSize.width-size.width)/2, (superSize.height-size.height)/2, size.width, size.height);
}



- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
//    NSLog(@"Select index: %d",btn.tag);
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    UIEdgeInsets insets= UIEdgeInsetsMake(6, 22, 35, 45);
    
    
    [btn setBackgroundImage:[self getCustomImage:dict[@"Default"] insets:insets] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self getCustomImage:dict[@"Highlighted"] insets:insets] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self getCustomImage:dict[@"Seleted"] insets:insets] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    
    
    
    
    
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
