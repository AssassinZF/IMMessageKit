//
//  BaseChatTableViewCell.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "BaseChatTableViewCell.h"
#import "MessageModel.h"

@implementation BaseChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognizer:)];
        longRecognizer.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longRecognizer];
        
        [self configureUI];
        
    }
    return self;
}

-(void)configureUI{
    [self.contentView addSubview:self.bubbleView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.activityView];
    [self.contentView addSubview:self.retryButton];
    [self.contentView addSubview:self.messageStatus];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.dateLabel];
    
}

#pragma mark - longPress delegate

- (void)longPressRecognizer:(UILongPressGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(longPress:)]) {
        [self.delegate longPress:recognizer];
    }
}

-(void)headClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headImageClicked:)]) {
        [self.delegate headImageClicked:self.modelFrame.messageItem.userID];
    }
}


#pragma mark ------------------------- 点击重发

-(void)retryButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(respondsToSelector:)]) {
        [self.delegate reSendMessage:self];
    }
}


#pragma mark - Getter and Setter

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClicked)];
        [_headImageView addGestureRecognizer:tapGes];
    }
    return _headImageView;
}

- (UIImageView *)bubbleView {
    if (_bubbleView == nil) {
        _bubbleView = [[UIImageView alloc] init];
    }
    return _bubbleView;
}

- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UIButton *)retryButton {
    if (_retryButton == nil) {
        _retryButton = [[UIButton alloc] init];
        [_retryButton setImage:[UIImage imageNamed:@"button_retry_comment"] forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _retryButton.hidden = YES;
    }
    return _retryButton;
}

-(UILabel *)messageStatus{
    if (!_messageStatus) {
        _messageStatus = [[UILabel alloc] init];
        _messageStatus.backgroundColor = [UIColor greenColor];
        _messageStatus.hidden = YES;
    }
    return _messageStatus;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor redColor];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName = [[UILabel alloc] init];
        _nickName.backgroundColor = [UIColor clearColor];
        _nickName.textColor = [UIColor redColor];
        _nickName.font = [UIFont systemFontOfSize:13];
    }
    return _nickName;
}

-(void)setModelFrame:(MessageModel *)modelFrame{
    _modelFrame = modelFrame;
    self.headImageView.frame = modelFrame.avatarViewF;
    self.bubbleView.frame = modelFrame.bubbleViewF;
    if (modelFrame.messageItem.messageFrom == MessageFrom_output) {
        self.activityView.frame  = modelFrame.activityF;
        self.retryButton.frame   = modelFrame.retryButtonF;
        self.bubbleView.image = [UIImage imageNamed:@"liaotianbeijing2"];
    }else{
        self.bubbleView.image    = [UIImage imageNamed:@"liaotianbeijing1"];
        self.retryButton.hidden = YES;
    }
    
    // 发送状态
    switch (modelFrame.messageItem.sendState) {
        case ICMessageDeliveryState_Delivering:
        {
            [self.activityView setHidden:NO];
            [self.retryButton setHidden:YES];
            [self.activityView startAnimating];
        }
            break;
        case ICMessageDeliveryState_Delivered:
        {
            [self.activityView stopAnimating];
            [self.activityView setHidden:YES];
            [self.retryButton setHidden:YES];
            
        }
            break;
        case ICMessageDeliveryState_Failure:
        {
            [self.activityView stopAnimating];
            [self.activityView setHidden:YES];
            [self.retryButton setHidden:NO];
        }
            break;
        default:
            break;
    }
    
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:modelFrame.messageItem.headImageUrl] placeholderImage:nil];//头像
    self.headImageView.image = [UIImage imageNamed:@"mayun.jpg"];
    

}

-(NSString *)subClassName{
    return nil;
}

@end
