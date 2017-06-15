//
//  ZFKeyboardInputView.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "ZFKeyboardInputView.h"


@interface ZFKeyboardInputView()<UITextViewDelegate>
{
    CGFloat currentH;//当前总高度
    
}

@property (nonatomic, assign ,readwrite)ZFKeyboardStatus keyboardStatus;//键盘状态


/** chotBox的顶部边线 */
@property (nonatomic, strong) UIView *topLine;
/** 录音按钮 */
@property (nonatomic, strong) UIButton *voiceButton;
/** 表情按钮 */
@property (nonatomic, strong) UIButton *faceButton;
/** (+)按钮 */
@property (nonatomic, strong) UIButton *moreButton;
/** 按住说话 */
@property (nonatomic, strong) UIButton *talkButton;
/** 输入框 */
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZFKeyboardInputView

-(instancetype)initWithKeyboardType:(ZFKeyboardType)keboardType{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
        _keyboardType = keboardType;//键盘类型
        _keyboardStatus = ZFKeyboardStatusNothing;//默认状态
        _maxTextLine = 5;//默认最多显示5行
        currentH = HEIGHT_TABBAR;
        
        [self addSubview:self.topLine];
        [self addSubview:self.voiceButton];
        [self addSubview:self.textView];
        [self addSubview:self.faceButton];
        [self addSubview:self.moreButton];
        [self addSubview:self.talkButton];
        
        
        [self layoutUI];
    }
    
    return self;
}

- (instancetype)init
{
    self = [self initWithKeyboardType:ZFKeyboardTypeChat];
    if (self) {
    }
    return self;
}

-(void)layoutUI{
    
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SPACE);
        make.bottom.equalTo(self).offset(-SPACE);
        make.size.mas_equalTo(CGSizeMake(CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH));
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-TEXTVIEW_BOTTPN_SPACE);
        make.left.equalTo(_voiceButton.mas_right).offset(SPACE);
        make.right.equalTo(_faceButton.mas_left).offset(-SPACE);
        make.top.equalTo(self).offset(TEXTVIEW_BOTTPN_SPACE);
    }];
    
    [_faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-SPACE);
        make.right.equalTo(_moreButton.mas_left).offset(-SPACE);
        make.size.mas_equalTo(CGSizeMake(CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH));
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-SPACE);
        make.right.equalTo(self).offset(-SPACE);
        make.size.mas_equalTo(CGSizeMake(CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH));
    }];
    
    [_talkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_textView);
        make.height.equalTo(@(HEIGHT_TEXTVIEW));
    }];
    
}


#pragma mark - Getter and Setter

- (UIView *) topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        [_topLine setBackgroundColor:XZColor(165, 165, 165)];
    }
    return _topLine;
}

- (UIButton *) voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
//        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *) moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *) faceButton
{
    if (_faceButton == nil) {
        _faceButton = [[UIButton alloc] init];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
//        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        [_faceButton addTarget:self action:@selector(faceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

- (UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.talkButton.frame];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setCornerRadius:4.0f];
        [_textView.layer setBorderWidth:0.5f];
        [_textView.layer setBorderColor:self.topLine.backgroundColor.CGColor];
        [_textView setScrollsToTop:NO];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView setDelegate:self];
    }
    return _textView;
}

- (UIButton *) talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[UIButton alloc] init];
        [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_talkButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [_talkButton setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
//        [_talkButton setBackgroundImage:[UIImage gxz_imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateHighlighted];
        [_talkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_talkButton.layer setMasksToBounds:YES];
        [_talkButton.layer setCornerRadius:4.0f];
        [_talkButton.layer setBorderWidth:0.5f];
        [_talkButton.layer setBorderColor:self.topLine.backgroundColor.CGColor];
        [_talkButton setHidden:YES];
        [_talkButton addTarget:self action:@selector(talkButtonDown:) forControlEvents:UIControlEventTouchDown];
        [_talkButton addTarget:self action:@selector(talkButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_talkButton addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [_talkButton addTarget:self action:@selector(talkButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [_talkButton addTarget:self action:@selector(talkButtonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        [_talkButton addTarget:self action:@selector(talkButtonDragInside:) forControlEvents:UIControlEventTouchDragInside];
    }
    return _talkButton;
}



#pragma mark - UITextViewDelegate

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    self.keyboardStatus = ZFKeyboardStatushowKeyboard;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = ceilf([textView sizeThatFits:textView.frame.size].height);
    
    CGFloat maxH = ceil(_maxTextLine*textView.font.lineHeight+textView.textContainerInset.top*2);

    if (height > HEIGHT_TEXTVIEW) {
        
        currentH = MIN(maxH, height);

        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(currentH));
        }];
        
        [self.textView scrollToBottom];

    }
    
    
    
    if ([self.keyboardDelegate respondsToSelector:@selector(changeKeyboardHeight:currentH:)]) {
        [self.keyboardDelegate changeKeyboardHeight:self currentH:self.height];
    }

    
    if (textView.text.length > TEXT_LENGTH) { // 限制5000字内
        textView.text = [textView.text substringToIndex:TEXT_LENGTH];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (self.textView.text.length > 0) {     // send Text
            //            if ([self.textView.text isTrimmingSpace]) {
            ////                [MBProgressHUD showError:@"不能发送空白消息"];
            //            } else {
//            if (_delegate && [_delegate respondsToSelector:@selector(chatBox:sendTextMessage:)]) {
//                [_delegate chatBox:self sendTextMessage:self.textView.text];
//            }
            //            }
        }
        [self.textView setText:@""];
        return NO;
    }
    return YES;
}




#pragma mark - Event Response

// 录音按钮点击事件
- (void) voiceButtonDown:(UIButton *)sender
{
    if (sender.selected) {
        self.keyboardStatus = ZFKeyboardStatushowKeyboard;
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(HEIGHT_TABBAR));
        }];
        self.keyboardStatus = ZFKeyboardStatusShowVoice;

    }
    
}

// 更多（+）按钮
- (void) moreButtonDown:(UIButton *)sender
{
    self.keyboardStatus = ZFKeyboardStatusShowMore;
}

// 表情按钮
- (void) faceButtonDown:(UIButton *)sender
{
    if (sender.selected) {
        self.keyboardStatus = ZFKeyboardStatushowKeyboard;
    }else{
        self.keyboardStatus = ZFKeyboardStatusShowFace;
    }

}

// 说话按钮
- (void)talkButtonDown:(UIButton *)sender
{
//    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidStartRecordingVoice:)]) {
//        [_delegate chatBoxDidStartRecordingVoice:self];
//    }
}

- (void)talkButtonUpInside:(UIButton *)sender
{
//    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidStopRecordingVoice:)]) {
//        [_delegate chatBoxDidStopRecordingVoice:self];
//    }
}

- (void)talkButtonUpOutside:(UIButton *)sender
{
//    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidCancelRecordingVoice:)]) {
//        [_delegate chatBoxDidCancelRecordingVoice:self];
//    }
}

- (void)talkButtonDragOutside:(UIButton *)sender
{
//    if ([_delegate respondsToSelector:@selector(chatBoxDidDrag:)]) {
//        [_delegate chatBoxDidDrag:NO];
//    }
}

- (void)talkButtonDragInside:(UIButton *)sender
{
//    if ([_delegate respondsToSelector:@selector(chatBoxDidDrag:)]) {
//        [_delegate chatBoxDidDrag:YES];
//    }
}

- (void)talkButtonTouchCancel:(UIButton *)sender
{
}


#pragma mark ------------------------- 刷新键盘状态
-(void)setKeyboardStatus:(ZFKeyboardStatus)keyboardStatus{
    _keyboardStatus = keyboardStatus;
    switch (_keyboardStatus) {
        case ZFKeyboardStatusNothing:{
            if (self.textView.isFirstResponder) {
                [self.textView resignFirstResponder];
            }
            _voiceButton.selected = _textView.hidden = _faceButton.selected = NO;
            _talkButton.hidden = YES;
        }break;
        case ZFKeyboardStatushowKeyboard:{
            _talkButton.hidden = YES;
            _voiceButton.selected = NO;
            _faceButton.selected = NO;
            _textView.hidden = NO;
        }break;
        case ZFKeyboardStatusShowFace:{
            _talkButton.hidden = YES;
            _textView.hidden = NO;
            _voiceButton.selected = NO;
            _faceButton.selected = YES;
        }break;
        case ZFKeyboardStatusShowMore:{
            _talkButton.hidden = YES;
            _textView.hidden = NO;
            _voiceButton.selected = NO;
            _faceButton.selected = NO;

        }break;
        case ZFKeyboardStatusShowVoice:{
            _talkButton.hidden = NO;
            _textView.hidden = YES;
            _voiceButton.selected = YES;
            _faceButton.selected = NO;
        }break;
            
        default:
            break;
    }
    
    if (_keyboardStatus != ZFKeyboardStatusShowVoice) {
        
        if (_keyboardStatus == ZFKeyboardStatushowKeyboard && !self.textView.isFirstResponder) {
            [self.textView becomeFirstResponder];
        }
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(currentH));
        }];

    }
    
    if (_keyboardStatus != ZFKeyboardStatushowKeyboard) {
        [self.textView resignFirstResponder];
    }
    
    if ([self.keyboardDelegate respondsToSelector:@selector(changeKeyboardHeight:currentH:)]) {
        [self.keyboardDelegate changeKeyboardHeight:self currentH:self.height];
    }
    
}

-(void)resetKeyboard{
    if (self.keyboardStatus != ZFKeyboardStatusShowVoice) {
        self.keyboardStatus = ZFKeyboardStatusNothing;
    }
}

@end
