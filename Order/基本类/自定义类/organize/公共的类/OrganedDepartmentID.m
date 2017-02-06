//
//  OrganedDepartmentID.m
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganedDepartmentID.h"
#import "CodeException.h"
#import "CommonFunctions.h"
@implementation OrganedDepartmentID

-(id)copy{
    return self;
}
-(id)copyWithZone:(NSZone *)zone{

    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_arrayLevels forKey:@"m_arrayLevels"];
    

}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.m_arrayLevels = [aDecoder decodeObjectForKey:@"m_arrayLevels"];
    }
    return self;
}
-(instancetype)initWith:(NSMutableArray *)arrLevels{

    if (self = [super init]) {
        if (arrLevels != nil) {
            if (arrLevels.count  > MAXLEVEL) {
                CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"部门等级过大" userInfo:nil];
                [Ce raise];
            }
            _m_arrayLevels = [NSMutableArray array];
            for (NSNumber *number in arrLevels) {
                int i = [number intValue];
                if (![JobTitleFunctions _s_isValidLevel:i limitMax:MAXDEPARTMENTS]) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"子部门过多" userInfo:nil];
            [Ce raise];
                }
                [_m_arrayLevels addObject:number];
            }
            
            
        }
    }

    return self;
}

/**
 * 复制一个DepartmentID;
 * @param departid
 * @throws OrganizedException
 */
-(instancetype)initWithCopyDepartmentID:(OrganedDepartmentID *)departid{
    
    if (self = [super init]) {
  
        
        if(departid != nil && departid.m_arrayLevels != nil){
            _m_arrayLevels = [NSMutableArray array];
            for (NSNumber *number in departid.m_arrayLevels) {
                [_m_arrayLevels addObject:number];
            }
            
        }else{
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"部门ID为空" userInfo:nil];
            [Ce raise];
            
        }
    }
    return self;
}

-(instancetype)initWthJson:(NSString *)szIDlist {
    
    if (self = [super init]) {
        
    
    if(![CommonFunctions functionsIsStringValidAfterTrim:szIDlist]) return nil;
        _m_arrayLevels = [NSMutableArray array];
        NSArray *szArr = [szIDlist componentsSeparatedByString:@"\\."];
    if(szArr == nil)
    {
        NSInteger integer = 0;
        @try {
            integer = [szIDlist integerValue];
        } @catch (NSException *exception) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:exception.reason userInfo:nil];
            [Ce raise];
        }
        [self AddLevel:(int)integer];
        
    }else{
        for(NSString *ID in szArr)
        {
            NSInteger integer = 0;
            @try {
                integer = [ID integerValue];
            } @catch (NSException *exception) {
                CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:exception.reason userInfo:nil];
                [Ce raise];
            }
            
            [self AddLevel:(int)integer];
        }
    }
    }
    return self;
}


/**
 * 生成根级部门ID - 做了边界检测 1-MAX_LEVEL
 * @param iNewLevel - 新的根级ID
 * @throws OrganizedException - 无效ID会抛出异常。
 */
-(instancetype)initWithNewDepartIDNewLevel:(int)iNewLevel{
    if (self = [super init]) {
        if(![JobTitleFunctions _s_isValidLevel:iNewLevel limitMax:MAXDEPARTMENTS] ){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"DepartmentID:AddLevel-too many departments" userInfo:nil];
            [Ce raise];
            
        }
        _m_arrayLevels = [NSMutableArray array];
        [_m_arrayLevels addObject:@(iNewLevel)];
    }
   
    return  self;
}
-(int)getIDAt:(int)iIndex{
    int iCurrent = [self getLevelCount];
    if(iCurrent == 0 || iCurrent <= iIndex) return -1;
    NSString *str = [_m_arrayLevels objectAtIndex:iIndex];
    return [str intValue];
}

-(void)setIDAt:(int)iIndex iValue:(int)iValue{
    int iCurrent = [self getLevelCount];
    if(iCurrent == 0 || iCurrent <= iIndex || ![JobTitleFunctions _s_isValidLevel:iValue limitMax:MAXDEPARTMENTS]) return;
    [_m_arrayLevels replaceObjectAtIndex:iIndex withObject:@(iValue)];

}


/**
 * 获取上一级的parentID
 * @return 返回的是父节点DepartmentID的副本
 * @throws OrganizedException - 构造失败抛异常
 */
-(OrganedDepartmentID*)getParentLevelID{
    if(![self hasParent]) return nil;
    NSMutableArray *parentList = [_m_arrayLevels mutableCopy];
    NSInteger parentI = parentList.count -1;
    [parentList removeObjectAtIndex:parentI];

    OrganedDepartmentID *departmentID = [[OrganedDepartmentID alloc]initWith:parentList];
    return departmentID;
}
-(BOOL)isChildOf:(OrganedDepartmentID *)idParent{
    if(![self hasParent] && idParent == nil) return true;
    if([self hasParent]  &&[[self  getParentLevelID] equals:idParent]){
        return true;
    }
    return false;
}

-(BOOL)equals:(OrganedDepartmentID *)idinput{
    if(idinput == nil) return false;
    if([_m_arrayLevels isEqualToArray: idinput.m_arrayLevels ]){
        return true;
    }else{
        return false;
    }
    
}

//ID starts From 1;

-(void)AddLevel:(int)iNewLevel {
    if (![JobTitleFunctions _s_isValidLevel:iNewLevel limitMax:MAXDEPARTMENTS]) {
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"DepartmentID:AddLevel-too many departments" userInfo:nil];
        [Ce raise];
    }
    

    if(_m_arrayLevels == nil){
        _m_arrayLevels = [NSMutableArray array];
    }else if([self getLevelCount] >= MAXLEVEL){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"DepartmentID:AddLevel-too many levels" userInfo:nil];
        [Ce raise];
    }
    
    [_m_arrayLevels addObject:@(iNewLevel)];
}


-(int)getLevelCount{
    if(_m_arrayLevels == nil) return 0;
    return (int)_m_arrayLevels.count;
}


-(BOOL)hasParent{
    return ((_m_arrayLevels == nil || _m_arrayLevels.count < 2) ? false:true);
}

/**
 * 针对职位框架中的职位后移出现的情况，把最后一位ID向前移动；
 */
-(void)moveAhead:(int)iDelSrcLevel{
  
    int iCount = [self getLevelCount];
    if(iCount != 0 && iCount >= iDelSrcLevel){
        int iNewValue = [self getIDAt:(iDelSrcLevel -1)] -1;
        [self setIDAt:iDelSrcLevel -1 iValue:iNewValue];
    }
}

-(BOOL)isRelatedDepartID:(OrganedDepartmentID *) idcompare{
    if(idcompare == nil) return false;
    int iCurlen = [self getLevelCount];
    int iCmplen = [idcompare getLevelCount];
    if(iCurlen == 0 || iCmplen == 0) return false;
    if(iCurlen >= iCmplen){
        for(int i= 0; i != iCmplen - 1; ++i){
            if([self getIDAt:i] != [idcompare getIDAt:i]){
                return false;
            }
        }
        
        if ([self getIDAt:iCmplen -1] >[idcompare getIDAt:iCmplen -1]) {
             return true;
        }
       
    }
    return false;
}


-(NSString *)toString{
    if(_m_arrayLevels == nil || _m_arrayLevels.count <1) return nil;
    NSMutableString *szFinal  = [NSMutableString string];
    for(id numberInteger in _m_arrayLevels){
        int i = [numberInteger intValue];
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [szFinal appendString:str];
        [szFinal appendString:@"."];
    }
    
    NSRange rangeHttp = [szFinal rangeOfString:@"." options:NSBackwardsSearch];
    if (rangeHttp.location != NSNotFound) {
      szFinal = (NSMutableString *)[szFinal substringWithRange:NSMakeRange(0, szFinal.length -1)];
    }
    
    return szFinal;
}


-(int)compareTo:(OrganedDepartmentID *)id2 {
   
    int iLevelCur = [self getLevelCount];
    int iLevelCmp = [id2 getLevelCount];
    int iMin = iLevelCmp > iLevelCur ? iLevelCur:iLevelCmp;
    for(int i=0; i != iMin; ++i){
        int val1 = [self getIDAt:i];
        int val2 =  [id2 getIDAt:i];
        if(val1 > val2){
            return 1;
        }else if(val1 < val2){
            return -1;
        }
    }
    if(iLevelCmp == iLevelCur){
        return 0;
    }else if(iLevelCmp > iLevelCur){
        return -1;
    }else{
        return 1;
    }

}

@end
