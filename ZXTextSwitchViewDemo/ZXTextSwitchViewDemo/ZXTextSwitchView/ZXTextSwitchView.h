//
//  ZXTextSwitchView.h
//  ZXTextSwitchViewDemo
//
//  Created by 李兆祥 on 2017/12/24.
//  Copyright © 2017年 李兆祥. All rights reserved.
//  ContactWay QQ:393727164

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZXTextSwitchView;
//代理
@protocol ZXTextSwitchViewDelegate <NSObject>
@optional
-(void)textSwitchView:(ZXTextSwitchView *)textSwitchView  didChangedSelWithSelIndex:(NSUInteger)index SelText:(NSString *)str;
@end
@interface ZXTextSwitchView : UIView
/**
*TextSwitchView背景色（默认白）
*/
@property(nonatomic,strong)UIColor *mainBacColor;

/**
 *TextSwitchView选中背景色（默认红）
 */
@property(nonatomic,strong)UIColor *selectedBacColor;

/**
 *TextSwitchView默认文字颜色（默认黑）
 */
@property(nonatomic,strong)UIColor *mainTextColor;

/**
 *TextSwitchView选中文字颜色（默认白）
 */
@property(nonatomic,strong)UIColor *selectedTextColor;

/**
 *TextSwitchView字体 （默认大小为15）
 */
@property(nonatomic,strong)UIFont *textFont;

/**
 *TextSwitchView切换动画时间 （默认0.1 * TextSwitchView子项个数）
 */
@property(nonatomic,assign)CGFloat animateDuration;

/**
 *TextSwitchView选中索引（默认0）
 */
@property(nonatomic,assign)int selectIndex;

/**
 *TextSwitchView数据源
 */
@property(nonatomic,strong)NSMutableArray *dataSource;

/**
 *TextSwitchView代理
 */
@property(nonatomic,copy)id<ZXTextSwitchViewDelegate> delegate;

/**
 *TextSwitchView block
 */
@property (nonatomic, copy) void (^selChangedBlock)(NSUInteger selIndex, NSString *selText);

//类方法初始化
+(instancetype)textSwitchView;
@end
