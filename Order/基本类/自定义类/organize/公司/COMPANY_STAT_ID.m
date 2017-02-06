//
//  COMPANY_STAT_ID.m
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "COMPANY_STAT_ID.h"
#import "CommonFunctions.h"



@implementation COMPANY_STAT_ID

/**
 * 返回公司基础信息的属性列表
 * @return 属性数组
 */
+(NSArray *)getBaseCompanyStatList{
    
    
    return @[@(Name),@(Mobile),@(Email),@(validcontac)];
    
}

/**
 * 返回公司客户端完整信息的属性列表
 * @return 属性数组
 */
+(NSArray *)getClientCompanyStatList{
    return @[@(Staticphone),@(Address),@(Type),@(Summary),@(JobTitlestructure)];
}
+(NSArray *)getAdminCanSetCompanyStats{
    NSArray *UniqueStats = @[@"Staticphone",@"Address",@"Type",@"Summary",@"JobTitlestructure",@"Mobile",@"Email"];

    return UniqueStats;
    
}


/**
 * 获取Unique属性的数组；
 * @return  属性数组
 */
-(NSArray *)getDBUniqueItemList{
    
    return @[@(Name),@(Mobile),@(Email),@(uniqueID)];
}

+(COMPANy_STAT_ID)getEnumForCompanyStatID:(int)ID{
    switch (ID) {
        case 0:return Name;
        case 1:return Mobile;
        case 2:return Email;
        case 3:return validcontac;
            
        case 4: return Staticphone;
        case 5: return Address;
        case 6: return Type;
        case 7: return Summary;
        case 8: return JobTitlestructure;
        case 9: return Functionlist;
        case 10: return Activationcode;
        case 11: return Activationtime;
        case 12: return uniqueID;
        case 13: return CurrentPurchaseinfo;
        case 14: return MaxMember;
        default:
            return 10000;
    }
}

+(NSString *)getKeyNameForCompanyStatID:(COMPANy_STAT_ID)ID{
    switch (ID) {
        case Name:return @"Name";
        case Mobile:return @"Mobile";
        case Email:return @"Email";
        case validcontac:return @"Validcontact";
            
        case Staticphone: return @"Staticphone";
        case Address: return @"Address";
        case Type: return @"Type";
        case Summary: return @"Summary";
        case JobTitlestructure: return @"JobTitlestructure";
        case Functionlist: return @"Functionlist";
        case Activationcode: return @"Activationcode";
        case Activationtime: return @"Activationtime";
        case uniqueID: return @"UniqueID";
        case CurrentPurchaseinfo: return @"CurrentPurchaseinfo";
        case MaxMember: return @"MaxMember";
        default:
            return nil;
    }
}

/**
 *  放回COMPANy_STAT_ID
 *
 *  @param 枚举对应的字符串
 */






+(COMPANy_STAT_ID)getEnumFormStr:(NSString *)str{
    
    if ([CommonFunctions functionsIsStringValidAfterTrim:str]) {
        if ([str isEqualToString:@"Name"]) {
            return Name;
        }else if ([str isEqualToString:@"Mobile"]){
            return Mobile;
        }else if ([str isEqualToString:@"Email"]){
            return Email;
        }else if ([str isEqualToString:@"Validcontact"]){
            return validcontac;
        }else if ([str isEqualToString:@"Staticphone"]){
            return Staticphone;
        }else if ([str isEqualToString:@"Address"]){
            return Address;
        }else if ([str isEqualToString:@"Type"]){
            return Type;
        }else if ([str isEqualToString:@"Summary"]){
            return Summary;
        }else if ([str isEqualToString:@"JobTitlestructure"]){
            return JobTitlestructure;
        }else if ([str isEqualToString:@"Funtionlist"]){
            return Functionlist;
        }else if ([str isEqualToString:@"Activationcode"]){
            return Activationcode;
        }else if ([str isEqualToString:@"Activationtime"]){
            return Activationtime;
        }else if ([str isEqualToString:@"UniqueID"]){
            return uniqueID;
        }else if ([str isEqualToString:@"CurrentPurchaseinfo"]){
            return CurrentPurchaseinfo;
        }else if([str isEqualToString:@"MaxMember"]){
            return MaxMember;
        
        }
    }
    return  1000;
}

@end
