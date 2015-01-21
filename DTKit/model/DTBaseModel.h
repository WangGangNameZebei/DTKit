//
//  DTBaseModel.h
//  PGCBD
//
//  Created by DT. on 13-5-16.
//

#import <Foundation/Foundation.h>

@interface DTBaseModel : NSObject

- (id)initWithString:(NSString *)string;
- (id)initWithData:(NSData *)data;
- (id)initWithDataDict:(NSDictionary *)dataDict;

@end
