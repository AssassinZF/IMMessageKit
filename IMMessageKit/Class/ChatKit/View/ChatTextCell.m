//
//  ChatTextCell.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "ChatTextCell.h"
#import "ChatConst.h"
#import "MessageModel.h"

@implementation ChatTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bubbleView addSubview:self.contentLabel];
    }
    return self;
}


-(NSString *)subClassName{
    return NSStringFromClass([self class]);
}

-(void)setModelFrame:(MessageModel *)modelFrame{
    [super setModelFrame:modelFrame];
    self.contentLabel.text = modelFrame.messageItem.content;
    
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = MessageFont;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}


@end
