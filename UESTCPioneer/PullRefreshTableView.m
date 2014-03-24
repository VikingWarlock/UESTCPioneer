//
//  testTableView.m
//  TableView
//
//  Created by Sway on 14-3-24.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "PullRefreshTableView.h"
#import "MJRefresh.h"

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
        
    }
    return self;
}

-(void)setPullDownBeginRefreshBlock:(void (^)(MJRefreshBaseView *))pullDownBeginRefreshBlock{
    _header.beginRefreshingBlock=pullDownBeginRefreshBlock;
    _pullDownBeginRefreshBlock=pullDownBeginRefreshBlock;
}

-(void)setPullUpBeginRefreshBlock:(void (^)(MJRefreshBaseView *))pullUpBeginRefreshBlock{
    _footer.beginRefreshingBlock=pullUpBeginRefreshBlock;
    _pullUpBeginRefreshBlock=pullUpBeginRefreshBlock;
}

-(id)init{
    self =[super init];
    if (self){
        [self addHeader];
        
        // 3.2.上拉加载更多
        [self addFooter];
    
    }
    return self;


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

- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
    [_header free];
    [_footer free];
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
