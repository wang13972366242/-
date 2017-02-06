//
//  UserBean.h
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceUniqueID.h"
@interface UserBean : NSObject<NSCoding>


typedef enum {
    LoginName,
    LoginPassword,
    DeviceID,
}USER_BEAN_STAT;

@property(nonatomic,strong) NSString *m_szUsername;

@property(nonatomic,strong) NSString *m_szPassword;

@property(nonatomic,strong) DeviceUniqueID *m_objDeviceID;

-(instancetype)initWithszUsername:(NSString *)szUsername szPassword:(NSString *)szPassword objDeviceID:(DeviceUniqueID*)objDeviceID;
-(instancetype)initWith:(NSString*)szUserBeanJsonString;
-(NSString *)toString;


-(instancetype)initWithPasswod:(NSString *)passWord;
-(BOOL)isValid;




@end
