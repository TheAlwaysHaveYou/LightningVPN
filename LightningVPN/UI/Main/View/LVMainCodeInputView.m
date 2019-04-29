//
//  LVMainCodeInputView.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "LVMainCodeInputView.h"

@interface LVMainCodeInputView () <UITextViewDelegate>

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) NSMutableArray <CAShapeLayer *> *lineArr;
@property(nonatomic,strong) NSMutableArray <UILabel *> *labelArr;

@property(nonatomic , assign)NSInteger inputNum;

@end

@implementation LVMainCodeInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineArr = [[NSMutableArray alloc] init];
        self.labelArr = [[NSMutableArray alloc] init];
        
        self.inputNum = 4;
        self.codeNumberStr = @"";
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.textView = [[UITextView alloc] initWithFrame:self.bounds];
    self.textView.tintColor = [UIColor clearColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor clearColor];
    self.textView.delegate = self;
    self.textView.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.textView];
    
    CGFloat space = FITSCALE(8);
    CGFloat w = (self.frame.size.width-space*3)/self.inputNum;
    CGFloat h = CGRectGetHeight(self.frame);

    for (int i = 0; i < self.inputNum; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((w+space)*i, 0, w, h)];
        label.userInteractionEnabled = NO;
        label.font = FitBorderFont(22);
        label.textColor = kColor_404852;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = kColor_BBC2D1;
        label.layer.cornerRadius = FITSCALE(10);
        label.layer.masksToBounds = YES;
        [self addSubview:label];
        
//        //光标
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(w / 2, 15, 2, h - 30)];
//        CAShapeLayer *line = [CAShapeLayer layer];
//        line.path = path.CGPath;
//        line.fillColor =  [UIColor darkGrayColor].CGColor;
//
//        [label.layer addSublayer:line];
//        if (i == 0) {
//            [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
//            //高亮颜色
//            line.hidden = NO;
//        }else {
//            line.hidden = YES;
//        }
//        [self.lineArr addObject:line];
        
        [self.labelArr addObject:label];
    }
}
#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return [text matchesRegex:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive];//只能输入数字
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *verStr = textView.text;
    
    if (verStr.length > self.inputNum) {
        textView.text = [textView.text substringToIndex:self.inputNum];
    }
    
    //大于等于最大值时, 结束编辑
    if (verStr.length >= self.inputNum) {
        [self endEdit];
    }
    
    self.codeNumberStr = textView.text;
    
    for (int i = 0; i < self.labelArr.count; i ++) {
        UILabel *bgLabel = self.labelArr[i];
        
        if (i < verStr.length) {
//            [self changeViewLayerIndex:i linesHidden:YES];
            bgLabel.text = [verStr substringWithRange:NSMakeRange(i, 1)];
        }else {
//            [self changeViewLayerIndex:i linesHidden:i == verStr.length ? NO : YES];
            
            //textView的text为空的时候
            if (!verStr && verStr.length == 0) {
//                [self changeViewLayerIndex:0 linesHidden:NO];
            }
            bgLabel.text = @"";
        }
    }
}

- (void)endEdit {
    [self.textView resignFirstResponder];
}

- (void)clean {
    self.textView.text = @"";
    self.codeNumberStr = @"";
    [self.labelArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = @"";
    }];
}

//设置光标显示隐藏
- (void)changeViewLayerIndex:(NSInteger)index linesHidden:(BOOL)hidden {
    CAShapeLayer *line = self.lineArr[index];
    if (hidden) {
        [line removeAnimationForKey:@"kOpacityAnimation"];
    }else{
        [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
    }
    [UIView animateWithDuration:0.25 animations:^{
        line.hidden = hidden;
    }];
}

//闪动动画
- (CABasicAnimation *)opacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.9;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}

@end
