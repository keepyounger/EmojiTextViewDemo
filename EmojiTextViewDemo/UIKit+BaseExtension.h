//
//  UIKit+BaseExtension.h
//  utt
//
//  Created by lixy on 14/10/17.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseDefine.h"

typedef enum : NSUInteger {
    IPhone4 = 1,
    IPhone5,
    IPhone6,
    IPhone6P
} IPhoneType;

@interface UIView (baseExtension)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGSize  size;
@property (nonatomic) CGPoint origin;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic, readonly) CGRect screenFrame;

@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;

@end

@interface UIColor (baseExtension)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

@end

@interface UIImage (baseExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@interface UIDevice (baseExtensions)

+ (IPhoneType)iphoneType;

@end