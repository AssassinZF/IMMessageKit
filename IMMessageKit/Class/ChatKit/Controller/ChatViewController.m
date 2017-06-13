//
//  ChaViewController.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "ChatViewController.h"
#import "ConversationModel.h"
#import "BaseChatTableViewCell.h"
#import "ChatTextCell.h"
#import "ChatPhotoCell.h"
#import "MessageModel.h"


@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation ChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)configureUI{
    
    [self.view addSubview:self.tableview];
    [self registerCell];
}

- (void)registerCell
{
    [self.tableview registerClass:[ChatTextCell class] forCellReuseIdentifier:NSStringFromClass([ChatTextCell class])];
    [self.tableview registerClass:[ChatPhotoCell class] forCellReuseIdentifier:NSStringFromClass([ChatPhotoCell class])];
}



-(void)setConversationModel:(ConversationModel *)conversationModel{
    _conversationModel = conversationModel;
    self.title = _conversationModel.conversationName;
}

#pragma mark ------------------------- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.dataArray[indexPath.row];
    BaseChatTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:[model.messageItem cellTypeString]];
    cell.modelFrame = model;
    return cell;
}

#pragma mark ------------------------- Getr

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = XZColor(240, 237, 237);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}


@end
