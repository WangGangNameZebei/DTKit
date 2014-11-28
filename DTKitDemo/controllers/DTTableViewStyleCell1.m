//
//  DTTableViewStyleCell1.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewStyleCell1.h"

@interface DTTableViewStyleCell1()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *contentImage;

@end

@implementation DTTableViewStyleCell1

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 20, 25)];
        self.titleLabel.textColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.titleLabel];
        
        self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, self.frame.size.width - 20, 30)];
        self.contentImage.image = [UIImage imageNamed:@"tab_bottom_bar_bg"];
        [self addSubview:self.contentImage];
    }
    return self;
}

-(void)configureForData:(id)data
{
    self.titleLabel.text = data;
}


@end
