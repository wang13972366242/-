//
//  OrganizedDepartment.m
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedDepartment.h"

@implementation OrganizedDepartment



-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_szDepartmentName forKey:@"m_szDepartmentName"];
      [aCoder encodeObject:self.m_myJobTitleList forKey:@"m_myJobTitleList"];
    
    
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
         self.m_myJobTitleList = [aDecoder decodeObjectForKey:@"m_myJobTitleList"];
        
        self.m_szDepartmentName = [aDecoder decodeObjectForKey:@"m_szDepartmentName"];
    }
    return self;
}

-(instancetype)initWithDepartName:(NSString *)szName array:(NSArray *)jobTitles{
    if (self = [super init]) {
        if(![CommonFunctions functionsIsStringValidAfterTrim:szName]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"部门名字为空" userInfo:nil];
            [Ce raise];


        }
        
        _m_szDepartmentName = szName;
        if(jobTitles != nil){
            _m_myJobTitleList =[NSMutableArray arrayWithObjects:jobTitles, nil];
        }
    }
    return self;
}

-(instancetype)initWthJson:(NSString *)szIDlist{
    if (self = [super init]) {
        if(![CommonFunctions functionsIsStringValidAfterTrim:szIDlist]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"部门字符串为空" userInfo:nil];
            [Ce raise];
            
        }
        NSDictionary  *object = nil;
        @try {
            object = [CommonFunctions functionsFromJsonStringToObject:szIDlist];
            
        } @catch (NSException *exception) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"无效的部门json" userInfo:nil];
            [Ce raise];
            
        }
        
        NSString *szValueTmp = [CommonFunctions getStringFromJsonObjectEvenKeyIsntExit:object key:@"Name"];
        if(![CommonFunctions functionsIsStringValid:szValueTmp]){
            
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"部门名字无效" userInfo:nil];
            [Ce raise];
        }else{
            _m_szDepartmentName = szValueTmp;
        }
        
        if([[object allKeys] containsObject:@"JobTitles"]){
            
            @try {
                NSArray *array = object[@"JobTitles"];
                if(array != nil){
                    _m_myJobTitleList = [NSMutableArray array];
                    for(id obj in array){
                        NSString *szJobtitle = (NSString *) obj;
                        OrganizedJobTitle *jobTitle =[[OrganizedJobTitle alloc]initWthJson:szJobtitle];
                        [_m_myJobTitleList addObject:jobTitle];
                    }
                }
            } @catch (NSException *exception) {
                CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"职位错误" userInfo:nil];
                [Ce raise];
            }
            
        }	
    }

    return self;
}

-(NSString *)TestString{
    NSMutableString *szLine = [NSMutableString string];
    [szLine appendFormat:@"%-30@ 部门名字： %@;",_m_szDepartmentName ];
    

    if([self hasJobTitles]){
        [szLine appendString:[OrganizedJobTitle TestStringForJobTitleArray:_m_myJobTitleList]];
    }
    
    return szLine;
}

-(NSString *)toString{
    NSMutableDictionary *jsonObject = [NSMutableDictionary dictionary];
    [jsonObject addEntriesFromDictionary:@{@"Name":_m_szDepartmentName}];
    
    if([self hasJobTitles]){
        NSMutableArray *array = [NSMutableArray array];
        for(OrganizedJobTitle *jbtitle in _m_myJobTitleList){
            [array addObject:[jbtitle toString]];

        }
        [jsonObject addEntriesFromDictionary:@{@"JobTitles":array}];
        
    }
    return  [CommonFunctions functionsFromObjectToJsonString:jsonObject];
}

/**
 * 添加职位
 * @param jbtobeadd - 职位不能为空，否则会报错
 * @throws OrganizedException
 */
-(void)AddJobTitle:(OrganizedJobTitle *)jbtobeadd {
    if(jbtobeadd == nil){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"职位为空" userInfo:nil];
        [Ce raise];

    }
    if(![self canAddJobTitle] ||[self  isJobTitleNameExists:jbtobeadd.m_myTitle]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"Too Many jobtitles or duplicated JobTitleName" userInfo:nil];
        [Ce raise];

    }
    [_m_myJobTitleList addObject:jbtobeadd];
    
}
/**
 * 添加职位
 * @param szTitleName - 职位名字
 * @param iLevel - 职位等级
 * @throws OrganizedException
 * @see JobTitle#JobTitle(String,int)
 *
 */

-(void)AddJobTitleAndName:(NSString *)szTitleName iLevel:(int)iLevel{
    OrganizedJobTitle *jobTitle = [[OrganizedJobTitle alloc]initWithNameAndLevel:szTitleName iLevel:iLevel];
    [self AddJobTitle:jobTitle];

}

/**
 * 删除指定名字的职位;
 * @param szTitleName 为null 或者""不响应，不抛异常；<br>处理参数前做了trim操作；
 * @throws OrganizedException  - 找不到职位抛出异常
 *
 */
-(void)removeJobTitle:(NSString *) szTitleName{
    if(![self hasJobTitles]|| ![CommonFunctions functionsIsStringValidAfterTrim:szTitleName]) return ;
    szTitleName = [CommonFunctions functionsClearStringTrim:szTitleName];
    for(OrganizedJobTitle *entry in _m_myJobTitleList) {
        if([entry nameIs:szTitleName]){
            [_m_myJobTitleList removeObject:entry];
	        	  return;
        }
    }
    
    CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"RemoveJobTitle - 找不到该根级职位" userInfo:nil];
    [Ce raise];
}

-(BOOL)hasJobTitles{
    
    return (_m_myJobTitleList != nil && !(_m_myJobTitleList.count != 0)) ? true:false;
}

-(void)setM_szDepartmentName:(NSString *)m_szDepartmentName{

    _m_szDepartmentName = [CommonFunctions functionsClearStringTrim:m_szDepartmentName];

}
-(BOOL)equals:(OrganizedDepartment *)dpt{
    if(dpt == nil) return false;
    if([_m_szDepartmentName isEqualToString:dpt.m_szDepartmentName]){
        if((_m_myJobTitleList == nil && dpt.m_myJobTitleList == nil) || [_m_myJobTitleList isEqualToArray:dpt.m_myJobTitleList]){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}
-(BOOL)canAddJobTitle{
    if(_m_myJobTitleList == nil){
        _m_myJobTitleList = [NSMutableArray array];
        return true;
    }
    return ([self getJobTitleCount] <= MAXJOBTITLES)? true:false;
}

-(int)getJobTitleCount{
    if(![self hasJobTitles]) return 0;
    return (int)_m_myJobTitleList.count;
}

-(BOOL)isJobTitleNameExists:(NSString *)szTitleName{
    if(![self hasJobTitles] || ![CommonFunctions functionsIsStringValidAfterTrim:szTitleName]) return false;
    szTitleName = [CommonFunctions functionsClearStringTrim:szTitleName];
    for(OrganizedJobTitle *entry in  _m_myJobTitleList) {
        if([entry nameIs:szTitleName]){
	        	  return true;
        }
    }
    return false;
}

-(BOOL)nameIs:(NSString *)szName{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szName]) return false;
    if ([szName isEqualToString:_m_szDepartmentName]) {
        return true;
    }else{
    
        return false;
    }
    
}

/**
 * 删除指定名字的职位;
 * @param szTitleName 为null 或者""不响应，不抛异常；<br>处理参数前做了trim操作；
 * @throws OrganizedException  - 找不到职位抛出异常
 *
 */
-(void)RemoveJobTitle:(NSString *) szTitleName{
    if( [self hasJobTitles] ||![CommonFunctions functionsIsStringValidAfterTrim: szTitleName]) return ;
    szTitleName = [CommonFunctions functionsClearStringTrim:szTitleName];
    
    NSArray *arr = [_m_myJobTitleList mutableCopy];
    for(OrganizedJobTitle *entry in arr) {
        if([entry nameIs:szTitleName]){
	        	  [_m_myJobTitleList removeObject:entry];
            
	        	  return;
        }
    }

}
@end
