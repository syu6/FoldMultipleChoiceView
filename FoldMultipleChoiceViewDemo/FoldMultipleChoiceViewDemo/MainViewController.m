//
//  MainViewController.m
//  FoldMultipleChoiceViewDemo
//
//  Created by liufy on 13-8-5.
//  Copyright (c) 2013年 syu6. All rights reserved.
//

#import "MainViewController.h"
#import "FoldMultipleChoiceView.h"

@interface MainViewController ()
- (void)initComponets;
- (void)filterContent:(id)sender;

@property (nonatomic, strong) FoldMultipleChoiceView *foldMultipleChoiceView;
@end

@implementation MainViewController
@synthesize foldMultipleChoiceView;

- (void)initComponets{
    /*
     使用方法:
     1.必须创建headerViewsArray,类型为NSMutableArray,内容为NSString类型。此数组中的内容为HeaderView的标题。
     2.必须创建contentDict,类型为NSMutableDictionary,key为headerViewsArray中对应的值,
     value为NSMutableArray的数组,数组中存放对应cell中的标题。
     3.headerHeight为HeaderView的高，不填默认为44.0f。
     4.cellHeight为Cell的高，不填默认为44.0f。
     5.赋值后必须调用setup方法。
     
     注意事项：
     1.如果想自定义HeaderView的样式和内容，请修改HeaderView
     2.如果想自定义Cell的内容，请在FoldMultipleChoiceView的tableView:cellForRowAtIndexPath:方法中修改。
     */
    CGSize screenSize = [UIScreen mainScreen].applicationFrame.size;
    //第1步 创建FoldMultipleChoiceView
    self.foldMultipleChoiceView = [[FoldMultipleChoiceView alloc] initWithFrame:CGRectMake(0, 44, screenSize.width, screenSize.height - 44)];

    //属性赋值
    NSMutableArray *hArray = [NSMutableArray arrayWithArray:@[@"商品类型",@"材质",@"标签"]];
    NSMutableDictionary *cDict = [NSMutableDictionary dictionary];
    
    [cDict setObject:[NSMutableArray arrayWithArray:@[@"男装",@"女装",@"儿童",@"老人",@"婴儿"]]
              forKey:[hArray objectAtIndex:0]];
    [cDict setObject:[NSMutableArray arrayWithArray:@[@"纯棉",@"皮",@"麻",@"毛呢",@"牛仔布"]]
              forKey:[hArray objectAtIndex:1]];
    [cDict setObject:[NSMutableArray arrayWithArray:@[@"t恤",@"毛衣",@"长裤",@"短裤",@"内衣",@"羽绒服",@"外套"]]
              forKey:[hArray objectAtIndex:2]];

    //第2步 设置对应的headerContentArray,contentDict,headerHeight,cellHeight
    //(可以选择FoldMultipleChoiceView的其他初始化方法，减少单独设置属性)
    self.foldMultipleChoiceView.headerContentArray = hArray;
    self.foldMultipleChoiceView.contentDict = cDict;
    
    self.foldMultipleChoiceView.headerHeight = 44.0f;
    self.foldMultipleChoiceView.cellHeight = 44.0f;
    
    //启动
    [self.foldMultipleChoiceView setup];
    
    [self.view addSubview:self.foldMultipleChoiceView];
    
    //点击获取所有用户所选择的内容
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(250.0f, 7.0f, 50.0f, 30.0f);
    [finishButton setTitle:@"完成"
                  forState:UIControlStateNormal];
    [finishButton addTarget:self
                     action:@selector(filterContent:)
           forControlEvents:UIControlEventTouchUpInside];
    finishButton.backgroundColor = [UIColor colorWithRed:122.0f / 255.0f
                                                   green:122.0f / 255.0f
                                                    blue:122.0f / 255.0f
                                                   alpha:1.0f];
    [self.view addSubview:finishButton];
}
- (void)filterContent:(id)sender{
    /*
     获取用户选择的内容1:
        1.通过foldMultipleChoiceView对象的selectedContentKeyValueDict或者selectedContentIndexValueDict方法来判断用户选择的内容。
     */
    NSMutableDictionary *selectedValueDict = self.foldMultipleChoiceView.selectedContentKeyValueDict;
    if (selectedValueDict.count == 0) {
        NSLog(@"----------用户没有选择任何内容");
    } else {
        for (NSString *key in selectedValueDict) {
            NSLog(@"------key=%@   value=%@",key,[selectedValueDict objectForKey:key]);
        }
    }
    
    
    /*
     获取用户选择的内容2:
        1.key为对应HeaderView的index，value为对应Cell的值
    */
    /*
    NSMutableDictionary *selectedIndexValueDict = self.foldMultipleChoiceView.selectedContentIndexValueDict;
    if (selectedIndexValueDict.count == 0) {
        NSLog(@"----------用户没有选择任何内容");
    } else {
        for (NSString *key in selectedIndexValueDict) {
            NSLog(@"------key=%@   value=%@",key,[selectedIndexValueDict objectForKey:key]);
        }
    }
     */
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initComponets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
