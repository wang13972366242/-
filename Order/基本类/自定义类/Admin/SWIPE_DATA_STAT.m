//
//  SWIPE_DATA_STAT.m
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SWIPE_DATA_STAT.h"

@implementation SWIPE_DATA_STAT
-(NSString *) getDBColumnName{
    return NSStringFromClass([self class]);
}


//-(NSString *) getDBColumnType:(SWIPE_DATA_stat)type{
//    switch (type) {
//        case ID:
//            return @"int auto_increment primary key";
//        case USER_ACCOUNT:
//            return @"char(64) not null";
//        case DATE:
//            return @"DATE not null";
//        case TIME_FIRST:
//            return @"TIME";
//        case TIME_LAST:
//            return @"TIME";
//        case SWIPENODE_TYPE:
//            return @""
//        case SWIPENODE_NAME:
//            return "char(255) not null";
//        case SWIPECONFIG_NAME:
//            return String.format("char(%d) not null", FunctionUserSwipe.MAXSWIPENAMELENGTH * 2 + 2);
//        case DATATYPE:
//            return  CommonFunctions.joinString("","enum(",FunctionUserSwipe.SWIPEDATATYPE.getDBEnumString(),") not null");
//        case OS:
//        case UUID:
//            return @"char(128) not null";
//        default:
//            break;
//    }
//    return @"";
//}

//	public static String getDBInsertString(){
//		String szAll = "";
//		for(SWIPE_DATA_STAT stat_ID : SWIPE_DATA_STAT.values()){
//			String szColumnDes = CommonFunctions.joinString(" ", stat_ID.getDBColumnName(),stat_ID.getDBColumnType());
//			szAll = CommonFunctions.joinString(",", szAll,szColumnDes);
//		}
//		//添加一个constraint
////		String szCombine = _getStatDBColumnName(USER_STAT_ID.MyCompanyID) + "," + _getStatDBColumnName(USER_STAT_ID.EmployeeNumber);
////		szAll =  szAll.concat(",constraint CompanyEmployeeNumber unique(" + szCombine + "))");
////
//		return "("+szAll+")";
//	}


//
//public boolean isValueValidForKey(String szValue) {
//    switch (this) {
//        case ID:
//            return szValue == null ? true : CommonFunctions.isIntNumber(szValue);
//        case USER_ACCOUNT:
//            return CommonFunctions.isValidUserName(szValue);
//        case DATE:
//            return CommonFunctions.isValidData(szValue);
//        case TIME_FIRST:
//        case TIME_LAST:
//            return !CommonFunctions.isStringValid(szValue) ? true: CommonFunctions.isValidDayTimeFormat(szValue);
//        case SWIPENODE_TYPE:
//        {
//            try{
//                SWIPENODETYPE.valueOf(szValue);
//                return true;
//            }catch(Exception e){
//                return false;
//            }
//        }
//        case SWIPENODE_NAME:
//        case SWIPECONFIG_NAME:
//        case OS:				
//        case UUID:
//            //TODO 是否要仔细检测？
//            return CommonFunctions.isStringValidAfterTrim(szValue);
//        case DATATYPE:
//        {
//            try{
//                SWIPEDATATYPE.valueOf(szValue);
//                return true;
//            }catch(Exception e){
//                return false;
//            }
//        }		
//        default:
//            break;
//    }
//    return false;
//}
//}
//
//

+(NSString *)SWIPE_DATA_STATString:(SWIPE_DATA_stat)type{
    switch (type) {
        case ID:
           return  @"ID";
            break;
        case USER_ACCOUNT:
            return  @"USER_ACCOUNT";
            break;
        case DATE:
            return  @"DATE";
            break;
        case TIME_FIRST:
            return  @"TIME_FIRST";
            break;
        case TIME_LAST:
            return  @"TIME_LAST";
            break;
        case SWIPENODE_TYPE:
            return  @"SWIPENODE_TYPE";
            break;
        case SWIPENODE_NAME:
            return  @"SWIPENODE_NAME";
            break;
        case SWIPECONFIG_NAME:
            return  @"SWIPECONFIG_NAME";
            break;
        case DATATYPE:
            return  @"DATATYPE";
            break;
        case OS:
            return  @"OS";
            break;
        case UUID:
            return  @"UUID";
            break;
        default:
            break;
    }

}



+(SWIPE_DATA_stat)SWIPE_DATA_STATEnum:(NSString *)stat{

    if ([stat isEqualToString:@"ID"]) {
        return ID;
    }else if ([stat isEqualToString:@"USER_ACCOUNT"]){
        return USER_ACCOUNT;
    
    }else if ([stat isEqualToString:@"DATE"]){
        return DATE;
        
    }else if ([stat isEqualToString:@"TIME_FIRST"]){
        return TIME_FIRST;
        
    }else if ([stat isEqualToString:@"TIME_LAST"]){
        return TIME_LAST;
        
    }else if ([stat isEqualToString:@"SWIPENODE_TYPE"]){
        return SWIPENODE_TYPE;
        
    }else if ([stat isEqualToString:@"SWIPENODE_NAME"]){
        return SWIPENODE_NAME;
        
    }else if ([stat isEqualToString:@"SWIPECONFIG_NAME"]){
        return SWIPECONFIG_NAME;
        
    }else if ([stat isEqualToString:@"DATATYPE"]){
        return DATATYPE;
        
    }else if ([stat isEqualToString:@"OS"]){
        return OS;
        
    }else if ([stat isEqualToString:@"UUID"]){
        return UUID;
        
    }
    return 1234456;
}



+(NSArray *)SWIPE_DATA_statAllKeys{
    NSArray *allkeys = @[@"ID",@"USER_ACCOUNT",@"DATE",@"TIME_FIRST",@"TIME_LAST",@"SWIPENODE_TYPE",@"SWIPENODE_NAME",@"SWIPECONFIG_NAME",@"DATATYPE",@"OS",@"UUID"];
    return allkeys;
}
@end
