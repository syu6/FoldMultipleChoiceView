//
//  HeaderView.m
//  FoldMultipleChoiceViewDemo
//
//  Created by liufy on 13-8-5.
//  Copyright (c) 2013年 syu6. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

- (void)initComponents;
- (void)clickButton:(id)sender;

@property (nonatomic, strong) UILabel *separateLine;
@end

@implementation HeaderView
@synthesize buttonView;
@synthesize nameLabel;

@synthesize section;
@synthesize isOpened;
@synthesize headerViewDelegate;
@synthesize separateLine;

#define Padding 10.0f
//选择视图
- (void)clickButton:(id)sender{
    if (self.headerViewDelegate && [self.headerViewDelegate respondsToSelector:@selector(selectedView:)]) {
        [self.headerViewDelegate selectedView:self];
    }
}
//初始化
- (void)initComponents{
    //初始化数据
    self.isOpened = NO;
    self.buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonView.frame = self.frame;
    [self.buttonView addTarget:self
                        action:@selector(clickButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    //子控件
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    bgImageView.image = [[UIImage imageNamed:@"images/headerBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 218.0f, 17.0f)];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.font = [UIFont systemFontOfSize:17.0f];
    self.nameLabel.textColor = [UIColor blackColor];
    
    //添加控件
    [self.buttonView addSubview:bgImageView];
    [self.buttonView addSubview:self.nameLabel];
    
    [self addSubview:self.buttonView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initComponents];
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

@end
