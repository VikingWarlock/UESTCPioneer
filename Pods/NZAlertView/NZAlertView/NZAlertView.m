//
//  NZAlertView.m
//  NZAlertView
//
//  Created by Bruno Furtado on 18/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZAlertView.h"
#import "NZAlertViewDelegate.h"
#import "NZAlertViewColor.h"
#import "UIImage+Blur.h"
#import "UIImage+Screenshot.h"

static BOOL IsPresenting;


@interface NZAlertView ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbMessage;
@property (strong, nonatomic) IBOutlet UIImageView *imgIcon;

@property (strong, nonatomic) UIView *backgroundBlackView;
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) NZAlertViewCompletion completion;

- (void)adjustLayout;

- (void)defaultDurationsAndLevels;

- (CGRect)frameForLabel:(UILabel *)label;

- (CGFloat)originY;

@end



@implementation NZAlertView

#pragma mark -
#pragma mark - UIView override methods

- (id)init
{
    self = [super init];
    
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        
        CGRect frame = self.view.frame;
        frame.size.width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
        self.view.frame = frame;
        
        [self addSubview:self.view];
        
        frame = [[UIScreen mainScreen] bounds];
        self.backgroundView = [[UIImageView alloc] initWithFrame:frame];
        
        self.backgroundBlackView = [[UIView alloc] initWithFrame:frame];
        self.backgroundBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2f];
        self.backgroundBlackView.userInteractionEnabled = YES;
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self.backgroundBlackView addGestureRecognizer:gesture];
        
        [self defaultDurationsAndLevels];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public initialize methods

- (id)initWithStyle:(NZAlertStyle)style message:(NSString *)message
{
    return [self initWithStyle:style title:nil message:message];
}

- (id)initWithStyle:(NZAlertStyle)style title:(NSString *)title message:(NSString *)message
{
    return [self initWithStyle:style title:title message:message delegate:nil];
}

- (id)initWithStyle:(NZAlertStyle)style title:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    self = [self init];
    
    if (self) {
        CGRect frame = self.view.frame;
        frame.origin.y = CGRectGetHeight(self.view.frame) - [self originY];
        self.frame = frame;
        
        self.title = title;
        self.message = message;
        self.alertViewStyle = style;
        
        if ([delegate conformsToProtocol:@protocol(NZAlertViewDelegate)]) {
            self.delegate = delegate;
        }
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public methods

- (void)hide
{
    if ([self.delegate respondsToSelector:@selector(NZAlertViewWillDismiss:)]) {
        [self.delegate NZAlertViewWillDismiss:self];
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -(CGRectGetHeight(self.view.frame) + [self originY]);
    
    [UIView animateWithDuration:_animationDuration animations:^{
        self.frame = viewFrame;
        self.backgroundView.alpha = 0;
        self.backgroundBlackView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.backgroundBlackView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
            [self removeFromSuperview];
            
            IsPresenting = NO;
            
            if ([self.delegate respondsToSelector:@selector(NZAlertViewDidDismiss:)]) {
                [self.delegate NZAlertViewDidDismiss:self];
            }
            
            if (self.completion) {
                self.completion();
                self.completion = nil;
            }
        }
    }];
}

- (void)setAlertViewStyle:(NZAlertStyle)alertViewStyle
{
    _alertViewStyle = alertViewStyle;
    UIColor *color = nil;
    
    NSString *path = @"NZAlertView-Icons.bundle/";
    
    switch (alertViewStyle) {
        case NZAlertStyleError:
            path = [path stringByAppendingString:@"AlertViewErrorIcon"];
            color = [NZAlertViewColor errorColor];
            break;
            
        case NZAlertStyleInfo:
            path = [path stringByAppendingString:@"AlertViewInfoIcon"];
            color = [NZAlertViewColor infoColor];
            break;
            
        case NZAlertStyleSuccess:
            path = [path stringByAppendingString:@"AlertViewSucessIcon"];
            color = [NZAlertViewColor successColor];
            break;
    }
    
    self.imgIcon.image = [UIImage imageNamed:path];
    self.lbTitle.textColor = color;
    self.lbMessage.textColor = color;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    self.lbTitle.textAlignment = textAlignment;
    self.lbMessage.textAlignment = textAlignment;
}

- (void)show
{
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(NZAlertViewCompletion)completion
{
    if (IsPresenting) {
        return;
    }
    
    IsPresenting = YES;
    
    self.lbTitle.text = self.title;
    self.lbMessage.text = self.message;
    self.completion = completion;
    [self adjustLayout];
    
    if ([self.delegate respondsToSelector:@selector(willPresentNZAlertView:)]) {
        [self.delegate willPresentNZAlertView:self];
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    
    CGRect frame = self.frame;
    frame.origin.y = -([self originY] + CGRectGetHeight(self.view.frame));
    self.frame = frame;
    
    UIImage *screenshot = [UIImage screenshot];
    NSData *imageData = UIImageJPEGRepresentation(screenshot, .0001);
    UIImage *blurredSnapshot = [[UIImage imageWithData:imageData] blurredImage:_screenBlurLevel];
    
    self.backgroundView.image = blurredSnapshot;
    self.backgroundView.alpha = 0;
    
    self.backgroundBlackView.alpha = 0;
    
    NSInteger index = [[application keyWindow].subviews count];
    
    [[application keyWindow] insertSubview:self atIndex:index];
    [[application keyWindow] insertSubview:self.backgroundBlackView atIndex:index];
    [[application keyWindow] insertSubview:self.backgroundView atIndex:index];
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = [self originY];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        self.frame = viewFrame;
        self.backgroundView.alpha = 1;
        self.backgroundBlackView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(didPresentNZAlertView:)]) {
                [self.delegate didPresentNZAlertView:self];
            }
            
            [self performSelector:@selector(hide) withObject:nil afterDelay:_alertDuration];
        }
    }];
}

#pragma mark -
#pragma mark - Private methods

- (void)adjustLayout
{
    CGRect frame;

    CGFloat titleToMessage = CGRectGetMinY(self.lbMessage.frame) - CGRectGetMaxY(self.lbTitle.frame);
    CGFloat messageToBottom = CGRectGetHeight(self.frame) - CGRectGetMaxY(self.lbMessage.frame);
    
    self.lbTitle.frame = [self frameForLabel:self.lbTitle];
    
    frame = self.lbMessage.frame;
    frame.origin.y = CGRectGetMaxY(self.lbTitle.frame) + titleToMessage;
    self.lbMessage.frame = frame;
    
    self.lbMessage.frame = [self frameForLabel:self.lbMessage];
    
    frame = self.view.frame;
    frame.size.height = CGRectGetMaxY(self.lbMessage.frame) + messageToBottom;
    self.view.frame = frame;
}

- (void)defaultDurationsAndLevels
{
    self.alertDuration = 5.0f;
    self.animationDuration = 0.6f;
    self.screenBlurLevel = 0.6f;
}

- (CGRect)frameForLabel:(UILabel *)label
{
    CGFloat height = [label.text sizeWithFont:label.font
                            constrainedToSize:CGSizeMake(CGRectGetWidth(label.frame), 9999)
                                lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    CGRect frame = label.frame;
    frame.size.height = height;
    
    return frame;
}

- (CGFloat)originY
{
    CGFloat originY = 0;
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if (!application.statusBarHidden) {
        originY = [application statusBarFrame].size.height;
    }
    
    return originY;
}
 
@end