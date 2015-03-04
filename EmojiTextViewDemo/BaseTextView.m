//
//  BaseTextView.m
//  utt
//
//  Created by lixy on 14/10/8.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import "BaseTextView.h"
#import "MMTextAttachment.h"

#define LeftPadding 5
#define TopPadding  8
#define LineHeight  13.8
#define FontSize    12

@implementation BaseTextView

+ (instancetype)textViewWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    BaseTextView *btv = [[BaseTextView alloc] initWithFrame:frame];
    [btv setPlaceholder:placeholder];
    [btv initCommonUI];
    return btv;
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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = .5;
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.frame = CGRectMake(LeftPadding, TopPadding, self.frame.size.width-LeftPadding*2, LineHeight);
        _placeholderLabel.font = [UIFont systemFontOfSize:FontSize];
        [self addSubview:_placeholderLabel];
    }
    
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString*)placeholder
{
    self.placeholderLabel.frame = CGRectMake(LeftPadding, TopPadding, self.frame.size.width-LeftPadding*2, LineHeight);
    self.placeholderLabel.text = placeholder;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    if (_placeholderLabel) {
        _placeholderLabel.font = font;
        _placeholderLabel.frame = CGRectMake(LeftPadding, TopPadding, self.frame.size.width-LeftPadding*2, font.lineHeight);
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholderView];
    //[self resizeText];
    [self performSelector:@selector(resizeText) withObject:nil afterDelay:.05];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self refreshPlaceholderView];
    [self performSelector:@selector(resizeText) withObject:nil afterDelay:.05];
}

- (void)refreshPlaceholderView
{
    if (_placeholderLabel) {
        if (self.text.length || self.attributedText.length) {
            _placeholderLabel.hidden = YES;
        } else {
            _placeholderLabel.hidden = NO;
        }
    }
}

- (void)resizeText
{
    [self.delegate textViewDidChange:self];
}

- (NSString *)faceStr
{
    __block NSString *faceStr = @"";
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        if (attrs[@"NSAttachment"]) {
            MMTextAttachment *mta = attrs[@"NSAttachment"];
            
            faceStr = [faceStr stringByAppendingString:mta.faceStr];
            
        } else {
            
            faceStr = [faceStr stringByAppendingString:[self.attributedText attributedSubstringFromRange:range].string];
        }
        
    }];
    
    return faceStr;
}


- (void)backFace
{
    if (self.attributedText.length == 0) {
        return;
    }
    
    if (self.selectedRange.length == 0) {
        
        if (self.selectedRange.location == 0) {
            return;
        }
        
        int length = 1;
        NSDictionary *dic = [self.attributedText attributesAtIndex:self.selectedRange.location-1 effectiveRange:nil];
        UIFont *font = dic[@"NSFont"];
        
        if ([font.familyName isEqualToString:@"Apple Color Emoji"]) {
            length = 2;
        }
        
        [self backFaceWithRange:NSMakeRange(self.selectedRange.location - length, length)];
    } else {
        [self backFaceWithRange:self.selectedRange];
    }
}

- (void)backFaceWithRange:(NSRange)range
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText replaceCharactersInRange:range withString:@""];
    
    self.attributedText = attributedText;
    
    if (self.attributedText.length == 0) {
        return;
    }
    
    self.selectedRange = NSMakeRange(range.location, 0);

}

- (void)insertFaceWithImageName:(NSString *)imageName des:(NSString *)des
{
    NSInteger currentLoc = self.selectedRange.location;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    MMTextAttachment* textAttachment = [[ MMTextAttachment alloc ] initWithData:nil ofType:nil];
    textAttachment.faceStr = des;
    
    UIImage *emImage =  [UIImage imageNamed:imageName];
    textAttachment.image = emImage ;
    
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [attributedText insertAttributedString:textAttachmentString atIndex:currentLoc];
    
    self.attributedText = attributedText;
    
    self.selectedRange = NSMakeRange(currentLoc+1, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
