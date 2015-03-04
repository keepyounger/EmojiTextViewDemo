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

@interface BaseInputBar : UIView

@property (nonatomic, strong, readonly) BaseTextView *inputView;

@property (nonatomic, strong) BaseButton *faceTurnBtn;

@property (nonatomic, strong, readonly) FaceBoard *faceBoard;

@end
