//
//  LearnDetailViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearnDetailViewController : UIViewController<NSURLSessionDownloadDelegate,UIWebViewDelegate>


-(id) initWithFileName:(NSString *)fileName URLString:(NSString *)str;
@end
