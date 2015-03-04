//
//  BaseTextView.h
//  utt
//
//  Created by lixy on 14/10/8.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextView : UITextView

@property (nonatomic, strong) UILabel *placeholderLabel;//提示文字Label

@property (nonatomic, strong, readonly) NSString *faceStr;

+ (instancetype)textViewWithFrame:(CGRect)frame placeholder:(NSString*)placeholder;
- (void)refreshPlaceholderView;

- (void)insertFaceWithImageName:(NSString*)imageName des:(NSString*)des;
- (void)backFace;

@end
