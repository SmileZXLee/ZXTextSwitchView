# ZXTextSwitchView
## 预览
![Image text](http://www.zxlee.cn/ZXTextSwitchViewDemo.gif)

***
## 初始化&偏好设置
```objective-c
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
```  
