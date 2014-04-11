//
//  StartActivity_displaySelectedImage.m
//  UESTCPioneer
//
//  Created by 张众 on 4/3/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "StartActivity_displaySelectedImage.h"

@interface StartActivity_displaySelectedImage ()

@end

@implementation StartActivity_displaySelectedImage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:self.scrollview];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //self.scrollview.minimumZoomScale = 1.0;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    //self.scrollview.minimumZoomScale = 0.5;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollview.backgroundColor = [UIColor blackColor];
        _scrollview.maximumZoomScale = 1.1;
        _scrollview.minimumZoomScale = 1.0;
        _scrollview.delegate = self;
        [_scrollview addSubview:self.imageview];
    }
    return _scrollview;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageview;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
