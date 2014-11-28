//
//  DTUserDefaultsController.m
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTUserDefaultsController.h"
#import "DTUserDefaults.h"

@interface DTUserDefaultsController()
{
    UIButton *_getButton;
    UIButton *_saveButton;
    
    UILabel *_stringLabel;
    UILabel *_intLabel;
    UILabel *_arrayLabel;
    UILabel *_dictionaryLabel;
    UILabel *_boolLabel;
}
@end

@implementation DTUserDefaultsController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTUserDefaultsController";
    [self creatButtons];
}

- (void)createDatas
{
    [DTUserDefaults setString:@"string1" key:@"stirng"];
    [DTUserDefaults setInteger:1 key:@"integer"];
    [DTUserDefaults setArray:[NSArray arrayWithObjects:@"a",@"b",@"c", nil] key:@"array"];
    [DTUserDefaults setDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",@"value2",@"key2", nil] key:@"dictionary"];
    [DTUserDefaults setBool:YES key:@"bool"];
}

-(void)getDatas
{
    _stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 20)];
    _stringLabel.textColor = [UIColor blackColor];
    _stringLabel.font = [UIFont systemFontOfSize:14.0f];
    NSString *string = [DTUserDefaults getStringForKey:@"stirng"];
    _stringLabel.text = [NSString stringWithFormat:@"获取的string类型值:%@",string];
    [self.view addSubview:_stringLabel];
    
    _intLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 20)];
    _intLabel.textColor = [UIColor blackColor];
    _intLabel.font = [UIFont systemFontOfSize:14.0f];
    NSInteger integer = [DTUserDefaults getIntegerForkey:@"integer"];
    _intLabel.text = [NSString stringWithFormat:@"获取的integer类型值:%i",integer];
    [self.view addSubview:_intLabel];
    
    _arrayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 300, 20)];
    _arrayLabel.textColor = [UIColor blackColor];
    _arrayLabel.font = [UIFont systemFontOfSize:14.0f];
    NSArray *array = [DTUserDefaults getArrayForKey:@"array"];
    _arrayLabel.text = [NSString stringWithFormat:@"获取的array类型值:%@",array];
    [self.view addSubview:_arrayLabel];
    
    _dictionaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 20)];
    _dictionaryLabel.textColor = [UIColor blackColor];
    _dictionaryLabel.font = [UIFont systemFontOfSize:14.0f];
    NSDictionary *dictionary = [DTUserDefaults getDictionaryForKey:@"dictionary"];
    _dictionaryLabel.text = [NSString stringWithFormat:@"获取的dictionary类型值:%@",dictionary];
    [self.view addSubview:_dictionaryLabel];
    
    _boolLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 300, 20)];
    _boolLabel.textColor = [UIColor blackColor];
    _boolLabel.font = [UIFont systemFontOfSize:14.0f];
    BOOL _bool = [DTUserDefaults getBoolForKey:@"bool"];
    _boolLabel.text = [NSString stringWithFormat:@"获取的bool类型值:%i",_bool];
    [self.view addSubview:_boolLabel];
}

-(void)creatButtons
{
    _getButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _getButton.frame = CGRectMake(10, 10, 70, 35);
    [_getButton setTitle:@"获取数据" forState:UIControlStateNormal];
    _getButton.tag = 1;
    [_getButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getButton];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saveButton.frame = CGRectMake(200, 10, 70, 35);
    [_saveButton setTitle:@"保存数据" forState:UIControlStateNormal];
    _saveButton.tag = 2;
    [_saveButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveButton];
}

-(void)clickButton:(UIButton*)button
{
    if (button.tag ==1) {
        [self getDatas];
    }else if (button.tag ==2){
        [self createDatas];
        [[[UIAlertView alloc] initWithTitle:@"" message:@"插入数据成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }
}

@end
