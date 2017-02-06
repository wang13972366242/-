//
//  ValidContact.m
//  PersonClass
//
//  Created by wang on 16/7/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ValidContact.h"
#import "CommonFunctions.h"


@implementation ValidContact

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
   [aCoder encodeObject:@(self.valid) forKey:@"valid"];

}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        NSNumber *validNumber = [NSNumber numberWithInt:self.valid];
    validNumber = [aDecoder decodeObjectForKey:@"valid"];
    }
    return self;
}
+(validContact) deleteEmailContact:(validContact)contact{
    switch (contact) {
        case CONTACT_BOTH:
            return CONTACT_MOBILE;
        case CONTACT_EMAIL:
            return CONTACT_NONE;
        default:
            return contact;
    }
    
}

+(validContact) deleteMobileContact:(validContact)contact{
    

    switch (contact) {
        case CONTACT_BOTH:
        return CONTACT_EMAIL;
        case CONTACT_MOBILE:
        return CONTACT_NONE;
        default:
        return contact;
    }
}


+(validContact) addEmailContact:(validContact)contact{
    switch (contact) {
        case CONTACT_NONE:
        return CONTACT_EMAIL;
        case CONTACT_MOBILE:
        return CONTACT_BOTH;
        default:
        return contact;
    }
}


+(validContact) addMobileContact:(validContact)contact{
    switch (contact) {
        case CONTACT_NONE:
        return CONTACT_MOBILE;
        case CONTACT_EMAIL:
        return CONTACT_BOTH;
        default:
        return contact;
    }
}


+(NSArray *)getEnum{
    return @[@"CONTACT_NONE",@"CONTACT_EMAIL",@"CONTACT_MOBILE",@"CONTACT_BOTH"];

}

+(NSString *)getStringFormEnum:(validContact)ID{
    NSArray *arr=  [self getEnum];
    return  [arr objectAtIndex:ID];
}
+(validContact)getEnumFormStr:(NSString *)str{
    
    if ([CommonFunctions functionsIsStringValidAfterTrim:str]) {
        if ([str isEqualToString:@"CONTACT_NONE"]) {
            return CONTACT_NONE;
        }else if ([str isEqualToString:@"CONTACT_EMAIL"]){
            return CONTACT_EMAIL;
        }else if ([str isEqualToString:@"CONTACT_MOBILE"]){
            return CONTACT_MOBILE;
        }else if([str isEqualToString:@"CONTACT_BOTH"]){
            return CONTACT_BOTH;
        }
    }
    return  1000;
}



@end
