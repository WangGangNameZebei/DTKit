//
//  DTUserDefaults.m
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTUserDefaults.h"

@implementation DTUserDefaults

+(NSString*)getStringForKey:(NSString*)key
{
    NSString *value = @"";
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        value = [standardUserDefaults stringForKey:key];
    }
    return value;
}

+(NSInteger)getIntegerForkey:(NSString*)key
{
    NSInteger value = 0;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        value = [standardUserDefaults integerForKey:key];
    }
    return value;
}

+(NSDictionary*)getDictionaryForKey:(NSString*)key
{
    NSDictionary* value = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        value = [standardUserDefaults dictionaryForKey:key];
    }
    return value;
}

+(NSArray*)getArrayForKey:(NSString*)key
{
    NSArray* value = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        value = [standardUserDefaults arrayForKey:key];
    }
    return value;
}

+(BOOL)getBoolForKey:(NSString*)key
{
    BOOL value = false;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        value = [standardUserDefaults boolForKey:key];
    }
    return value;
}

+(void)setString:(NSString*)value key:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setInteger:(NSInteger)value key:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults setInteger:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setDictionary:(NSDictionary*)value key:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setArray:(NSArray*)value key:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)setBool:(BOOL)value key:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults){
        [standardUserDefaults setBool:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

@end
