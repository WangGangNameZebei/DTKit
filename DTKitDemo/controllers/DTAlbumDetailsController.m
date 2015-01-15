//
//  DTAlbumDetailsController.m
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlbumDetailsController.h"
#import "DTAlbumTool.h"
#import "DateUtil.h"
#import "DTGridTableView.h"

@interface DTAlbumDetailsController()<DTGridTableViewDatasource,DTGridTableViewDelegate>

@property(nonatomic,strong)DTGridTableView *tableView;
@property(nonatomic,strong)NSMutableArray *itemsArray;

@end

@implementation DTAlbumDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.itemsArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"DTAlbumDetailsController";
    if (![DTAlbumTool albumsAuthorizationEnabled]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"没有相册访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    switch ([self.type intValue]) {
        case 1:
            [self getAlbumInfo];
            break;
        case 2:
            [self getAlbumsInfo];
            break;
        case 3:
            [self getAlbumFirstPhoto];
            break;
        case 4:
            [self getAlbumLastPhoto];
            break;
        case 5:
            [self getAlbumPhotos];
            break;
        case 6:
            [self getAlbumVideos];
            break;
        case 7:
            [self getAlbumAll];
            break;
        case 8:
            [self getAlbumsPhotos];
            break;
        case 9:
            [self getAlbumsVideos];
            break;
        case 10:
            [self getAlbumsAll];
            break;
        case 11:
            [self addAlbumGroupWithName];
            break;
        case 12:
            [self writeImageToAlbum];
            break;
        case 13:
            [self writeImageDataToAlbum];
            break;
        default:
            break;
    }
}

-(void)initGridTableView
{
    self.tableView = [[DTGridTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -44)];
    self.tableView.datasource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark DTGridTableViewDatasource
- (NSInteger)numberOfGridsInRow
{
    return 4;
}

- (NSInteger)numberOfGrids
{
    return self.itemsArray.count;
}

- (UIView*)viewAtIndex:(NSInteger)index size:(CGSize)size
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    return view;
}

#pragma mark DTGridTableViewDelegate
- (void)gridView:(UIView*)gridView gridViewForRowAtIndexPath:(int)index
{
    ALAsset *asset = [self.itemsArray objectAtIndex:index];
    UIImageView *imageView = (UIImageView*)gridView;
    imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

#pragma mark DTAlbumTool

-(void)getAlbumInfo
{
    [DTAlbumTool getAlbumInfo:^(ALAssetsGroup *group) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
        imageView.image = [UIImage imageWithCGImage:[group posterImage]];
        [self.view addSubview:imageView];
        
        UILabel *label = nil;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"相薄名称 : %@",[group valueForProperty:ALAssetsGroupPropertyName]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"总数量 : %i",[group numberOfAssets]];
        [self.view addSubview:label];
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"图片数量 : %i",[group numberOfAssets]];
        [self.view addSubview:label];
        
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"视频数量 : %i",[group numberOfAssets]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"相册的存储id : %@",[group valueForProperty:ALAssetsGroupPropertyPersistentID]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"相册的位置地址 : %@",[group valueForProperty:ALAssetsGroupPropertyURL]];
        [self.view addSubview:label];
    }];
}

-(void)getAlbumsInfo
{
    [DTAlbumTool getAlbumsInfo:^(NSArray *groupArray) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 290*groupArray.count)];
        [self.view addSubview:scrollView];
        for (int i=0; i<[groupArray count]; i++) {
            ALAssetsGroup *group = [groupArray objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20+290*i, 80, 80)];
            imageView.image = [UIImage imageWithCGImage:[group posterImage]];
            [scrollView addSubview:imageView];
            
            UILabel *label = nil;
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 120+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"相薄名称 : %@",[group valueForProperty:ALAssetsGroupPropertyName]];
            [scrollView addSubview:label];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 150+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"总数量 : %i",[group numberOfAssets]];
            [scrollView addSubview:label];
            
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 180+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"图片数量 : %i",[group numberOfAssets]];
            [scrollView addSubview:label];
            
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 210+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"视频数量 : %i",[group numberOfAssets]];
            [scrollView addSubview:label];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 240+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"相册的存储id : %@",[group valueForProperty:ALAssetsGroupPropertyPersistentID]];
            [scrollView addSubview:label];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(20, 270+290*i, self.view.frame.size.width -40, 20)];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.text = [NSString stringWithFormat:@"相册的位置地址 : %@",[group valueForProperty:ALAssetsGroupPropertyURL]];
            [scrollView addSubview:label];
        }
    }];
}


-(void)getAlbumFirstPhoto
{
    [DTAlbumTool getAlbumFirstPhoto:^(ALAsset *asset) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
        imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        [self.view addSubview:imageView];
        
        UILabel *label = nil;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+20, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"容量大小 : %lld",[[asset defaultRepresentation] size]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+50, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"拍照时间 : %@",[asset valueForProperty:ALAssetPropertyDate]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+80, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"拍照位置 : %@",[asset valueForProperty:ALAssetPropertyLocation]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+110, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"图片url : %@",[asset valueForProperty:ALAssetPropertyAssetURL]];
        [self.view addSubview:label];
    }];
}

-(void)getAlbumLastPhoto
{
    [DTAlbumTool getAlbumLastPhoto:^(ALAsset *asset) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
        imageView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        [self.view addSubview:imageView];
        
        UILabel *label = nil;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+20, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"容量大小 : %lld",[[asset defaultRepresentation] size]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+50, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"拍照时间 : %@",[asset valueForProperty:ALAssetPropertyDate]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+80, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"拍照位置 : %@",[asset valueForProperty:ALAssetPropertyLocation]];
        [self.view addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.size.width+110, self.view.frame.size.width -40, 20)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"图片url : %@",[asset valueForProperty:ALAssetPropertyAssetURL]];
        [self.view addSubview:label];
    }];
}

-(void)getAlbumPhotos
{
    [self initGridTableView];
    [DTAlbumTool getAlbumPhotos:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)getAlbumVideos
{
    [self initGridTableView];
    [DTAlbumTool getAlbumVideos:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)getAlbumAll
{
    [self initGridTableView];
    [DTAlbumTool getAlbumAll:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)getAlbumsPhotos
{
    [self initGridTableView];
    [DTAlbumTool getAlbumsPhotos:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)getAlbumsVideos
{
    [self initGridTableView];
    [DTAlbumTool getAlbumsVideos:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)getAlbumsAll
{
    [self initGridTableView];
    [DTAlbumTool getAlbumAll:^(NSArray *assetArray) {
        [self.itemsArray addObjectsFromArray:assetArray];
        [self.tableView reloadData];
    }];
}

-(void)addAlbumGroupWithName
{
    [DTAlbumTool addAlbumGroupWithName:@"test" block:^(ALAssetsGroup *group) {
        if (group) {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"创建成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"" message:@"创建不成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
    
}

-(void)writeImageToAlbum
{
    [DTAlbumTool writeImageToAlbum:[UIImage imageNamed:@"pengyouquan_detail_pic"] block:^(NSURL *url) {
        if (url) {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"" message:@"保存不成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
}

-(void)writeImageDataToAlbum
{
    [DTAlbumTool albumGroupForName:@"test" block:^(NSArray *groupArray) {
        for (ALAssetsGroup *group in groupArray) {
            [DTAlbumTool writeImageDataToAlbum:UIImageJPEGRepresentation([UIImage imageNamed:@"pengyouquan_detail_pic"], 1) albumUrl:[group valueForProperty:ALAssetsGroupPropertyURL] block:^(NSURL *url) {
                if (url) {
                    [[[UIAlertView alloc] initWithTitle:@"" message:@"保存到test相册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"" message:@"保存到test相册不成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                }
            }];
        }
    }];
}

@end
