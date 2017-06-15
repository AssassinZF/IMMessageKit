//
//  ZFKeyboardViewController.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/15.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "ZFKeyboardViewController.h"
#import "ChatViewController.h"
#import "LXChatBoxMoreView.h"
#import "LXChatBoxFaceView.h"


@interface ZFKeyboardViewController ()<ZFKeyboardInputViewDelegate,LXChatBoxMoreViewDelegate>
{
    CGFloat Keyboard_H;//当前键盘的高度
    CGFloat keyboardDuration;//键盘动画时间
}

@property(nonatomic,strong)LXChatBoxMoreView *moreView;//more view
@property (nonatomic, strong)LXChatBoxFaceView *faceView;//表情view

@property (nonatomic, strong)ZFKeyboardInputView *keyboardInputView;
@end

@implementation ZFKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.keyboardInputView];
    [self.keyboardInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(HEIGHT_TABBAR));
    }];
    [self addNotification];
}

-(void)dealloc{
    [self removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews{
    [self.view addSubview:self.faceView];
    [self.view addSubview:self.moreView];
}

#pragma mark ------------------------- Seter or Geter

-(ZFKeyboardInputView *)keyboardInputView{
    if (!_keyboardInputView) {
        _keyboardInputView = [[ZFKeyboardInputView alloc] initWithKeyboardType:ZFKeyboardTypeChat];
        _keyboardInputView.keyboardDelegate = self;
    }
    return _keyboardInputView;
}

-(LXChatBoxMoreView *)moreView{
    if (!_moreView ) {
        _moreView =[[LXChatBoxMoreView alloc]initWithFrame:CGRectMake(0, self.keyboardInputView.height, self.view.width, POP_H)];
        _moreView.delegate = self;
        // 创建Item
        LXChatBoxMoreViewItem *photosItem = [LXChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"照片"
                                                                                        imageName:@"sharemore_pic"];
        LXChatBoxMoreViewItem *takePictureItem = [LXChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"拍摄"
                                                                                             imageName:@"sharemore_video"];
        LXChatBoxMoreViewItem *videoItem = [LXChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"小视频"
                                                                                       imageName:@"sharemore_sight"];
        LXChatBoxMoreViewItem *docItem   = [LXChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"文件" imageName:@"sharemore_wallet"];
        [_moreView setItems:[[NSMutableArray alloc] initWithObjects:photosItem, takePictureItem, videoItem,docItem, nil]];
        
    }
    return _moreView;
}

-(LXChatBoxFaceView *)faceView{
    if (!_faceView ) {
        _faceView =[[LXChatBoxFaceView alloc] initWithFrame:CGRectMake(0, self.keyboardInputView.height, KScreenW, POP_H)];
    }
    return _faceView;
}


#pragma mark ------------------------- 键盘输入框协议方法

-(void)changeKeyboardHeight:(ZFKeyboardInputView *)keyboardView currentH:(CGFloat)currentH{

    switch (keyboardView.keyboardStatus) {
            case ZFKeyboardStatusNothing:
            case ZFKeyboardStatusShowVoice:
            Keyboard_H = 0;
            break;
        case ZFKeyboardStatusShowFace:{
            Keyboard_H = POP_H;
            self.faceView.hidden = NO;
            self.moreView.hidden = YES;
        }break;
        case ZFKeyboardStatusShowMore:{
            Keyboard_H = POP_H;
            self.moreView.hidden = NO;
            self.faceView.hidden = YES;
        }break;
        case ZFKeyboardStatushowKeyboard:{
            self.moreView.hidden = self.faceView.hidden = YES;
        }break;
        default:
            break;
    }
    [self updateKeyboardHeight];
    
}

- (void)chatBoxMoreView:(LXChatBoxMoreView *)chatBoxMoreView didSelectItem:(LXChatBoxItem)itemType{
    
}


//发送文本消息
-(void)sendTextMessage:(NSString *)textMessage{
    NSLog(@"sendMessage--%@",textMessage);
}

#pragma mark ------------------------- 添加通知

-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LXEmotionDidSelectNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnClicked) name:LXEmotionDidDeleteNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage) name:LXEmotionDidSendNotification object:nil];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"%f",duration);
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    Keyboard_H = keyboardF.size.height;
    keyboardDuration = duration;
    
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification{
}

-(void)updateKeyboardHeight{
    
    ChatViewController *vc = (ChatViewController *)self.parentViewController;
    [vc.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [vc.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(vc.view).offset(-Keyboard_H-self.keyboardInputView.height);
        }];
        [vc.view layoutIfNeeded];
    }];

}

//-(void)presentViewWithAnimation:(UIView *)tagerView{
//    [UIView animateWithDuration:keyboardDuration
//                     animations:^{
//                         CGRect frame = tagerView.frame;
//                         frame.origin.y = self.keyboardInputView.height;
//                         tagerView.frame = frame;
//                     } completion:^(BOOL finished) {
//                         if ([tagerView isKindOfClass:[LXChatBoxFaceView class]]) {
//                             CGRect frame = self.moreView.frame;
//
//                         }
//                     }];
//}

@end
