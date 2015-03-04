//
//  FaceBoard.h
//  utt
//
//  Created by lixy on 14/11/4.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTextView.h"

@protocol FaceBoardDelegate <NSObject>

- (void)sendMessage;

@end

@interface FaceBoard : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIScrollView *faceView;
@property (nonatomic, strong, readonly) UIPageControl *facePageControl;
@property (nonatomic, strong, readonly) NSDictionary *faceMap;

@property (nonatomic, weak) BaseTextView *inputTextView;

@property (nonatomic) __weak id<FaceBoardDelegate> delegage;

@end
