//
//  EditPersonalInformation.h
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPersonalInformation : UITableViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UIActionSheet *choseImageSheet;
@property (nonatomic,strong) UIImagePickerController *pickImage;
@end
