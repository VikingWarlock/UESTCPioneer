//
//  StartActivity.h
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartActivity : UITableViewController <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITextView *editTitle;
@property (nonatomic,strong) UITextView *editBody;
@property (nonatomic,strong) UIView *layoutImage;
@property (nonatomic,strong) UIButton *thumbnail;
@property (nonatomic,strong) UIActionSheet *choseImageSheet;
@property (nonatomic,strong) UIImagePickerController *pickImage;
@end
