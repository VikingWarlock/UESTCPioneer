//
//  StartActivity.h
//  UESTCPioneer
//
//  Created by 张众 on 3/26/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartActivity : UITableViewController <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIScrollViewDelegate>{
BOOL isFirstEdit1;
}
@property (nonatomic,strong) UITextView *editTitle;
@property (nonatomic,strong) UITextView *editBody;
@property (nonatomic,strong) UICollectionView *collectionview;
@property (nonatomic,strong) UIActionSheet *choseImageSheet;
@property (nonatomic,strong) UIImagePickerController *pickImage;


-(NSMutableArray*)getPickedImageArray;
//让子类继承
- (void)commit:(id)sender;

@end
