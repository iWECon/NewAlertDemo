//
//  IWTipsView.m
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import "IWNewAlert.h"


typedef NS_ENUM(int, ButtonTitleFontSize) {
    
    SmallSizeForBtn       = 14,
    NormalSizeForBtn      = 17,
    BigSizeForBtn         = 20
    
};

typedef NS_ENUM(int, ContentLabelFontSize) {
    
    SmallSizeForContentLabel       = 12,
    NormalSizeForContentLabel      = 14,
    BigSizeForContentLabel         = 16
    
};


@interface IWNewAlert ()

@property (nonatomic, strong) cancelBlock cancelAction;
@property (nonatomic, strong) okBlock okAction;


@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UIButton* confirmBtn;
@property (nonatomic, strong) UILabel* contentLabel;

@property ButtonTitleFontSize fontSizeForBtn;
@property ContentLabelFontSize fontSizeForLab;

@property UIView * rootView;
@property UIView * windowView;
@property CGRect windowFrame;

@end


@implementation IWNewAlert


#pragma mark- 初始化内容
+ (instancetype)setTipsContentWithContent:(NSString *)content calcelAction:(cancelBlock)cancelBlock okAction:(okBlock)okBlock {
    IWNewAlert * tip = [[IWNewAlert alloc] initWithFrame:CGRectMake(0, 0, 240, 98)];
    [tip showTips:content cancelTarget:cancelBlock okTarget:okBlock];
    
    return tip;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self createWidget];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createWidget];
    }
    return self;
}

- (void)createWidget {
    
    self.windowView = [UIApplication sharedApplication].windows.firstObject;
    self.windowFrame = [[UIScreen mainScreen] bounds];
    
    // 修改字体大小
    self.fontSizeForBtn = SmallSizeForBtn;
    self.fontSizeForLab = NormalSizeForContentLabel;
    
    
    self.alpha = 0;
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置圆角
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = NO;
    
    // 添加观察者 用于自适应
    [self.contentLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


#pragma mark override get method
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 215, 49)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:self.fontSizeForLab];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(183, 65, 49, 27)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontSizeForBtn];
        
        [_confirmBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confirmBtn];
    }
    return _confirmBtn;
}


- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(126, 65, 49, 27)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:self.fontSizeForBtn];
        
        [_cancelBtn addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}


#pragma mark- kvo 计算视图大小
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    
    NSString * str = change[@"new"];
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:self.fontSizeForLab]};
    CGSize strSize = [str sizeWithAttributes:attributes];
    CGPoint tlPoint = self.contentLabel.frame.origin;
    CGRect tipsRect = CGRectMake(tlPoint.x, tlPoint.y, strSize.width, strSize.height);
    self.contentLabel.frame = tipsRect;
    
    
    CGRect cancelFrame = self.cancelBtn.frame;
    cancelFrame.origin.y = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 5;
    self.cancelBtn.frame = cancelFrame;
    
    CGRect confirmFrame = self.confirmBtn.frame;
    confirmFrame.origin.y = self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height + 5;
    self.confirmBtn.frame = confirmFrame;
    
    
    // 新的视图大小
    CGRect newRect = self.frame;
    
    newRect.size = CGSizeMake(self.windowFrame.size.width/4*3, self.confirmBtn.frame.origin.y + self.confirmBtn.frame.size.height + 5);
    
    confirmFrame = self.cancelBtn.frame;
    confirmFrame.origin.x = newRect.size.width - self.confirmBtn.frame.size.width - 20;
    self.confirmBtn.frame = confirmFrame;
    
    cancelFrame = self.confirmBtn.frame;
    cancelFrame.origin.x = self.confirmBtn.frame.origin.x - self.confirmBtn.frame.size.width - 8;
    self.cancelBtn.frame = cancelFrame;
    
    
    
    
    self.frame = newRect;
    
    
    
    CGSize windowSize = self.windowFrame.size;
    self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                            windowSize.height/2 - self.frame.size.height/2,
                            self.frame.size.width,
                            self.frame.size.height + 5);
}

#pragma mark- kvo 释放
- (void)dealloc {
    [self.contentLabel removeObserver:self forKeyPath:@"text"];
}


#pragma mark- 初始化 设置显示信息
- (void)showTips:(NSString *)content cancelTarget:(cancelBlock)cancelBlock okTarget:(okBlock)okBlock {
    
    self.contentLabel.text = content;
    self.cancelAction = cancelBlock;
    self.okAction = okBlock;
    
}


#pragma mark cancel按钮事件
- (void)cancelEvent {
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self resetAnimate];
}

#pragma mark ok按钮事件
- (void)confirmEvent {
    if (self.okAction) {
        self.okAction();
    }
    [self resetAnimate];
}

#pragma mark 重置动画/隐藏/移除动画图层
- (void)resetAnimate {
    [self resetBlurBackgournd];
    [self resetScale];
    [self hide];
}


#pragma mark 显示alert, 计算内容大小
- (void)show {
    [self setBlurBackgounrd];
    [self.windowView addSubview:self];
    [self setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.alpha = 1;
        [self setTransform:CGAffineTransformMakeScale(1, 1)];
        
        
    } completion:^(BOOL finished) {
    }];
    
}
- (void)showWithScaleCurrentView:(UIView *)view {
    self.rootView = view;
    [self scaleView];
    [self show];
}


#pragma mark 模糊图层
- (void)setBlurBackgounrd {
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    effectView.frame = self.windowView.frame;
    effectView.alpha = 0;
    [self.windowView addSubview:effectView];
    
    // 添加点击事件
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurBackgroundTapAction)];
    [effectView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        effectView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (void)blurBackgroundTapAction {
    [self cancelEvent];
}

- (void)resetBlurBackgournd {
    UIVisualEffectView * effectView;
    for (UIView * effect in self.windowView.subviews) {
        if ([effect isKindOfClass:[UIVisualEffectView class]]) {
            effectView = (UIVisualEffectView *)effect;
            break;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        effectView.alpha = 0.01;
    } completion:^(BOOL finished) {
        [effectView removeFromSuperview];
    }];
}

#pragma mark 隐藏
- (void)hide {
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
        
        [self setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark- 缩放动画
// 缩放
- (void)scaleView {
    CGFloat scalePoint = 0.93;
    [self doScale:scalePoint];
}
// 重置
- (void)resetScale {
    CGFloat scalePoint = 1.0;
    [self doScale:scalePoint];
}
// 做动画
- (void)doScale:(CGFloat)scalePoint {
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.rootView.transform = CGAffineTransformMakeScale(scalePoint, scalePoint);
    } completion:^(BOOL finished) {
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
