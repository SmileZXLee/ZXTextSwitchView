//
//  ViewController.m
//  ZXTextSwitchViewDemo
//
//  Created by 李兆祥 on 2017/12/24.
//  Copyright © 2017年 李兆祥. All rights reserved.
//  ContactWay QQ:393727164

#import "ViewController.h"
#import "ZXTextSwitchView.h"
//屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height
//TextSwitchView高度
#define BottomViewH 50

@interface ViewController ()
//所有项数组
@property(nonatomic,strong)NSMutableArray *switchArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
}
#pragma mark - 初始化UI
-(void)setUI{
    self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    ZXTextSwitchView *switchView = [ZXTextSwitchView textSwitchView];
    switchView.frame = CGRectMake(0, 100, ScreenW, BottomViewH);
    switchView.selectIndex = 3;
    switchView.selectedBacColor = [UIColor orangeColor];
    switchView.dataSource = self.switchArr;
    [switchView setSelChangedBlock:^(NSUInteger selIndex, NSString *selText) {
        NSLog(@"%@",[NSString stringWithFormat:@"SelectedIndex--%lu SelectedText--%@",selIndex,selText]);
    }];
    [self.view addSubview:switchView];
}
#pragma mark - 设置数据
-(void)setData{
    [self.switchArr addObject:@"Man"];
    [self.switchArr addObject:@"Woman"];
    [self.switchArr addObject:@"Other"];
    
}
#pragma mark - 懒加载
-(NSMutableArray *)switchArr{
    if(!_switchArr){
        _switchArr = [NSMutableArray array];
    }
    return _switchArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

