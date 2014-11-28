//
//  DTTableViewControllerCell.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewControllerCell.h"

@interface DTTableViewControllerCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@end

@implementation DTTableViewControllerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 20, 25)];
        self.titleLabel.textColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.frame.size.width - 50, 40)];
        self.detailLabel.textColor = [UIColor yellowColor];
        self.detailLabel.font = [UIFont systemFontOfSize:13.0f];
        self.detailLabel.numberOfLines = 2;
        self.detailLabel.textColor = [UIColor grayColor];
        [self addSubview:self.detailLabel];
    }
    return self;
}

-(void)configureForData:(id)data
{
    self.titleLabel.text = [data objectAtIndex:0];
    self.detailLabel.text = [data objectAtIndex:1];
}

@end
