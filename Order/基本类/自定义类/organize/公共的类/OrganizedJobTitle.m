//
//  OrganizedJobTitle.m
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedJobTitle.h"
#import "CommonFunctions.h"
#import "CodeException.h"
@implementation OrganizedJobTitle


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_myTitle forKey:@"m_myTitle"];
    
    NSNumber *number = [NSNumber numberWithInt:(self.m_imyLevel)];
    [aCoder encodeObject:number forKey:@"m_imyLevel"];
    
    
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        NSNumber *number = [aDecoder decodeObjectForKey:@"m_imyLevel"] ;
        self.m_imyLevel = [number intValue];
        self.m_myTitle = [aDecoder decodeObjectForKey:@"m_myTitle"];
    }
    return self;
}

-(instancetype)initWithNameAndLevel:(NSString *)szTitleName iLevel:(int)iLevel{
    if (self = [super init]) {
        if(![CommonFunctions functionsIsStringValidAfterTrim:szTitleName]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"职位名称为空" userInfo:nil];
            [Ce raise];
            
        }
        
        if (![JobTitleFunctions _s_isValidLevel:iLevel limitMax:MAXLEVEL]) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"职位等级超过范围" userInfo:nil];
            [Ce raise];
            
        }
      
        szTitleName =[CommonFunctions  functionsClearStringTrim:szTitleName];
        _m_myTitle = szTitleName;
        _m_imyLevel = iLevel;
    }
    return self;
  
  
}


/**
 * 根据json string解析恢复对象。
 * @param szJBStr - json string
 * @throws OrganizedException 解析失败抛出异常；
 */

-(instancetype)initWthJson:(NSString *)szJBStr{
    if (self = [super init]) {
    if(![CommonFunctions  functionsIsStringValidAfterTrim:szJBStr]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"职位字符串为空" userInfo:nil];
        [Ce raise];
      
    }
        NSArray *strings = [szJBStr componentsSeparatedByString:@"-"];
    if(strings.count != 2 || ![CommonFunctions functionsIsArrayValid:strings]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"职位字符格式错误" userInfo:nil];
        [Ce raise];
        
    }
        
        @try {
            _m_imyLevel = [strings[0] intValue];
        } @catch (NSException *exception) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"职位字符格式错误" userInfo:nil];
            [Ce raise];
        }
        
//        if(![JobTitleFunctions _s_isValidLevel:_m_imyLevel limitMax:MAXLEVEL]){
//            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"职位等级超过范围" userInfo:nil];
//            [Ce raise];
//            
//        }
   
    _m_myTitle = strings[1];
    }
    return self;
}

/**
 * 判断职位对象是否相同
 * @param jbtitle - 待测对象
 * @return 如果职位对象名字和等级都相同，返回true, 否则false;
 */
-(BOOL)equals:(OrganizedJobTitle *)jbtitle{
    if([_m_myTitle isEqualToString:jbtitle.m_myTitle] && _m_imyLevel == jbtitle.m_imyLevel){
        return true;
    }else{
        return false;
    }
}

/**
 * 判断当前职位是否具备指定的名字
 * @param szName - 操作前trim, 为null 或 ""时，直接返回false;
 * @return	true - 名字相同，false - 不同；
 */
-(BOOL)nameIs:(NSString *) szName{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szName]) return false;
    return [szName isEqualToString:_m_myTitle] ? true:false;
}


/**
 * 设置职位名字
 * @param szName	- 新名字
 * @throws OrganizedException - 名字为空，或者纯空白，返回异常。
 */
-(void)setM_myTitle:(NSString *)m_myTitle{
   
    _m_myTitle = [CommonFunctions functionsClearStringTrim:m_myTitle];

}

/**
 * 设置职位等级, 最高等级为1，数字越小，权限越大。
 * @param iLevel - <b>Range: 1-255</b>
 * @throws OrganizedException  超出限制，抛异常
 */
-(void)setM_imyLevel:(int)m_imyLevel{
       if(![JobTitleFunctions _s_isValidLevel:m_imyLevel limitMax:MAXLEVEL]){
       CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_SET_ERROR" reason:@"职位超出范围" userInfo:nil];
       [Ce raise];
        
    }
    if(m_imyLevel != _m_imyLevel) _m_imyLevel = m_imyLevel;
}
-(NSString *)toString {
    NSString *level = [NSString stringWithFormat:@"%D", _m_imyLevel ];
    NSString *szNew = [level stringByAppendingString:@"-"];
    NSString *szNew1 = [szNew stringByAppendingString:_m_myTitle];

    return szNew1;

}


+(NSString *)testStringForJobTitleArray:(NSArray *)arrJobs{
    NSMutableString *szLine =[NSMutableString string];
    if(arrJobs == nil || arrJobs.count == 0){
        return szLine;
    }else{
        [szLine appendString:@"职位表:  "];
        int i = 0;
        for(OrganizedJobTitle *jbtitle in arrJobs){
            if(i!=0) [szLine appendFormat:@","];
            [szLine appendString:[jbtitle toString]];
            ++i;
        }
    }
    return szLine;
}

@end
