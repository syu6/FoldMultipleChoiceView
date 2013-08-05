//
//  FoldMultipleChoiceView.h
//  FoldMultipleChoiceViewDemo
//
//  Created by liufy on 13-8-5.
//  Copyright (c) 2013年 syu6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"

@interface FoldMultipleChoiceView : UIView <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate>
@property (nonatomic, strong) UITableView *foldTableView;
@property (nonatomic, strong) NSMutableArray *headerContentArray;
@property (nonatomic, strong) NSMutableArray *headerViewsArray;
@property (nonatomic, strong) NSMutableDictionary *contentDict;
@property (nonatomic, strong) NSMutableDictionary *statusDict;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat cellHeight;

- (id)initWithFrame:(CGRect)frame
 headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict
       headerHeight:(CGFloat)hHeight
         cellHeight:(CGFloat)cHeight;

- (id)initWithFrame:(CGRect)frame headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict;

- (void)setup;
@end
