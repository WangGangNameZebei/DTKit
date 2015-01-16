//
//  DTAddressBookTool.m
//  DTKitDemo
//
//  Created by DT on 14-12-4.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAddressBookTool.h"
#import "DTAddressBookModel.h"

@implementation DTAddressBookTool

+ (BOOL)addressBookAuthorizationEnabled
{
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return NO;
    }
    return YES;
//    if (ABAddressBookRequestAccessWithCompletion != NULL) {
//        return YES;
//    }
//    return NO;
}

+(BOOL)getAddressBooks:(void(^)(NSArray *addressBookArray))block;
{
    if ([self addressBookAuthorizationEnabled]) {
        NSMutableArray *tableArray = [[NSMutableArray alloc] init];
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, nil);
        if (ABAddressBookRequestAccessWithCompletion != NULL) {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (results != nil) {
            for(int i = 0; i < CFArrayGetCount(results); i++) {
                ABRecordRef person = CFArrayGetValueAtIndex(results, i);
                [tableArray addObject:[self analysisData:person]];
            }
            CFRelease(results);
            CFRelease(addressBook);
            block(tableArray);
        }else{
            block(tableArray);
        }
        return YES;
    }
    return NO;
}

+(BOOL)getAddressBooksWithName:(NSString*)name block:(void(^)(NSArray *addressBookArray))block;
{
    if ([self addressBookAuthorizationEnabled]) {
        NSMutableArray *tableArray = [[NSMutableArray alloc] init];
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, nil);
        if (ABAddressBookRequestAccessWithCompletion != NULL) {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        CFArrayRef results = ABAddressBookCopyPeopleWithName(addressBook, (__bridge CFStringRef)(name));
        if (results != nil) {
            for(int i = 0; i < CFArrayGetCount(results); i++) {
                ABRecordRef person = CFArrayGetValueAtIndex(results, i);
                [tableArray addObject:[self analysisData:person]];
            }
            CFRelease(results);
            CFRelease(addressBook);
            block(tableArray);
        }else{
            block(tableArray);
        }
        return YES;
    }
    return NO;
}

+(BOOL)createNewAddressBookWithName:(NSString*)name phone:(NSString *)phones, ...
{
    if ([self addressBookAuthorizationEnabled]) {
        //提取不定参数比塞进集合里面
        NSMutableArray* arrays = [NSMutableArray array];
        va_list arguments;
        id eachObject;
        if (phones) {
            [arrays addObject:phones];
            va_start(arguments, phones);
            
            while ((eachObject = va_arg(arguments, id))) {
                [arrays addObject:eachObject];
            }
        }
        va_end(arguments);
        
        CFErrorRef error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef newRecord = ABPersonCreate();
        ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
        
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        for (NSString *phone in arrays) {
            ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)(phone), kABPersonPhoneMobileLabel, NULL);
        }
        ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
        CFRelease(multi);
        ABAddressBookAddRecord(addressBook, newRecord, &error);
        ABAddressBookSave(addressBook, &error);
        CFRelease(newRecord);
        CFRelease(addressBook);
        return YES;
    }
    return NO;
}

+(BOOL)editAddressBookWithId:(NSNumber*) personId phone:(NSString *)phones, ...;
{
    if ([self addressBookAuthorizationEnabled]) {
        //提取不定参数比塞进集合里面
        NSMutableArray* arrays = [NSMutableArray array];
        va_list arguments;
        id eachObject;
        if (phones) {
            [arrays addObject:phones];
            va_start(arguments, phones);
            
            while ((eachObject = va_arg(arguments, id))) {
                [arrays addObject:eachObject];
            }
        }
        va_end(arguments);
        
        CFErrorRef error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, [personId intValue]);
        
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        for (NSString *phone in arrays) {
            ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)(phone), kABPersonPhoneMobileLabel, NULL);
        }
        ABRecordSetValue(record, kABPersonPhoneProperty, multi, &error);
        CFRelease(multi);
        
        ABAddressBookSave(addressBook, &error);
        CFRelease(addressBook);
        return YES;
    }
    return NO;
    
}

+(BOOL)deleteAddressBookWithId:(NSNumber*) personId
{
    if ([self addressBookAuthorizationEnabled]) {
        CFErrorRef error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, [personId intValue]);
        
        ABAddressBookRemoveRecord(addressBook, record, &error);
        
        ABAddressBookSave(addressBook, &error);
        CFRelease(addressBook);
        return YES;
    }
    return NO;
}

/**
 *  @Author DT, 14-12-05 11:12:47
 *
 *  @brief  解析通讯录数据
 *
 *  @param person 对象
 *
 *  @return 返回DTAddressBookModel对象
 */
+(DTAddressBookModel*)analysisData:(ABRecordRef)person
{
    DTAddressBookModel *model = [[DTAddressBookModel alloc] init];
    ABRecordID personID = ABRecordGetRecordID(person);
    model.personId = [NSNumber numberWithInt:personID];
    model.personName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    model.lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    model.middleName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    model.prefix = CFBridgingRelease(ABRecordCopyValue(person, kABPersonPrefixProperty));
    model.suffix = CFBridgingRelease(ABRecordCopyValue(person, kABPersonSuffixProperty));
    model.nickName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonNicknameProperty));
    model.firstNamePhonetic = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty));
    model.lastNamePhonetic = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty));
    model.middleNamePhonetic = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty));
    model.organization = CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));
    model.jobTitle = CFBridgingRelease(ABRecordCopyValue(person, kABPersonJobTitleProperty));
    model.department = CFBridgingRelease(ABRecordCopyValue(person, kABPersonDepartmentProperty));
    model.birthDay = CFBridgingRelease(ABRecordCopyValue(person, kABPersonBirthdayProperty));
    model.note = CFBridgingRelease(ABRecordCopyValue(person, kABPersonNoteProperty));
    model.firstKnow = CFBridgingRelease(ABRecordCopyValue(person, kABPersonCreationDateProperty));
    model.lastKnow = CFBridgingRelease(ABRecordCopyValue(person, kABPersonModificationDateProperty));
    
    NSMutableArray *emailArray = [[NSMutableArray alloc] init];
    ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSInteger emailcount = ABMultiValueGetCount(email);
    for (int x = 0; x < emailcount; x++) {
        NSDictionary *dictionary = @{@"title":CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x))),
                                     @"email":CFBridgingRelease(ABMultiValueCopyValueAtIndex(email, x))};
        [emailArray addObject:dictionary];
    }
    model.emailArray = [NSArray arrayWithArray:emailArray];
    
    //!!!:ios7模拟器下会报错
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        NSMutableArray *addressArray = [[NSMutableArray alloc] init];
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        NSInteger count = ABMultiValueGetCount(address);
        for(int j = 0; j < count; j++) {
            NSDictionary* personaddress =CFBridgingRelease(ABMultiValueCopyValueAtIndex(address, j));
            NSDictionary *dictionary = @{@"address":CFBridgingRelease(ABMultiValueCopyLabelAtIndex(address, j)),
                                         @"country":[personaddress valueForKey:(NSString *)kABPersonAddressCountryKey],
                                         @"city":[personaddress valueForKey:(NSString *)kABPersonAddressCityKey],
                                         @"state":[personaddress valueForKey:(NSString *)kABPersonAddressStateKey],
                                         @"street":[personaddress valueForKey:(NSString *)kABPersonAddressStreetKey],
                                         @"zip":[personaddress valueForKey:(NSString *)kABPersonAddressZIPKey],
                                         @"coutntrycode":[personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey]};
            [addressArray addObject:dictionary];
        }
        model.addressArray = [NSArray arrayWithArray:emailArray];
    }
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
    NSInteger datescount = ABMultiValueGetCount(dates);
    for (NSInteger y = 0; y < datescount; y++) {
        NSDictionary *dictionary = @{@"title":CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y))),
                                     @"dates":CFBridgingRelease(ABMultiValueCopyValueAtIndex(dates, y))};
        [emailArray addObject:dictionary];
    }
    model.datesArray = [NSArray arrayWithArray:dateArray];
    
    CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
    if (recordType == kABPersonKindOrganization) {
        model.isCompany = YES;
    } else {
        model.isCompany = NO;
    }
    
    NSMutableArray *imArray = [[NSMutableArray alloc] init];
    ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
    for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++) {
        NSDictionary* instantMessageContent =CFBridgingRelease(ABMultiValueCopyValueAtIndex(instantMessage, l));
        NSDictionary *dictionary = @{@"label":CFBridgingRelease(ABMultiValueCopyLabelAtIndex(instantMessage, l)),
                                     @"username":[instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey],
                                     @"service":[instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey]};
        [imArray addObject:dictionary];
    }
    model.imArray = imArray;
    
    NSMutableArray *phoneArray = [[NSMutableArray alloc] init];
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (int k = 0; k<ABMultiValueGetCount(phone); k++) {
        NSDictionary *dictionary = @{@"phoneLabel":CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k))),
                                     @"phone":CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k))};
        [phoneArray addObject:dictionary];
    }
    model.phoneArray = phoneArray;
    
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
    for (int m = 0; m < ABMultiValueGetCount(url); m++) {
        NSDictionary *dictionary = @{@"urlLabel":CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m))),
                                     @"content":CFBridgingRelease(ABMultiValueCopyValueAtIndex(url,m))};
        [emailArray addObject:dictionary];
    }
    model.urlArray = urlArray;
    
    model.image = [UIImage imageWithData:CFBridgingRelease(ABPersonCopyImageData(person))];
    return model;
}

@end
