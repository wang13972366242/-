//
//  UserOperationResultForGlobalAdmin.m
//  Admint
//
//  Created by wang on 2016/11/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperationResultForGlobalAdmin.h"


@implementation UserOperationResultForGlobalAdmin

//===============================构造函数=======================================
/**
 * 构造函数 - 操作成功时；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @param operation	- 全局管理员可对用户使用的操作；
 * @param szUserAccount - 被处理的用户帐号；
 * @throws OrganizedException - 参数有误抛出异常；
 */
-(instancetype)initWithENUM:(ADMINMNG_USER_OPERATION)operation account:(NSString *)szUserAccount{
    NSString *userO = [UserOperationByGlobalAdmin getStringForEnum:operation];
    if (self = [super initWithOperation:userO account:szUserAccount]) {
        
    }
    return self;

}


/**
 * 获取管理类型的枚举值；
 * @return {@linkplain ADMINMNG_USER_OPERATION}
 */
-(ADMINMNG_USER_OPERATION) getUserOperationByAdmin{
    @try {
        [UserOperationByGlobalAdmin getEnumForStr:self.m_eOperation];
    } @catch (NSException *exception) {
        return -1;
    }
  
}


-(void)addOrganizedMember:(NSString *) szClientDetails{
    if(![self isSucceeded] || [self getUserOperationByAdmin]!= QUERY_USER_CLIENT){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_RESULT_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
        
    }
    [self __addOrganizedMember:szClientDetails];
}


-(OrganizedMember *) getOrganizedMember{
    
    if(![self isSucceeded] || [self getUserOperationByAdmin]!= QUERY_USER_CLIENT){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_RESULT_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
        
    }
    return [self __getOrganizedMember];
    
}


@end
