//
//  UIButton+Extension.m
//  LightningVPN
//
//  Created by 范魁东 on 2019/4/29.
//  Copyright © 2019 FKD. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setImageDirection:(ImageDirection)direction {
    [self setImageDirection:direction withSpan:0];
}

- (void)setImageDirection:(ImageDirection)direction withSpan:(float)span {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (direction) {
        case TOP:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-span/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-span/2.0, 0);
        }
            break;
        case LEFT:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -span/2.0, 0, span/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, span/2.0, 0, -span/2.0);
        }
            break;
        case BOTTOM:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-span/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-span/2.0, -imageWith, 0, 0);
        }
            break;
        case RIGHT:
        {
            if (self.bounds.size.width==0) {//没有宽度的时候 （layout布局 ）
                
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+span/2.0, 0, -labelWidth-span/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-span/2.0, 0, imageWith+span/2.0);
            }else if (labelWidth+imageWith<self.bounds.size.width) {
                
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+span/2.0, 0, -labelWidth-span/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-span/2.0, 0, imageWith+span/2.0);
            }else{//图片优先 可能还有问题
                
                imageEdgeInsets = UIEdgeInsetsMake(0, (self.bounds.size.width-imageWith)+span/2.0, 0, 0);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-span/2.0, 0, imageWith+span/2.0);
            }
            
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
