//
//  BaserInputBar.h
//  utt
//
//  Created by lixy on 14/11/5.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBoard.h"
#import "BaseButton.h"

@protocol BaseInputBarDelegate <NSObject>

- (void)sendMessageWithMsg:(NSString*)msg;

@end

@interface BaseInputBar : UIView

@property (nonatomic, strong, readonly) BaseTextView *inputView;

@property (nonatomic, strong, readonly) FaceBoard *faceBoard;
@property (nonatomic, strong, readonly) UIView *voiceBoard;
@property (nonatomic, strong, readonly) UIView *fileBoard;

@property (nonatomic, strong, readonly) BaseButton *faceTurnBtn;
@property (nonatomic, strong, readonly) BaseButton *voiceTurnBtn;
@property (nonatomic, strong, readonly) BaseButton *fileTurnBtn;

@property (nonatomic) __weak id<BaseInputBarDelegate> delegage;

@end
