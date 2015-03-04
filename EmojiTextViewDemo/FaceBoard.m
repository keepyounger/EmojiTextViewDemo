//
//  FaceBoard.m
//  utt
//
//  Created by lixy on 14/11/4.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#import "FaceBoard.h"
#import "UIKit+BaseExtension.h"

#define FaceBtnSize    44
#define FaceTotalCount 85

@implementation FaceBoard

- (id)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, 216)];
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, 216)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithR:236 G:236 B:236];
    
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faceMap_ch" ofType:@"plist"]];
    
    NSInteger rowNum = 4;
    NSInteger cluNum = 7;
    CGFloat paddingWith = 6;
    switch ([UIDevice iphoneType]) {
        case IPhone6:
        {
            cluNum = 8;
            paddingWith = 12.5;
        }
            break;
        case IPhone6P:
        {
            cluNum = 9;
            paddingWith = 9;
        }
            break;
            
        default:
            break;
    }
    
    NSInteger pageCount = rowNum * cluNum;

    
    //表情盘
    _faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 190)];
    _faceView.pagingEnabled = YES;
    _faceView.contentSize = CGSizeMake((FaceTotalCount / pageCount + 1) * MainScreenWidth, 190);
    _faceView.showsHorizontalScrollIndicator = NO;
    _faceView.showsVerticalScrollIndicator = NO;
    _faceView.delegate = self;
    
    for (int i = 1; i <= FaceTotalCount; i++) {
        
        UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        faceButton.tag = i;
        faceButton.imageView.contentMode = UIViewContentModeCenter;
        [faceButton addTarget:self
                       action:@selector(faceButton:)
             forControlEvents:UIControlEventTouchUpInside];
        
        //计算每一个表情按钮的坐标和在哪一屏
        CGFloat x = (((i - 1) % pageCount) % cluNum) * FaceBtnSize + paddingWith + ((i - 1) / pageCount * MainScreenWidth);
        CGFloat y = (((i - 1) % pageCount) / cluNum) * FaceBtnSize + 8;
        faceButton.frame = CGRectMake( x, y, FaceBtnSize, FaceBtnSize);
        
        [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",i]]
                    forState:UIControlStateNormal];
        
        [_faceView addSubview:faceButton];
    }
    
    //添加PageControl
    _facePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(MainScreenWidth/2-120, 190, 100, 20)];
    _facePageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    _facePageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [_facePageControl addTarget:self
                         action:@selector(pageChange:)
               forControlEvents:UIControlEventValueChanged];
    
    _facePageControl.numberOfPages = FaceTotalCount / pageCount + 1;
    _facePageControl.currentPage = 0;
    [self addSubview:_facePageControl];
    
    //添加键盘View
    [self addSubview:_faceView];
    
    //删除键
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"backFace"] forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"backFaceSelect"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(MainScreenWidth-60, 182, 50, 27);
    back.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:back];
    
    //发送键
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [send setBackgroundColor:[UIColor greenColor]];
    send.layer.cornerRadius = 3;
    [send addTarget:self action:@selector(sendMSG) forControlEvents:UIControlEventTouchUpInside];
    send.frame = CGRectMake(MainScreenWidth-120, 182, 50, 28);
    [self addSubview:send];
}

//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_facePageControl setCurrentPage:_faceView.contentOffset.x / MainScreenWidth];
}

- (void)pageChange:(id)sender
{
    [_faceView setContentOffset:CGPointMake(_facePageControl.currentPage * MainScreenWidth, 0) animated:YES];
    [_facePageControl setCurrentPage:_facePageControl.currentPage];
}

- (void)faceButton:(UIButton*)sender
{
    if (self.inputTextView.text.length == 0) {
        self.inputTextView.text = @"";
    }
    
    int i = (int)sender.tag;
    
    [self.inputTextView insertFaceWithImageName:[NSString stringWithFormat:@"%03d",i] des:_faceMap[[NSString stringWithFormat:@"%03d",i]]];
    
}

- (void)backFace
{
    [self.inputTextView backFace];
}

- (void)sendMSG
{
    if (_delegage && [_delegage respondsToSelector:@selector(sendMessage)]) {
        
        [_delegage sendMessage];
        
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
