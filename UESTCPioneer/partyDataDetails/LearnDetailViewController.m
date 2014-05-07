//
//  LearnDetailViewController.m
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "LearnDetailViewController.h"

@interface LearnDetailViewController (){
    NSString * urlString;
}

@property (nonatomic,strong) UILabel * nameLabel;
//@property (nonatomic,strong) UILabel * adressLabel;
@property (nonatomic,strong) UILabel * stateLabel;
@property (nonatomic,strong) UIButton * downloadButton;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,strong) UIProgressView * progress;


@end

@implementation LearnDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithFileName:(NSString *)fileName URLString:(NSString *)str{
    if (self) {
        _fileName = fileName;
        urlString = str;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"下载";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 50)];
    _nameLabel.text = [NSString stringWithFormat:@"文件名 : %@",_fileName];
    
  //  UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 10, 80, 50)];
 //   label.text = @"保存地址 :";
//    _adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, label.frame.origin.y, 320 - 90, 50)];
//    _adressLabel.adjustsFontSizeToFitWidth = YES;
//    _adressLabel.text = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UILabel * state = [[UILabel alloc] initWithFrame:CGRectMake(5, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 10, 120, 50)];
    state.text = @"文件下载状态 :";
    
    _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.progress.frame.origin.x + self.progress.frame.size.width + 5, state.frame.origin.y, 50, 50)];
    
    
    
    for (int i = 0; i < 2; i ++) {
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 60+60*i, 320, 1)];
        bgView.backgroundColor = [UIColor redColor];
        [self.view addSubview:bgView];
    }
    
    NSString* filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:self.fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        [self.progress setProgress:1 animated:NO];
        [self.stateLabel setText: @"100%"];
        [self.downloadButton setTitle:@"点击预览" forState:UIControlStateNormal];
        [self.downloadButton setTitle:@"点击预览" forState:UIControlStateSelected];
        [self.downloadButton setTitle:@"点击预览" forState:UIControlStateHighlighted];
    }
    
    
    [self.view addSubview:self.downloadButton];
    [self.view addSubview:_nameLabel];
//    [self.view addSubview:_adressLabel];
    [self.view addSubview:_stateLabel];
//    [self.view addSubview:label];
    [self.view addSubview:self.progress];
    [self.view addSubview:state];
    
    
    // Do any additional setup after loading the view.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    
}

-(UIProgressView *)progress{
    if (!_progress) {
        self.progress= [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.progress setFrame:CGRectMake(130, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 33, 130, 10)];
    }
    return _progress;
}

-(UIButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 100.0, 30.0)];
        [_downloadButton setBackgroundImage:[UIImage imageNamed:@"filedl"] forState:UIControlStateNormal];
        [_downloadButton setBackgroundImage:[UIImage imageNamed:@"filedl"] forState:UIControlStateHighlighted];
        [_downloadButton setBackgroundImage:[UIImage imageNamed:@"filedl"] forState:UIControlStateSelected];
        [_downloadButton setTitle:@"下载文件" forState:UIControlStateSelected];
        [_downloadButton setTitle:@"下载文件" forState:UIControlStateNormal];
        [_downloadButton setTitle:@"下载文件" forState:UIControlStateHighlighted];
        [_downloadButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 30, 5, 5)];
        [_downloadButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _downloadButton.titleLabel.textColor = [UIColor whiteColor];
        
        [_downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

-(void)downloadButtonClick:(UIButton *)sender{
/*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t downloadImage = dispatch_group_create();
    
    NSString* filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:self.fileName];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:filePath]) {
        dispatch_group_async(downloadImage, queue, ^{
            NSString *urlString = [[baseUrl stringByAppendingString:@"/UestcApp/FileDownServlet.do?filename="] stringByAppendingString:self.fileName];
            NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSData *responseData = [NSData dataWithContentsOfURL:url];
            
            if (responseData!=nil){
                NSLog(@"下载成功");
                if ([responseData writeToFile:filePath atomically:YES]) {
                    UIAlertView * alterView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"文件保存成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alterView show];
                }else{
                    UIAlertView * alterView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"文件保存失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alterView show];
                }
            }else{
                NSLog(@"下载失败");
            }
        });
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已下载!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    if ([fileManager fileExistsAtPath:filePath]) {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }
 */
    NSString* filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:self.fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        
    }else{

        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
        [downloadTask resume];
        
    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - URLSessionDownload Delegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"Temporary File :%@\n", location);
    NSError *err = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSURL *docsDirURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:self.fileName]];
    if ([fileManager moveItemAtURL:location
                             toURL:docsDirURL
                             error: &err])
    {
        NSLog(@"File is saved as =%@",docsDirURL);
     //   NSURL *fileURL = [NSURL fileURLWithPath:docsDirURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:docsDirURL];
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        
        
    }
    else
    {
        NSLog(@"failed to move: %@",[err userInfo]);
    }
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float progress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(),^ {
        [self.progress setProgress:progress animated:YES];
        self.stateLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    });
    NSLog(@"Progress =%f",progress);
    NSLog(@"Received: %lld bytes (Downloaded: %lld bytes)  Expected: %lld bytes.\n",
          bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

@end
