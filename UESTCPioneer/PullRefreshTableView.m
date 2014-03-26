//
//  testTableView.m
//  TableView
//
//  Created by Sway on 14-3-24.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PullRefreshTableView.h"
#import "MJRefresh.h"
#import <objc/message.h>

@interface PullRefreshTableView(){
    
    
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation PullRefreshTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _init];
        
    }
    return self;
}

-(id)init{
    self=[super init];
    if (self ){
        [self _init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self){
        [self _init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self){
        [self _init];
    }
    return self;
}

-(void)setPullDownBeginRefreshBlock:(void (^)(MJRefreshBaseView *refreshView))pullDownBeginRefreshBlock{
    _header.beginRefreshingBlock=pullDownBeginRefreshBlock;
//    _pullDownBeginRefreshBlock=pullDownBeginRefreshBlock;
}



-(void)setPullUpBeginRefreshBlock:(void (^)(MJRefreshBaseView *refreshView))pullUpBeginRefreshBlock{
    _footer.beginRefreshingBlock=pullUpBeginRefreshBlock;
//    _pullUpBeginRefreshBlock=pullUpBeginRefreshBlock;
}

-(void)beginRefreshing{
    [_header beginRefreshing];
}

-(void)setPullUpBeginRefreshAction:(SEL)action{
       __weak PullRefreshTableView *weakSelf=self;
    _footer.beginRefreshingBlock=^(MJRefreshBaseView *refreshView){
        objc_msgSend(weakSelf, action,refreshView);

//        [weakSelf performSelector:action withObject:refreshView];
        
    };
}

-(void)setPullDownBeginRefreshAction:(SEL)action{
    __weak PullRefreshTableView *weakSelf=self;
    _header.beginRefreshingBlock=^(MJRefreshBaseView *refreshView){
        objc_msgSend(weakSelf, action,refreshView);
    };
}





-(void)_init{
        [self addHeader];
        
        // 3.2.上拉加载更多
        [self addFooter];
}




- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self;

    _footer = footer;
}

- (void)addHeader
{
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self;

    
    
    
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    
    
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
//    [header beginRefreshing];
    _header = header;
}

-(void)freeHeaderFooter{
    [_header free];
    [_footer free];
}



- (void)dealloc
{
//    NSLog(@"MJTableViewController--dealloc---");
//    [_header free];
//    [_footer free];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
