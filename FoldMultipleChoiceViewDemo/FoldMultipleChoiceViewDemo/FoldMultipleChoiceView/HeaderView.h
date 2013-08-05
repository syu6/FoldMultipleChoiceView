//
//  HeaderView.h
//  FoldMultipleChoiceViewDemo
//
//  Created by liufy on 13-8-5.
//  Copyright (c) 2013年 syu6. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeaderViewDelegate;

@interface HeaderView : UIView
@property (nonatomic, strong) UIButton *buttonView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, weak) id<HeaderViewDelegate> headerViewDelegate;
@end


@protocol HeaderViewDelegate <NSObject>
- (void)selectedView:(HeaderView *)subView;
@end