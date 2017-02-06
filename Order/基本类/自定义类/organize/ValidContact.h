//
//  ValidContact.h
//  PersonClass
//
//  Created by wang on 16/7/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum validContact {
    CONTACT_NONE,
    CONTACT_EMAIL,
    CONTACT_MOBILE,
    CONTACT_BOTH,
}validContact;


@interface ValidContact : NSObject<NSCoding>
/** 连接*/
@property(nonatomic,assign) validContact valid;
+(validContact) deleteEmailContact:(validContact)contact;
+(validContact) deleteMobileContact:(validContact)contact;
+(validContact) addEmailContact:(validContact)contact;
+(validContact) addMobileContact:(validContact)contact;

+(NSString *)getStringFormEnum:(validContact)ID;
+(validContact)getEnumFormStr:(NSString *)str;
@end
