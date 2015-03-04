//
//  BaseButton.m
//  utt
//
//  Created by lixy on 14/10/8.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title
{
    BaseButton *bb = [[BaseButton alloc] initWithFrame:frame];
    [bb setTitle:title forState:UIControlStateNormal];
    [bb initCommonUI];
    return bb;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCommonUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommonUI];
    }
    return self;
}

//设置公共属性
- (void)initCommonUI
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
