//
//  entranceViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "inputRectView.h"

@interface entranceViewController : UIViewController{
    NSLayoutConstraint *inputRectTopConstraint;
        UILabel *welcomeLabel;
}
-(id)initWithLabelTextArray:(NSArray*)array;
@property(nonatomic)NSArray *TextFieldArray;
@property(nonatomic)inputRectView *inputRect;
@end
