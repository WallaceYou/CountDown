//
//  CountDownCellViewController.m
//  CountDown
//
//  Created by yuyou on 2018/6/27.
//  Copyright © 2018年 com.morpx. All rights reserved.
//

#import "CountDownCellViewController.h"
#import "Masonry.h"

@interface CountDownCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *timeDic;

@end

@interface CountDownCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *leftTimeLb;

@end

@implementation CountDownCell

- (void)setTimeDic:(NSDictionary *)timeDic {
    _timeDic = timeDic;
    NSString *title = timeDic[@"title"];
    NSString *leftTime = timeDic[@"leftTime"];
    
    self.iconImageView.hidden = NO;
    self.titleLb.text = title;
    self.leftTimeLb.text = leftTime;
    
    if ([self.leftTimeLb.text isEqualToString:@"活动已经结束！"]) {
        self.leftTimeLb.textColor = [UIColor redColor];
    } else {
        self.leftTimeLb.textColor = [UIColor orangeColor];
    }
}


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        
        UIImage *image = [UIImage imageNamed:@"image1"];
        _iconImageView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(0);
            make.width.mas_equalTo(_iconImageView.mas_height).multipliedBy(image.size.width/image.size.height);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImageView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(10);
        }];
    }
    return _titleLb;
}

- (UILabel *)leftTimeLb {
    if (!_leftTimeLb) {
        _leftTimeLb = [UILabel new];
        _leftTimeLb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_leftTimeLb];
        [_leftTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLb);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(30);
        }];
    }
    return _leftTimeLb;
}
@end








@interface CountDownCellViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *timeDatas;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation CountDownCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = NO;
    
    //开始计时器
    dispatch_resume(self.timer);
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountDownCell"];
    
    NSDictionary *timeDic = @{@"title":[NSString stringWithFormat:@"活动 %@ 结束",self.timeDatas[indexPath.row]],@"leftTime":[self getNowTimeWithString:self.timeDatas[indexPath.row]]};
    
    cell.timeDic = timeDic;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CountDownCell class] forCellReuseIdentifier:@"CountDownCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSArray *)timeDatas {
    if (!_timeDatas) {
        _timeDatas = @[@"2018-07-02 16:24:02",@"2018-07-05 14:24:10",@"2018-07-09 14:24:07",@"2018-03-09 14:25:01",@"2018-03-10 14:24:11",@"2018-04-11 14:34:08",@"2018-05-12 14:26:03",@"2018-05-13 22:23:49",@"2018-07-14 14:23:43",@"2018-08-15 14:23:14",@"2018-09-16 14:23:41",@"2018-10-17 14:11:46",@"2018-11-18 14:23:23",@"2018-12-19 14:23:43",@"2018-12-20 14:12:45",@"2018-12-21 14:23:22",@"2018-12-22 14:23:40",@"2018-12-23 14:13:40",@"2018-12-24 14:23:45",@"2018-12-25 14:23:45",@"2018-12-26 14:14:41",@"2018-12-27 14:23:50",@"2018-12-28 14:23:45",@"2018-12-29 14:15:42",@"2018-12-30 14:23:51",@"2018-06-01 14:28:45",@"2018-06-02 14:16:43",@"2018-06-03 14:23:52",@"2018-06-04 14:29:45",@"2018-06-05 14:17:44",@"2018-06-06 14:23:53",@"2018-06-07 14:30:45",@"2018-06-08 14:18:45",@"2018-06-09 14:23:54",@"2018-06-10 14:31:01",@"2018-09-01 14:19:30",@"2018-09-02 14:23:55",@"2018-09-03 14:32:02",@"2018-09-04 14:20:31",@"2018-09-01 14:23:56",@"2018-03-02 14:33:03",@"2018-03-03 14:21:12",@"2018-03-07 14:23:45",@"2018-04-02 14:34:04",@"2018-04-03 14:23:32",@"2018-04-04 14:23:49",@"2018-04-05 14:04:05",@"2018-07-11 14:23:05",@"2018-07-13 14:24:09",@"2018-07-19 14:14:06"];
    }
    return _timeDatas;
}

- (dispatch_source_t)timer {
    if (!_timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateTimeInVisibleCells];
            });
        });
    }
    return _timer;
}

#pragma mark - 私有方法
- (void)updateTimeInVisibleCells {
    NSArray *cells = self.tableView.visibleCells; //取出屏幕可见ceLl
    for (CountDownCell *cell in cells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        cell.leftTimeLb.text = [self getNowTimeWithString:self.timeDatas[indexPath.row]];
        if ([cell.leftTimeLb.text isEqualToString:@"活动已经结束！"]) {
            cell.leftTimeLb.textColor = [UIColor redColor];
        } else {
            cell.leftTimeLb.textColor = [UIColor orangeColor];
        }
    }
}

- (NSString *)getNowTimeWithString:(NSString *)aTimeString {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"距结束 %@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"距结束 %@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

@end
