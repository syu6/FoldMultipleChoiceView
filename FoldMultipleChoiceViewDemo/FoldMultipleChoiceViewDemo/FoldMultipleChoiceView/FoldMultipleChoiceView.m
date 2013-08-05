//
//  FoldMultipleChoiceView.m
//  FoldMultipleChoiceViewDemo
//
//  Created by liufy on 13-8-5.
//  Copyright (c) 2013年 syu6. All rights reserved.
//

#import "FoldMultipleChoiceView.h"
@interface FoldMultipleChoiceView ()
- (void)initComponents;
- (void)initData;
- (void)initTableView;
//界面重置
- (void)reset:(NSInteger)section;

@property (nonatomic, assign) CGSize screenSize;
@property (nonatomic, assign) NSInteger currentSection;

@end


#define SELECT_COLOR [UIColor colorWithRed:255.0f / 255.0f green:102.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f]

@implementation FoldMultipleChoiceView
@synthesize foldTableView;
@synthesize headerContentArray;
@synthesize headerViewsArray;
@synthesize contentDict;
@synthesize statusDict;

@synthesize screenSize;
@synthesize currentSection;
@synthesize headerHeight;
@synthesize cellHeight;

- (id)initWithFrame:(CGRect)frame
 headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict
       headerHeight:(CGFloat)hHeight
         cellHeight:(CGFloat)cHeight{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.headerContentArray = hArray;
        self.contentDict = cDict;
        self.headerHeight = hHeight;
        self.cellHeight = cHeight;
        
        //初始化
//        [self initComponents];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
 headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.headerContentArray = hArray;
        self.contentDict = cDict;
        self.headerHeight = 44.0f;
        self.cellHeight = 44.0f;
        
        //初始化
//        [self initComponents];
    }
    return self;
}
- (void)setup{
    //初始化
    [self initComponents];
}

- (void)initComponents{
    [self initData];
    [self initTableView];
}
- (void)initData{
    self.screenSize = [UIScreen mainScreen].applicationFrame.size;
    self.headerViewsArray = [NSMutableArray array];
    
    self.statusDict = [NSMutableDictionary dictionary];
    //
    for (int i = 0; i < self.headerContentArray.count; i++) {
        HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.frame), self.headerHeight)];
        headerView.headerViewDelegate = self;
        headerView.section = i;
        NSString *key = [self.headerContentArray objectAtIndex:i];
        headerView.nameLabel.text = key;
        
        NSMutableArray *contentArray = [self.contentDict objectForKey:key];
        NSMutableArray *statusArray = [NSMutableArray array];
        for (int j = 0; j < contentArray.count; j++) {
            [statusArray addObject:[NSNumber numberWithBool:NO]];
        }
        [self.statusDict setObject:statusArray
                            forKey:[NSString stringWithFormat:@"%d",i]];
        
        //添加视图
        [self.headerViewsArray addObject:headerView];
    }
}
- (void)initTableView{
    self.foldTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame),CGRectGetHeight(self.frame))];
    self.foldTableView.dataSource = self;
    self.foldTableView.delegate = self;
    self.foldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加组件
    [self addSubview:self.foldTableView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HeaderView *headerView = [self.headerViewsArray objectAtIndex:section];
    NSString *key = [self.headerContentArray objectAtIndex:section];
    NSMutableArray *arr = [self.contentDict objectForKey:key];
    return headerView.isOpened ? arr.count : 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headerContentArray.count;
}

#define Name_Label_Tag 101
#define Operator_ImageView_Tag 102
#define BackgroundImage_ImageView_Tag 103
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"cell";
    //    NSString *cellIdentity = [NSString stringWithFormat:@"cell%d-%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    
    UILabel *nameLabel;
    UIImageView *operatorImageView;
    UIImageView *backgroundImageView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentity];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化控件
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 13.0f, 180.0f, 17.0f)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:17.0f];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.tag = Name_Label_Tag;
        
        operatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(285.0f, 14.0f, 15.0f, 15.0f)];
        operatorImageView.image = [UIImage imageNamed:@"images/operator.png"];
        operatorImageView.tag = Operator_ImageView_Tag;
        
        backgroundImageView = [[UIImageView alloc] initWithFrame:cell.frame];
        backgroundImageView.image = [[UIImage imageNamed:@"images/cellBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        backgroundImageView.tag = BackgroundImage_ImageView_Tag;
        cell.backgroundView = backgroundImageView;
        
        [cell.contentView addSubview:nameLabel];
        [cell.contentView addSubview:operatorImageView];
    } else {
        nameLabel = (UILabel *)[cell.contentView viewWithTag:Name_Label_Tag];
        operatorImageView = (UIImageView *)[cell.contentView viewWithTag:Operator_ImageView_Tag];
        backgroundImageView = (UIImageView *)[cell.contentView viewWithTag:BackgroundImage_ImageView_Tag];
    }
    
    NSString *key = [self.headerContentArray objectAtIndex:indexPath.section];
    NSMutableArray *arr = [self.contentDict objectForKey:key];
    
    NSString *name = [arr objectAtIndex:indexPath.row];
    nameLabel.text = name;
    
    NSMutableArray *statusArray = [self.statusDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    NSNumber *status = (NSNumber *)[statusArray objectAtIndex:indexPath.row];
    BOOL statusValue = [status boolValue];
    
    operatorImageView.hidden = !statusValue;
    if (statusValue) {//yes被选中，no未被选中
        nameLabel.textColor = SELECT_COLOR;
    } else {
        nameLabel.textColor = [UIColor whiteColor];
    }
    
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *statusArray = [self.statusDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    NSNumber *status = [statusArray objectAtIndex:indexPath.row];
    BOOL statusValue = [status boolValue];
    [statusArray replaceObjectAtIndex:indexPath.row
                           withObject:[NSNumber numberWithBool:(!statusValue)]];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:Name_Label_Tag];
    UIImageView *operatorImageView = (UIImageView *)[cell.contentView viewWithTag:Operator_ImageView_Tag];
    if (!statusValue) {//是否被选中，yes选中状态，no未选中
        nameLabel.textColor = SELECT_COLOR;
        operatorImageView.hidden = statusValue;
    } else {
        nameLabel.textColor = [UIColor whiteColor];
        operatorImageView.hidden = statusValue;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeaderView *headerView = [self.headerViewsArray objectAtIndex:indexPath.section];
    return headerView.isOpened ? self.cellHeight : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headerHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headerViewsArray objectAtIndex:section];
}

#pragma mark -
#pragma mark HeaderViewDelegate
- (void)selectedView:(HeaderView *)cView{
    if (cView.isOpened) {//已经打开
        NSInteger index = 0;
        for (HeaderView *headerView in self.headerViewsArray) {
            NSMutableArray *statusArray = [self.statusDict objectForKey:[NSString stringWithFormat:@"%d",index]];
            //判断用户是否选中了筛选的内容
            BOOL isSelectedStatus = NO;
            for (NSInteger i = 0; i < statusArray.count; i++) {
                NSNumber *status = [statusArray objectAtIndex:i];
                BOOL statusValue = [status boolValue];
                if (statusValue) {
                    isSelectedStatus = statusValue;
                    break;
                }
            }
            //判断是否被选中
            if (isSelectedStatus) {
                headerView.isOpened = YES;
            } else {
                headerView.isOpened = NO;
            }
            index++;
        }
        //刷新tableview
        [self.foldTableView reloadData];
        
        return;
    }
    self.currentSection = cView.section;
    
    //重置数据
    [self reset:cView.section];
}

//界面重置
- (void)reset:(NSInteger)section{
    NSInteger index = 0;
    for (HeaderView *headerView in self.headerViewsArray) {
        if (headerView.section == self.currentSection) {
            headerView.isOpened = YES;
        } else {
            NSMutableArray *statusArray = [self.statusDict objectForKey:[NSString stringWithFormat:@"%d",index]];
            //判断用户是否选中了筛选的内容
            BOOL isSelectedStatus = NO;
            for (NSInteger i = 0; i < statusArray.count; i++) {
                NSNumber *status = [statusArray objectAtIndex:i];
                BOOL statusValue = [status boolValue];
                if (statusValue) {
                    isSelectedStatus = statusValue;
                    break;
                }
            }
            //判断是否被选中
            if (isSelectedStatus) {
                headerView.isOpened = YES;
            } else {
                headerView.isOpened = NO;
            }
        }
        index++;
    }
    
    //刷新数据
    [self.foldTableView reloadData];

    //滚动二级分类到顶部
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0
                                                inSection:section];
    [self.foldTableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= headerHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= headerHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-headerHeight, 0, 0, 0);
    }
}
@end



























