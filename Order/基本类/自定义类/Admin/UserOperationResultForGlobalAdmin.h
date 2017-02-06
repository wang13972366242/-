//
//  UserOperationResultForGlobalAdmin.h
//  Admint
//
//  Created by wang on 2016/11/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperationResult.h"
#import "UserOperationByGlobalAdmin.h"
@interface UserOperationResultForGlobalAdmin : UserOperationResult

-(instancetype)initWithENUM:(ADMINMNG_USER_OPERATION)operation account:(NSString *)szUserAccount;

-(ADMINMNG_USER_OPERATION) getUserOperationByAdmin;

-(void)addOrganizedMember:(NSString *) szClientDetails;

-(OrganizedMember *) getOrganizedMember;
@end
