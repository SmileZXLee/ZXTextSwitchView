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
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    ZXTextSwitchView *switchView = [ZXTextSwitchView textSwitchView];
    switchView.frame = CGRectMake(0, 100, ScreenW, BottomViewH);
    switchView.selectIndex = 3;
    switchView.selectedBacColor = [UIColor orangeColor];
    switchView.dataSource = self.switchArr;
    [self.view addSubview:switchView];
    
    UILabel *msgLabel = [[UILabel alloc]init];
    msgLabel.frame = CGRectMake(0, CGRectGetMaxY(switchView.frame) + 10, ScreenW, 20);
    msgLabel.adjustsFontSizeToFitWidth = YES;
    msgLabel.textColor = [UIColor redColor];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:msgLabel];
    
    [switchView setSelChangedBlock:^(NSUInteger selIndex, NSString *selText) {
        msgLabel.text = [NSString stringWithFormat:@"SelectedIndex--%lu SelectedText--%@",selIndex,selText];
    }];
}
#pragma mark - 设置数据
-(void)setData{
    [self.switchArr addObject:@"Apple"];
    [self.switchArr addObject:@"西红柿"];
    [self.switchArr addObject:@"葡萄干"];
    [self.switchArr addObject:@"甜哈密瓜"];
    [self.switchArr addObject:@"菠萝蜜"];
    
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

