//
//  MMTextAttachment.m
//  EmojiTextViewDemo
//
//  Created by lixy on 15/3/4.
//  Copyright (c) 2015年 lixy. All rights reserved.
//

#import "MMTextAttachment.h"

@implementation MMTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0)
{
    return CGRectMake(0, -2, lineFrag.size.height, lineFrag.size.height);
}

@end
