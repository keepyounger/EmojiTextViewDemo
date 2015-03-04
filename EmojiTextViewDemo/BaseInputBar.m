//
//  BaserInputBar.m
//  utt
//
//  Created by lixy on 14/11/5.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import "BaseInputBar.h"
#import "BaseDefine.h"
#import "UIKit+BaseExtension.h"

@interface BaseInputBar ()<UITextViewDelegate, FaceBoardDelegate>

@property (nonatomic, strong) UIView *inputAccessoryView;

@end

@implementation BaseInputBar

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, 40)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, 40)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _inputView = [BaseTextView textViewWithFrame:CGRectMake(50, 5, MainScreenWidth-150, 30)
                                     placeholder:NSLocalizedString(@"在此输入聊天内容...", @"在此输入聊天内容...")];
    _inputView.backgroundColor = [UIColor whiteColor];
    _inputView.returnKeyType = UIReturnKeySend;
    
    _faceBoard = [[FaceBoard alloc] init];
    _faceBoard.inputTextView = _inputView;
    _faceBoard.delegage = self;
    
    _inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _inputAccessoryView.backgroundColor = [UIColor clearColor];
    _inputAccessoryView.userInteractionEnabled = NO;
    _inputView.inputAccessoryView = _inputAccessoryView;
    
    _voiceBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 216)];
    
    _fileBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 216)];
    
    _inputView.delegate = self;
    
    _voiceTurnBtn = [BaseButton buttonWithFrame:CGRectMake(5, 5, 40, 30) title:@"录音"];
    [_voiceTurnBtn setTitle:@"键盘" forState:UIControlStateSelected];
    [_voiceTurnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_voiceTurnBtn addTarget:self action:@selector(turnVoiceBoard:) forControlEvents:UIControlEventTouchUpInside];
    
    _faceTurnBtn = [BaseButton buttonWithFrame:CGRectMake(MainScreenWidth-95, 5, 40, 30) title:@"表情"];
    [_faceTurnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_faceTurnBtn setTitle:@"键盘" forState:UIControlStateSelected];
    [_faceTurnBtn addTarget:self action:@selector(turnFaceBoard:) forControlEvents:UIControlEventTouchUpInside];
    
    _fileTurnBtn = [BaseButton buttonWithFrame:CGRectMake(MainScreenWidth-45, 5, 40, 30) title:@"文件"];
    [_fileTurnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_fileTurnBtn setTitle:@"键盘" forState:UIControlStateSelected];
    [_fileTurnBtn addTarget:self action:@selector(fileFaceBoard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_voiceTurnBtn];
    [self addSubview:_faceTurnBtn];
    [self addSubview:_inputView];
    [self addSubview:_fileTurnBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillHide
{
    _faceTurnBtn.selected = NO;
    _voiceTurnBtn.selected = NO;
    _fileTurnBtn.selected = NO;
    _inputView.inputView = nil;
}

- (void)turnFaceBoard:(BaseButton*)btn
{
    btn.selected = !btn.selected;
    
    _voiceTurnBtn.selected = NO;
    _fileTurnBtn.selected = NO;
    
    if (_inputView.inputView == _faceBoard) {
        _inputView.inputView = nil;
    } else {
        [_inputView becomeFirstResponder];
        _inputView.inputView = _faceBoard;
    }
    
    [_inputView reloadInputViews];
}

- (void)turnVoiceBoard:(BaseButton*)btn
{
    btn.selected = !btn.selected;
    
    _faceTurnBtn.selected = NO;
    _fileTurnBtn.selected = NO;
    
    if (_inputView.inputView == _voiceBoard) {
        _inputView.inputView = nil;
    } else {
        
        [_inputView becomeFirstResponder];
        _inputView.inputView = _voiceBoard;
    }
    
    [_inputView reloadInputViews];
}

- (void)fileFaceBoard:(BaseButton*)btn
{
    btn.selected = !btn.selected;
    
    _voiceTurnBtn.selected = NO;
    _faceTurnBtn.selected = NO;
    
    if (_inputView.inputView == _fileBoard) {
        _inputView.inputView = nil;
    } else {
        
        [_inputView becomeFirstResponder];
        _inputView.inputView = _fileBoard;
    }
    
    [_inputView reloadInputViews];
}


- (void)textViewDidChange:(BaseTextView *)textView
{
    [textView refreshPlaceholderView];
    
    static NSInteger padding = 16;
    static NSInteger maxLineNum = 3;
    static NSInteger dertaPadding = 4;
    
    NSInteger lineNum = (textView.contentSize.height-padding)/textView.font.lineHeight;
    
    CGFloat currentHeight = textView.height;
    CGFloat height = currentHeight;
    
    if (lineNum > maxLineNum) {
        
        textView.contentInset = UIEdgeInsetsMake(-dertaPadding, 0, -dertaPadding, 0);
        
        //textView.height = textView.font.lineHeight*(maxLineNum+1)+dertaPadding;
        height = textView.font.lineHeight*(maxLineNum+1)+dertaPadding;
        [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-textView.font.lineHeight, textView.contentSize.width, textView.font.lineHeight) animated:NO];
        
    } else {
        
        textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        //textView.height = textView.contentSize.height;
        height = textView.contentSize.height;
        [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-textView.font.lineHeight, textView.contentSize.width, textView.font.lineHeight) animated:NO];
    }
    
    CGFloat detaHeight = currentHeight-height;
    self.top += detaHeight;
    self.height -= detaHeight;
    textView.height = self.height - 10;
    
    if (_inputAccessoryView.height != self.height) {
        _inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.height)];
        _inputAccessoryView.backgroundColor = [UIColor clearColor];
        _inputAccessoryView.userInteractionEnabled = NO;
        textView.inputAccessoryView = _inputAccessoryView;
        [textView reloadInputViews];
    }
    
}

- (BOOL)textView:(BaseTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage];
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark ---FaceBoardDelegate---
- (void)sendMessage
{
    
    if (_delegage && [_delegage respondsToSelector:@selector(sendMessageWithMsg:)]) {
        
        [_delegage sendMessageWithMsg:self.inputView.faceStr];
        _inputView.text = @"";
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
