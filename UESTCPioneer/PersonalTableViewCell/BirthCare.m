//
//  BirthCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "BirthCare.h"
#import "constant.h"
#import "CellForBirthCare.h"
@interface BirthCare ()
{
    NSMutableArray *BirthListArray;
}

@end

@implementation BirthCare

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if(IS_IOS7)
        self.tableView.separatorInset = UIEdgeInsetsZero;
    [self setExtraCellLineHidden];
    [self.tableView setAllowsSelection:NO];
    [self.tableView registerClass:[CellForBirthCare class] forCellReuseIdentifier:@"setcell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"生日提醒";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setExtraCellLineHidden
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;//[BirthListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    CellForBirthCare *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellForBirthCare alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.name.text = [((NSDictionary *)BirthListArray[indexPath.row]) objectForKey:@"username"];
    cell.date.text = [NSString stringWithFormat:@"%@%@",[((NSDictionary *)BirthListArray[indexPath.row]) objectForKey:@"date"],@"天后过生日" ];
    cell.button.tag = [[((NSDictionary *)BirthListArray[indexPath.row]) objectForKey:@"userid"] intValue];
    [cell.button addTarget:self action:@selector(sendWish:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma 网络请求部分

- (void)sendWish:(id)sender
{
    [NetworkCenter AFRequestWithData:[RequestData sendBirthCareRequestData:((UIButton *)sender).tag] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"result"] isEqualToString:@"success"]){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250,17, 60, 30)];
            label.text = @"已送祝福";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
            [((UIButton *)sender).superview addSubview:label];
            [((UIButton *)sender) setFrame:CGRectMake(230, 25, 15, 15)];
            [((UIButton *)sender) setBackgroundImage:[UIImage imageNamed:@"already.png"] forState:UIControlStateNormal];
        }
        else {
            [Alert showAlert:@"送过祝福啦"];
        }
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"送祝福失败");
    }];
}

- (void)getListOfBirth
{
    [NetworkCenter RKRequestWithData:[RequestData getListOfBirthRequestData:1] EntityName:@"PersonalBirthEntity" Mapping:[Mapping personalBirthMapping] SuccessBlock:^(NSArray *resultArray) {
        //do something;
    } failure:^(NSError *error) {
        //do something;
    }];
}


@end
