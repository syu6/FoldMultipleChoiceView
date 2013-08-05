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

/**
 *	@brief	初始化
 *
 *	@param 	frame 	窗体的frame
 *	@param 	hArray 	HeaderView的标题数组
 *	@param 	cDict 	对应HeaderView中cell标题的数组
 *	@param 	hHeight 	HeaderView的高度
 *	@param 	cHeight 	Cell的高度
 *
 *	@return	self对象
 */
- (id)initWithFrame:(CGRect)frame
 headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict
       headerHeight:(CGFloat)hHeight
         cellHeight:(CGFloat)cHeight;


/**
 *	@brief	初始化
 *
 *	@param 	frame 	窗体的frame
 *	@param 	hArray 	HeaderView的标题数组
 *	@param 	cDict 	对应HeaderView中cell标题的数组
 *
 *	@return	self对象
 */
- (id)initWithFrame:(CGRect)frame
 headerContentArray:(NSMutableArray *)hArray
        contentDict:(NSMutableDictionary *)cDict;


/**
 *	@brief	配置各种属性
 */
- (void)setup;

/**
 *	@brief	返回用户选择的dict，key为用户选择的HeaderView的标题，value为对应HeaderView中用户选择Cell标题的数组。
 *
 *	@return	用户选择的dict
 */
- (NSMutableDictionary *)selectedContentKeyValueDict;

/**
 *	@brief	返回用户选择的dict，key为用户选择的HeaderView的Index，value为对应HeaderView中用户选择Cell标题的数组。
 *
 *	@return	用户选择的dict
 */
- (NSMutableDictionary *)selectedContentIndexValueDict;


@end
