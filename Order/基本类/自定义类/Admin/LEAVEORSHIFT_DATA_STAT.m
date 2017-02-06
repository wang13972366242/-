//
//  LEAVEORSHIFT_DATA_STAT.m
//  Order
//
//  Created by wang on 2016/12/2.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "LEAVEORSHIFT_DATA_STAT.h"

@implementation LEAVEORSHIFT_DATA_STAT
//
//-(BOOL)isValueValidForKey:(NSString *)szValue enumKey:(LEAVEORSHIFT_DATA_stat)DATA_stat{
//    switch (DATA_stat) {
//        case ID:
//            return szValue == nil ? true : CommonFunctions.isIntNumber(szValue);
//        case TYPE:
//            try{
//                LEAVEORSHIFT_TYPE.valueOf(szValue);
//                return true;
//            }catch(Exception e){
//                CommonFunctions.showDebugInfo(e.getClass().getName(),e.getMessage());
//                return false;
//            }
//        case START:
//        case END:
//        case SUBMITTIME:
//        {
//            return CommonFunctions.dateTimeStringToCalendar(szValue) != null;
//        }
//            
//        case SHIFT_END:
//        case SHIFT_START:
//        {
//            return szValue == null ? true : CommonFunctions.dateTimeStringToCalendar(szValue) != null;
//        }
//        case APPLICANT_REALNAME:
//        case APPROVER_REALNAME:
//        case APPROVER_ACOUNT:
//        case APPLICANT_ACOUNT:
//            return CommonFunctions.isValidUserName(szValue);
//        case REASON:
//        case COMMENT:
//            return true;
//        case STATUS:
//            try{
//                REQUEST_STATUS.valueOf(szValue);
//                return true;
//            }catch(Exception e){
//                CommonFunctions.showDebugInfo(e.getClass().getName(),e.getMessage());
//                return false;
//            }
//        default:
//            break;
//    }
//    return false;
//}


+(NSString *)LEAVEORSHIFT_DATA_statString:(LEAVEORSHIFT_DATA_stat)type{
    switch (type) {
        case iD:
            return  @"ID";
            break;
        case TYPE:
            return  @"TYPE";
            break;
        case START:
            return  @"START";
            break;
        case END:
            return  @"END";
            break;
        case SHIFT_START:
            return  @"SHIFT_START";
            break;
        case SHIFT_END:
            return  @"SHIFT_END";
            break;
        case SUBMITTIME:
            return  @"SUBMITTIME";
            break;
        case REASON:
            return  @"REASON";
            break;
        case APPLICANT_ACOUNT:
            return  @"APPLICANT_ACOUNT";
            break;
        case APPROVER_ACOUNT:
            return  @"APPROVER_ACOUNT";
            break;
        case APPLICANT_REALNAME:
            return  @"APPLICANT_REALNAME";
            break;
        case APPROVER_REALNAME:
            return  @"APPROVER_REALNAME";
            break;
        case COMMENT:
            return  @"COMMENT";
            break;
        case STATUS:
            return  @"STATUS";
            break;
        default:
            break;
    }
    
}



+(LEAVEORSHIFT_DATA_stat)LEAVEORSHIFT_DATA_statEnum:(NSString *)stat{
    
    if ([stat isEqualToString:@"ID"]) {
        return iD;
    }else if ([stat isEqualToString:@"TYPE"]){
        return TYPE;
        
    }else if ([stat isEqualToString:@"START"]){
        return START;
        
    }else if ([stat isEqualToString:@"END"]){
        return END;
        
    }else if ([stat isEqualToString:@"SHIFT_START"]){
        return SHIFT_START;
        
    }else if ([stat isEqualToString:@"SHIFT_END"]){
        return SHIFT_END;
        
    }else if ([stat isEqualToString:@"SUBMITTIME"]){
        return SUBMITTIME;
        
    }else if ([stat isEqualToString:@"REASON"]){
        return REASON;
        
    }else if ([stat isEqualToString:@"APPLICANT_ACOUNT"]){
        return APPLICANT_ACOUNT;
        
    }else if ([stat isEqualToString:@"APPROVER_ACOUNT"]){
        return APPROVER_ACOUNT;
        
    }else if ([stat isEqualToString:@"APPLICANT_REALNAME"]){
        return APPLICANT_REALNAME;
        
    }else if ([stat isEqualToString:@"APPROVER_REALNAME"]){
        return APPROVER_REALNAME;
        
    }else if ([stat isEqualToString:@"COMMENT"]){
        return COMMENT;
        
    }else if ([stat isEqualToString:@"STATUS"]){
        return STATUS;
        
    }
    return 1234456;
}



+(NSArray *)LEAVEORSHIFT_DATA_statAllKeys{
    NSArray *allkeys = @[@"ID",@"TYPE",@"START",@"END",@"SHIFT_START",@"SHIFT_END",@"SUBMITTIME",@"REASON",@"APPLICANT_ACOUNT",@"APPROVER_ACOUNT",@"APPLICANT_REALNAME",@"APPROVER_REALNAME",@"COMMENT",@"STATUS"];
    return allkeys;
}
@end
