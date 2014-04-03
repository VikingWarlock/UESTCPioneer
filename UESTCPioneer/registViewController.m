//
//  registViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-4-2.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "registViewController.h"
#import "LoginViewController.h"
#import "PartiesEntity.h"

@interface registViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UILabel *partyField,*unitField,*jobField,*branchField;
    UILabel* curPickField;
    
    NSArray *partyDataSource,*unitDataSource,*jobDataSource,*branchDataSource;
    
    UIPickerView *picker;
    
    NSArray *pickerDataSourceArray;
    
    NSLayoutConstraint *pickerBottomConstraint;
    
    UIButton *registButton;
    
    NSArray *unitInfoArray,*branchInfoArray;
    
    
    BOOL jobSelect,unitSelect,insitituSelect;
    
}

@end

@implementation registViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLabelTextArray:(NSArray *)array{
    self = [super initWithLabelTextArray:array];
    if (self){
        jobSelect=NO;
        unitSelect=NO;
        insitituSelect=NO;
        NSArray *placeHolderArray = @[@"请输入昵称",@"请输入您的邮箱",@"输入身份证号",@"点击选择党委",@"点击选择单位"
                                      ,@"点击选择职位",@"点击选择支部",@"请输入密码",@"请确认密码"];
        for (NSInteger i=0;i<self.TextFieldArray.count;i++){
            if (i>=3&&i<=6){
                UILabel *textField = self.TextFieldArray[i];
                textField.text=placeHolderArray[i];
                
            }
            else {
            UITextField *textField = self.TextFieldArray[i];
            textField.placeholder=placeHolderArray[i];
            [textField setDelegate:self];
            }
        }
        
        partyField = self.TextFieldArray[3];
        unitField = self.TextFieldArray[4];
        jobField = self.TextFieldArray[5];
        branchField=self.TextFieldArray[6];

        
        
        UITapGestureRecognizer *touchRecognizer  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureForSomeTextField:)];
        [partyField addGestureRecognizer:touchRecognizer];
        
        
        UITapGestureRecognizer *touchRecognizer1  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureForUnitField:)];
        [unitField addGestureRecognizer:touchRecognizer1];
        
                UITapGestureRecognizer *touchRecognizer2  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureForJobField:)];
        [jobField addGestureRecognizer:touchRecognizer2];
        
                UITapGestureRecognizer *touchRecognizer3  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureForBranchField:)];
        [branchField addGestureRecognizer:touchRecognizer3];
        
        
        
        
        [partyField setUserInteractionEnabled:YES];
        [unitField setUserInteractionEnabled:YES];
        [jobField setUserInteractionEnabled:YES];
        [branchField setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
#pragma mark 获取党委列表
    NSDictionary *requestData=@{@"type":@"getInstitute"};
    [NetworkCenter AFRequestWithData:requestData SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *content1= [arr[0] objectForKey:@"content1"];

        
        unitInfoArray =content1;
        
        NSMutableArray *mut = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in content1){
            [mut addObject:dic[@"partyName"]];
        }
        unitDataSource=[[NSArray alloc]initWithArray:mut];
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    

	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    registButton =[[UIButton alloc]init];
    [self.view addSubview:registButton];
    [registButton setTitle:@"提交注册信息" forState:UIControlStateNormal];
    [registButton setBackgroundColor:kNavigationBarColor];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registButton.layer setCornerRadius:5];
    [registButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [registButton setHighlighted:YES];
    [registButton addTarget:self action:@selector(registButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [registButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:registButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputRect attribute:NSLayoutAttributeBottom multiplier:1 constant:12]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:registButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputRect attribute:NSLayoutAttributeLeft multiplier:1 constant:12]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[registButton(==160)]" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(registButton)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[registButton(==38)]" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(registButton)]];
    
    //加入pickerView
    picker = [[UIPickerView alloc]init];
    [self.view addSubview:picker];
    
    picker.delegate=self;
    picker.dataSource=self;
    
    [picker setBackgroundColor:[UIColor whiteColor]];
    picker.showsSelectionIndicator=NO;
    [picker setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[picker]|" options:0 metrics:Nil views:NSDictionaryOfVariableBindings(picker)]];
    pickerBottomConstraint=[NSLayoutConstraint constraintWithItem:picker attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self hidePicker];
    [self.view addConstraint:pickerBottomConstraint];
//    [picker setBackgroundColor:[UIColor redColor]];
    
    partyDataSource=@[@"各单位党委"];
    unitDataSource=@[@"22",@"33",@"44"];
    jobDataSource=@[@"本科生",@"研究生",@"博士",@"教师"];
    branchDataSource=@[];
    
#warning text here
    pickerDataSourceArray=@[@"111",@"222",@"333"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (id textField in self.TextFieldArray){
        if ([textField isKindOfClass:[UITextField class]])
        [textField resignFirstResponder];
    }
    
    inputRectTopConstraint.constant=8;
    [welcomeLabel setAlpha:1];
[UIView animateWithDuration:0.25 animations:^{
    [self.view layoutIfNeeded];
}];
    [self hidePicker];

}

#pragma mark - textField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self hidePicker];

//    NSLog(@"%f",textField.viewForBaselineLayout.frame.origin.y);
    NSLog(@"%f",textField.frame.origin.y);
    
//    CGFloat offset = textField.frame.origin.y;
    
//    if (offset>100){
//        if (offset==160)inputRectTopConstraint.constant-=40;
//    }
    
    if (textField.frame.origin.y>100){
        inputRectTopConstraint.constant=-textField.frame.origin.y+100;
        [welcomeLabel setAlpha:0];
    }
    else{
        inputRectTopConstraint.constant=8;
        [welcomeLabel setAlpha:1];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma  mark - picker delegate 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (curPickField==unitField)unitSelect=YES;
    if (curPickField==jobField)jobSelect=YES;
    if (curPickField==partyField)insitituSelect=YES;
    [curPickField setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerDataSourceArray[row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerDataSourceArray count];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
//
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    return 320;
//}

#pragma mark - 点击选择拦
-(void)tapGestureForSomeTextField:(UITapGestureRecognizer *)recognizer{
    curPickField=partyField;
    pickerDataSourceArray=partyDataSource;
    [picker reloadAllComponents];
    [self showPicker];
}

-(void)tapGestureForUnitField:(UITapGestureRecognizer *)recognizer{
        curPickField=unitField;
    pickerDataSourceArray=unitDataSource;
        [picker reloadAllComponents];
    [self showPicker];
}
-(void)tapGestureForJobField:(UITapGestureRecognizer *)recognizer{
    inputRectTopConstraint.constant=-jobField.frame.origin.y+100;
    [welcomeLabel setAlpha:0];
    curPickField=jobField;
    pickerDataSourceArray=jobDataSource;
        [picker reloadAllComponents];
    [self showPicker];
}
-(void)tapGestureForBranchField:(UITapGestureRecognizer *)recognizer{
    
    if (!(jobSelect&&insitituSelect&&unitSelect)){
        [Alert showAlert:@"请先选择以上信息"];
        return;
    }
    
#pragma mark 请求支部

    
    //@查找institute
    NSString *institute;
    for(NSDictionary *dic in unitInfoArray){
        if ([dic[@"partyName"] isEqualToString:unitField.text]){
            institute=dic[@"partyNo"];
        }
    }
    
    NSInteger byb;
    if ([jobField.text isEqualToString:@"本科生"]){
        byb=1;
    }
    else if ([jobField.text isEqualToString:@"研究生"]){
        byb=2;
    }
        else if ([jobField.text isEqualToString:@"博士"]){
            byb=3;
        }
        else if ([jobField.text isEqualToString:@"教师"]){
            byb=4;
        }
        else byb=0;
    
    NSDictionary *requestDic = @{@"type":@"getBranch",@"institute":institute,@"byb":[NSString stringWithFormat:@"%d",byb]};
    
    
    [NetworkCenter AFRequestWithData:requestDic SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSArray *arr=  [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        branchInfoArray=arr;
        
        
        NSMutableArray *mut = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in branchInfoArray){
            [mut addObject:dic[@"partyName"]];
        }
        branchDataSource=[[NSArray alloc]initWithArray:mut];
        [picker reloadAllComponents];
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    inputRectTopConstraint.constant=-jobField.frame.origin.y+100;
    [welcomeLabel setAlpha:0];
        curPickField=branchField;
    pickerDataSourceArray=branchDataSource;
        [picker reloadAllComponents];
    [self showPicker];
}

#pragma mark - picker animation

-(void)showPicker{
    pickerBottomConstraint.constant=0;

    [UIView animateWithDuration:0.25 animations:^{
            picker.alpha=1;
        [self.view setNeedsLayout];
    }];
}

-(void)hidePicker{
    pickerBottomConstraint.constant=300;

    [UIView animateWithDuration:0.25 animations:^{
        picker.alpha=0;
        [self.view setNeedsLayout];
    }];
}
#pragma mark - regist Button 
-(void)registButton:(UIButton *)button{

}




@end
