//
//  ZXTextSwitchView.m
//  ZXTextSwitchViewDemo
//
//  Created by 李兆祥 on 2017/12/24.
//  Copyright © 2017年 李兆祥. All rights reserved.
//  ContactWay QQ:393727164

#import "ZXTextSwitchView.h"
#import <UIKit/UIKit.h>
@interface ZXTextSwitchView()
//选中的View
@property(nonatomic,weak)UIView *switchView;
@end
@implementation ZXTextSwitchView
+(instancetype)textSwitchView{
    return [[self alloc]init];
}
-(instancetype)init{
    if(self = [super init]){
        self.backgroundColor = _mainBacColor ? _mainBacColor : [UIColor whiteColor];
    }
    return self;
    
}
#pragma mark - switchView手势
- (void)switchViewPan:(UIPanGestureRecognizer*) recognizer
{
    CGFloat tempX = self.switchView.center.x;
    CGPoint translation = [recognizer translationInView:self.switchView.superview];
    //限制左右两边位置，避免越界
    if(tempX < self.switchView.frame.size.width / 2 ){
        //最左侧
        if(translation.x < 0){
            //左移 返回
            return;
        }
    }
    if(tempX > self.frame.size.width - self.switchView.frame.size.width / 2){
        //最右侧
        if(translation.x > 0){
            //右移 返回
            return;
        }
    }
    [self resetSwitchLabelFrameWithChangeX:translation.x];
    //设置switchView位置
    self.switchView.center = CGPointMake(tempX + translation.x,self.frame.size.height / 2);
    //置0
    [recognizer setTranslation:CGPointZero inView:self.switchView.superview];
    //拖动结束
    if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        //设置当前选中的index
        CGFloat switchLabelW = self.frame.size.width / self.dataSource.count;
        int selIndex = tempX / switchLabelW;
        [UIView animateWithDuration:_animateDuration animations:^{
            [self setSelectWithSelectIndex:selIndex];
        }];
    }
}

#pragma mark - bottomLabel手势
- (void)bottomLabelTap:(UIPanGestureRecognizer*) recognizer{
    //切换选中项
    [UIView animateWithDuration:_animateDuration animations:^{
        [self setSelectWithSelectIndex:(int)recognizer.view.tag];
    }];
}

#pragma makr - Private
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    if(!_dataSource.count)return;
    _animateDuration = _animateDuration > 0 ? _animateDuration : 0.1 * self.dataSource.count;
    //添加底部SwitchLabel
    CGFloat switchLabelW = self.frame.size.width / self.dataSource.count;
    CGFloat switchLabelH = self.frame.size.height;
    for(int i = 0; i < self.dataSource.count; i++){
        UILabel *bottomLabel = [[UILabel alloc]init];
        bottomLabel.frame = CGRectMake(i * switchLabelW, 0, switchLabelW, switchLabelH);
        bottomLabel.text = self.dataSource[i];
        bottomLabel.textColor = _mainTextColor ? _mainTextColor : [UIColor blackColor];
        bottomLabel.font = _textFont ? _textFont : [UIFont systemFontOfSize:15];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.userInteractionEnabled = YES;
        bottomLabel.tag = i;
        [bottomLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomLabelTap:)]];
        [self addSubview:bottomLabel];
    }
    
    //添加红色的switchView
    UIView *switchView = [[UIView alloc]init];
    switchView.frame = CGRectMake((self.dataSource.count - 1) * switchLabelW, 0, switchLabelW, switchLabelH);
    switchView.backgroundColor = _selectedBacColor ? _selectedBacColor : [UIColor redColor];
    //裁剪掉超出父控件部分
    switchView.clipsToBounds = YES;
    [self addSubview:switchView];
    //比较懒这边就没有抽出来封装了 同上 将白色switchLabel添加到红色SwitchView上面
    
    for(int i = 0; i < self.dataSource.count; i++){
        UILabel *switchLabel = [[UILabel alloc]init];
        switchLabel.frame = CGRectMake((i + 1 - (int)self.dataSource.count) * switchLabelW , 0, switchLabelW, switchLabelH);
        switchLabel.text = self.dataSource[i];
        switchLabel.textColor = _selectedTextColor ? _selectedTextColor : [UIColor whiteColor];
        switchLabel.font = _textFont ? _textFont : [UIFont systemFontOfSize:15];
        switchLabel.textAlignment = NSTextAlignmentCenter;
        [switchView addSubview:switchLabel];
    }
    
    //switchView添加手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(switchViewPan:)];
    [switchView addGestureRecognizer:panGestureRecognizer];
    self.switchView = switchView;
    
    //默认选中
    _selectIndex = _selectIndex > 0 && _selectIndex < _dataSource.count ?  _selectIndex : 0;
    [self setSelectWithSelectIndex:_selectIndex];
    
}
//传入switchView改变的距离 同时改变switchLabel的位置 以确保switchLabel相对于控制器位置不变 或使用转换坐标系亦可
-(void)resetSwitchLabelFrameWithChangeX:(CGFloat)changeX{
    //遍历switchView子控件固定内部白色Label相对于屏幕的位置
    for(int i = 0; i< self.switchView.subviews.count; i++){
        UIView *subView = self.switchView.subviews[i];
        if([subView isKindOfClass:[UILabel class]]){
            CGRect rect = subView.frame;
            rect.origin.x -= changeX;
            subView.frame = rect;
        }
    }
}
//传入选中的index 改变选中状态
-(void)setSelectWithSelectIndex:(int)index{
    CGFloat switchLabelW = self.frame.size.width / self.dataSource.count;
    [self resetSwitchLabelFrameWithChangeX:(switchLabelW * index + 0.5 * switchLabelW - self.switchView.center.x)];
    self.switchView.center = CGPointMake(switchLabelW * index + 0.5 * switchLabelW, self.frame.size.height / 2);
    if([self.delegate respondsToSelector:@selector(textSwitchView:didChangedSelWithSelIndex:SelText:)]){
        [self.delegate textSwitchView:self didChangedSelWithSelIndex:index SelText:((UILabel*)self.switchView.subviews[index]).text];
    }
    !self.selChangedBlock ? :self.selChangedBlock(index,((UILabel*)self.switchView.subviews[index]).text);
}

@end
