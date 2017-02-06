//
//  JobTitleStructure.m
//  Order
//
//  Created by wang on 2016/10/25.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "JobTitleStructure.h"


#import "OrganizedDepartment.h"
#import "OrganizedCompany.h"


@implementation JobTitleStructure

-(NSMutableArray *)m_rootJobTitles{
    if (_m_rootJobTitles == nil) {
        _m_rootJobTitles = [NSMutableArray array];
    }
    return _m_rootJobTitles;
}

-(NSMutableDictionary *)m_hashDepartments{
    if (_m_hashDepartments == nil) {
        _m_hashDepartments = [NSMutableDictionary dictionary];
    }
    return _m_hashDepartments;

}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:Instance.m_hashDepartments forKey:@"m_hashDepartments"];
    
    [aCoder encodeObject:Instance.m_rootJobTitles forKey:@"m_rootJobTitles"];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        Instance.m_rootJobTitles = [aDecoder decodeObjectForKey:@"m_rootJobTitles"];
        Instance.m_hashDepartments = [aDecoder decodeObjectForKey:@"m_hashDepartments"];
    }
    return Instance;
}

static JobTitleStructure *Instance = nil;
+ (JobTitleStructure *)sharedJobTitleStructure
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[JobTitleStructure alloc]init];
    });
    return Instance;
}

/**
 * 生成一个空的职位框架对象
 */
-(instancetype)init{
    if (self = [super init]) {
        
        if (_m_hashDepartments== nil ) {
        _m_hashDepartments = [NSMutableDictionary dictionary];
        }
        
    }
    return self;
}



/**
 * 从传入的职位框架对象拷贝一份，
 * @param jbold 被复制的对象
 * @throws OrganizedException - 传入对象为空则抛出异常
 */

-(instancetype)initWithJbold:(JobTitleStructure *)jbold{
    if (self = [super init]) {
        if(jbold == nil || [jbold _isAllEmpty]){
           NSString *reasonStr = @"JobTitleStructure:Empty JobTitleStructure obj to be copied";
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:reasonStr userInfo:nil];
        [Ce raise];
        }
        if(![jbold _isDepartmentEmpty]){
            _m_hashDepartments = jbold.m_hashDepartments;

        }
        if(![jbold _isRootJobTitleEmpty]){
            _m_rootJobTitles = [NSMutableArray arrayWithObjects:jbold.m_rootJobTitles, nil];
            
        }
        
    }
    return self;

}

-(void)getJobTitles:(NSDictionary *)jsonObject{
    if(jsonObject == nil || jsonObject.count < 1){
        
        NSString *reasonStr = @"JobTitleStructure:Empty JobTitleStructure obj to be copied";
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:reasonStr userInfo:nil];
        [Ce raise];
    }
   
    if([[jsonObject allKeys] containsObject:@"ROOTDEPART"]){
        NSMutableArray  *array = jsonObject[@"ROOTDEPART"];
        if(array != nil && array.count > 0){
            
            for(NSDictionary *object in array){
                NSString *IDStr = object[@"DEPARTID"];
                OrganedDepartmentID  *ID  = [[OrganedDepartmentID alloc]initWthJson:IDStr];
                
                NSString *departStr = object[@"DEPARTMENT"];
                OrganizedDepartment *department = [[OrganizedDepartment alloc]initWthJson:departStr];
                [self.m_hashDepartments addEntriesFromDictionary:@{ID:department}];
                
            }
        }
    }
    
    if([[jsonObject allKeys] containsObject:@"ROOTJOB"]){
        NSArray *array = jsonObject[@"ROOTJOB"];
        if(array != nil && array.count > 0){
           self.m_rootJobTitles = [NSMutableArray array];
            for(OrganizedJobTitle *jobTitle in array){
                [self.m_rootJobTitles addObject:jobTitle];
                
            }
        }
    }
  		



}


/**
 * 从接收到的json string分析创建对象
 * @param szInputString - 职位框架的jsonstring
 * @throws OrganizedException - 读出的对象不合法，抛出异常
 * @throws JSONException  OrganizedException
 *
 * 非json string非职位框架可理解格式，抛出异常
 *
 */

-(instancetype)initWithJsonString:(NSString*)szInputString{
    
    if (self = [super init]) {
        
        NSDictionary *dic = (NSDictionary *)[CommonFunctions functionsFromJsonStringToObject:szInputString];
        
        [self getJobTitles:dic];
    
}
    
    return self;
}

//==============================================Public Class Functions========================
/**
 * 添加部门 - 支持添加根级部门
 * @param szNewDepartmentName  - 部门名字 为null时，添加根级部门
 * @param szParentDepartment   - 父级部门名字
 * @throws OrganizedException	- 需要添加的部门名字不合法（为空或者全空白）时，跳出异常。
 */

-(void)addDepartment:(NSString *)szNewDepartmentName szParentDepartment:(NSString*)szParentDepartment{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szNewDepartmentName ]){
        NSString *reasonStr = @"AddDepartment: Empty Department Name";
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:reasonStr userInfo:nil];
        [Ce raise];
    }
    
    szNewDepartmentName = [CommonFunctions functionsClearStringTrim:szNewDepartmentName];
    OrganizedDepartment *parentdpt = nil;
    if([CommonFunctions functionsIsStringValidAfterTrim:szParentDepartment ]){
        parentdpt = [self _findDepartByName:szParentDepartment];
    }
    [self _addDepartment:parentdpt newDepartName:szNewDepartmentName];
}


/**
 * 添加根级部门
 * @param szNewDepartmentName - 根级部门名字
 * @throws OrganizedException <br>- 需要添加的部门名字不合法（为空或者全空白，或已存在）时，跳出异常。
 * <br>-边界检测失败（超出限制）抛出异常
 */

-(void)addDepartment:(NSString *)szNewDepartmentName{
    OrganizedDepartment *NoPA = nil;
    [self _addDepartment:NoPA newDepartName:szNewDepartmentName];
    
}
/**
 * 删除指定部门
 * @param szDepartmentName - 指定部门名字, 为null或者空，不处理
 * @throws OrganizedException 若找不到部门，抛出异常
 */
-(void)removeDepartment:(NSString *) szDepartmentName{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szDepartmentName]) return;
    OrganedDepartmentID *iDepartmentID =[self _findDepartIDByName:szDepartmentName];
    NSMutableArray *ids = (NSMutableArray *)[self _getChildrenDepartmentID:iDepartmentID brec:true];
    if(ids == nil) ids = [NSMutableArray array];
    [ids addObject:iDepartmentID];
    //获取需要更改ID的列表；
    NSMutableArray *idstochange = [self _getAffectedDeparmentID:iDepartmentID];
    int iDelIDLength = [iDepartmentID getLevelCount];
    
    //删除Parent和子集
    for(OrganedDepartmentID *idindex in ids){
        [Instance.m_hashDepartments  removeObjectForKey:idindex];
        
    }
    //改变余下的ID
    if(idstochange != nil){
        for(OrganedDepartmentID *idloop in idstochange){
            [idloop moveAhead:iDelIDLength];
            
        }
    }
}

/**
 * 添加根级职位
 * @param jbtitle - 职位对象
 * @throws OrganizedException - 参数为null，抛出异常
 */

-(void)addRootJobTitle:(OrganizedJobTitle *) jbtitle{
    
    [self addJobTitle:jbtitle szDepartment:nil];
}

/**
 * 添加根级职位
 * @param szJobName - 职位名字
 * @param iLevel - 职位等级
 * @throws OrganizedException - 参数不合格，抛出异常
 */

-(void)addRootJobTitle:(NSString *)szJobName  iLevel:(int) iLevel{
    OrganizedJobTitle *jobTitle = [[OrganizedJobTitle alloc]initWithNameAndLevel:szJobName iLevel:iLevel];
    [self addRootJobTitle:jobTitle];
    
}
/**
 * 为指定部门添加新职位 - 支持添加根级职位
 * @param jbtitle - 职位对象
 * @param szDepartment - 为null时，添加根级职位
 * @throws OrganizedException 职位对象为null抛出异常；不可添加部门时（超出限制）抛出异常
 */

-(void)addJobTitle:(OrganizedJobTitle *)jbtitle szDepartment:(NSString *) szDepartment{
    OrganizedDepartment *parentdpt = nil;
    if([CommonFunctions functionsIsStringValidAfterTrim:szDepartment]){
        parentdpt = [self _findDepartByName:szDepartment];
    }
    [self _addJobTitle:parentdpt job:jbtitle];
    
}


/**
 * 添加职位 - 支持根级和指定部门
 * @param szJobTitle - 职位名称
 * @param iJobLevel  - 部门职位等级
 * @param szDepartment - 为null 添加根级
 * @throws OrganizedException - 职位参数不合格或者不可添加职位（超出限制）时抛出异常
 *
 */

-(void)addJobTitle:(NSString *)szJobTitle iJobLevel:(int) iJobLevel szDepartment:(NSString *) szDepartment {
    OrganizedJobTitle *jbtobeadd = [[OrganizedJobTitle alloc]initWithNameAndLevel:szJobTitle iLevel:iJobLevel];

    if(jbtobeadd != nil)
    [self addJobTitle:jbtobeadd szDepartment:szDepartment];
}


/**
 * 测试用，格式化显示整个职位框架对象
 * @return 格式化字符串（递归显示所有部门和职位）
 */
-(NSString *)testObjec{
    return [self testObjectString:nil bl:YES];
}

/**
 * 测试方法：格式化按指定部门显示对象的数据 <br>
 * - 支持从根部门开始显示
 * @param szParentDepartment - 父部门名字 为null时等同于
 * {@linkplain #testObjectString()}(推荐使用）
 * @param bRecursively - 是否递归显示
 * @return 格式化字符串 对象为空返回空字符串"";
 *
 */
-(NSString *)testObjectString:(NSString *) szParentDepartment bl:(BOOL)bRecursively {
    if([self _isAllEmpty]) return nil;
    NSMutableString *szOutput = [NSMutableString string];
    if(![self _isDepartmentEmpty]){
        if(bRecursively == false){
            NSString *szRootDepart = @"公司直属部门-列表";
            [szOutput appendString:szRootDepart];
        }
        OrganedDepartmentID *idDepartmentID = nil;
        if(szParentDepartment != nil) {
            szParentDepartment =[CommonFunctions functionsClearStringTrim:szParentDepartment];
            @try {
            idDepartmentID = [self _findDepartIDByName:szParentDepartment];
            } @catch (NSException *exception) {
                
            }
          
        }
        NSMutableArray *idset = [NSMutableArray array];
        idset = (NSMutableArray *)[self _getChildrenDepartmentID:idDepartmentID brec:bRecursively];
        if(idset == nil || idset.count == 0) return nil;
        
//        Collections.sort(idset);
        for(OrganedDepartmentID *ID in idset){
            NSString *str;
            if (szOutput.length == 0) {
                 str =@"";
            }else{
            
            str = @"\r\n";
            }
            
            [szOutput appendString:str];
            OrganizedDepartment *depart1 = (OrganizedDepartment *)Instance.m_hashDepartments[ID];
            NSString *szLine = [NSString stringWithFormat:@"%-10@ %@:%@",[ID toString],[depart1 TestString]];
            [szOutput appendString:szLine];
            
        }
    }
    
    if(![self _isRootJobTitleEmpty]){
        NSString *szRootJobs = @"公司直属部门-";
        
       NSString *str1 = [OrganizedJobTitle TestStringForJobTitleArray:Instance.m_rootJobTitles];
        NSString *str2 = [szRootJobs stringByAppendingString:str1];
        [szOutput appendFormat:@"\r\n%@",str2];
        
    }		
    return szOutput;
}

/**
 * 给指定的部门重命名
 * @param szCurrentName - 需要重命名的部门名字
 * @param szNewName - 新名字
 * @throws OrganizedException - 参数有误，新名字存在，不合法，或者需要命名的部门找不到；
 */
-(void)renameDepartment:(NSString *)szCurrentName newStr:(NSString *) szNewName{
    if (szCurrentName.length >1 &&szNewName.length>1) {
        OrganizedDepartment *department = [self _findDepartByName:szCurrentName];
        if([self _hasDepartmentName:szNewName]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"部门名称重复" reason:nil userInfo:nil];
            [Ce raise];
            
        }
        department.m_szDepartmentName = szNewName;
        
    }

   
}

/**
 * 按名字删除根部门的职位
 * @param szJobTitleName  - 要删除的职位名字 (为null或者""时，不操作，不抛异常）
 * @throws OrganizedException - 参数非空但不存在与当前职位框架中，抛出异常
 */
-(void)removeJobTitle:(NSString *) szJobTitleName {
    
    [self _removeRootJobTitle:szJobTitleName]
    ;
}

/**按名字删除部门职位
 *
 * @param szJobTitle  - 职位名字
 * @param szDepartment - 指定职位所属部门<br>
 * 部门为空则删除根级职位, 等同于{@link #removeJobTitle(String szJobTitleName)}
 * @throws OrganizedException - <br>部分非null时，找不到指定部门，抛出异常
 * <br>找不到要删除的职位，抛出异常
 */

-(void)removeJobTitle:(NSString *) szJobTitle departName:( NSString *) szDepartment{
    if(szDepartment == nil){
        [self _removeRootJobTitle:szJobTitle];
        
    }else{
         szDepartment = [CommonFunctions functionsClearStringTrim:szDepartment];
        OrganizedDepartment *parentdpt =[self  _findDepartByName:szDepartment];
 
        [ parentdpt RemoveJobTitle:szJobTitle];
    }
}

-(void)_removeRootJobTitle:(NSString *)szJobTitleName{
    if([self _isRootJobTitleEmpty] || ![CommonFunctions functionsIsStringValidAfterTrim:szJobTitleName]) return ;
    szJobTitleName = [CommonFunctions functionsClearStringTrim:szJobTitleName];
    NSArray *arr= [Instance.m_rootJobTitles mutableCopy];
    for(OrganizedJobTitle *entry in arr) {
        if([entry nameIs:szJobTitleName]){
            [Instance.m_rootJobTitles removeObject:entry];
            
            return;
        }
    }

}




-(NSString *)toString{
    if(Instance.m_hashDepartments == nil) return nil;
    
    NSString *jobS= [CommonFunctions functionsFromObjectToJsonString:[self toJsonObject]];
    return jobS;
}

-(NSDictionary *)toJsonObject{
    
    NSMutableDictionary  *object = [NSMutableDictionary dictionary];
    
    if(![self _isDepartmentEmpty]){
        NSMutableArray *array = [NSMutableArray array];
        [Instance.m_hashDepartments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSMutableDictionary *obj1 = [NSMutableDictionary dictionary];
            OrganedDepartmentID *ID = (OrganedDepartmentID *)key;
            [obj1 addEntriesFromDictionary:@{@"DEPARTID":[ID toString]}];
            
                OrganizedDepartment *dp = (OrganizedDepartment *)obj;
            [obj1 addEntriesFromDictionary:@{@"DEPARTMENT":[dp toString]}];
            [array addObject:obj1];
        }];
        
        [object addEntriesFromDictionary:@{@"ROOTDEPART":array}];
        
    }
    
    if(![self _isRootJobTitleEmpty]){
        NSMutableArray * array = [NSMutableArray array];
        for(OrganizedJobTitle *jobTitle in  Instance.m_rootJobTitles){
            [array addObject:[jobTitle toString]];
            
        }
        [object addEntriesFromDictionary:@{@"ROOTJOB":array}];
        
    }
    return object;
}
/**
 * 私有方法 ： 添加职位
 * @param department - 部门，为空添加在根目录
 * @param jbtobeadd  - 职位，为空抛出异常
 * @throws OrganizedException 职位对象-为空抛出异常
 */
-(void)_addJobTitle:(OrganizedDepartment *)department job:(OrganizedJobTitle *)jbtobeadd {
    if(department == nil){
        [self  _addRootJobTitle:jbtobeadd];
    }else{
        [department AddJobTitle:jbtobeadd];
    }
}
        
-(void)_addRootJobTitle:(OrganizedJobTitle *)jbtobeadd{
    if(jbtobeadd == nil){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"_addJobTitle: JobTitle is empty" userInfo:nil];
        [Ce raise];
        
    }else if([self _canAddJobTitles] && ![self _hasJobTitleName:jbtobeadd.m_myTitle]){
        [Instance.m_rootJobTitles addObject:jbtobeadd];
        
    }else{
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"addRootJobTitle:职位超出限制或者名字重复" userInfo:nil];
        [Ce raise];
        
    }
}
 
        
/**
 * 私有方法 ：是否可以添加职位，只检查了边界
 * <br>职位框架数组为空时，进行初始化
 * @return
 */
-(BOOL)_canAddJobTitles{
    if(Instance.m_rootJobTitles == nil){
        Instance.m_rootJobTitles = [NSMutableArray array];
        return true;
    }
    if(Instance.m_rootJobTitles.count >= MAXJOBTITLES){
        return false;
    }
    return true;
}
        
-(BOOL)_hasJobTitleName:(NSString *) szJobTitleName{
    if([self _isRootJobTitleEmpty] || ![CommonFunctions functionsIsStringValidAfterTrim:szJobTitleName]) return false;
    szJobTitleName = [CommonFunctions functionsClearStringTrim:szJobTitleName];
    for(OrganizedJobTitle *entry  in Instance.m_rootJobTitles) {
        if([entry nameIs:szJobTitleName]){
            return true;
        }
    }
    return false;	
}
        
        

/**
 * 为删除函数做准备，如果被删除的部门不在部门列表的尾巴，则需要把其后面的ID全部往前移动一位；
 *
 * @param idCurrent - 被删除的departmentid
 * @return 返回需要移动的DepartmentID对象ArrayList;
 */

-(NSMutableArray *)_getAffectedDeparmentID:(OrganedDepartmentID *) idCurrent{
    if([self _isDepartmentEmpty] || idCurrent == nil) return nil;
    NSMutableArray *idList =[NSMutableArray array];
    for(OrganedDepartmentID *idloop  in [Instance.m_hashDepartments allKeys]){
        
        if([idloop isRelatedDepartID:idCurrent]){
            [idList addObject:idloop];
        }
    }
    
    if (idList.count == 0) {
        return  nil;
    }
    return idList;
}

-(BOOL)_isAllEmpty{
    if([self _isDepartmentEmpty]&& [self _isRootJobTitleEmpty]) return true;
    return false;
}


-(BOOL)_isDepartmentEmpty{
    return (Instance.m_hashDepartments == nil || Instance.m_hashDepartments.count == 0 ) ? true:false;
}

-(BOOL)_isRootJobTitleEmpty{
    return (Instance.m_rootJobTitles == nil || Instance.m_rootJobTitles.count == 0) ? true:false;
}

        



/**
 * 私有方法 ：根据名字查找部门
 * @param deptname 部门名字不能为空，否则抛出异常。<br>会对参数做trim()动作之后再操作。
 * @return 部门对象 - 现存对象的reference,非副本；
 * @throws OrganizedException - 参数为空或者找不到指定部门，刨除异常；
 */
-(OrganizedDepartment *)_findDepartByName:(NSString *) deptname{
    if(![CommonFunctions functionsIsStringValidAfterTrim:deptname ]){
        NSString *reasonStr = @"Department: departname being searched is empty.";
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:reasonStr userInfo:nil];
        [Ce raise];
    
    }
    @try{
        deptname = [CommonFunctions functionsClearStringTrim:deptname];
  
        OrganedDepartmentID *departmentID = [self _findDepartIDByName:deptname];
        return Instance.m_hashDepartments[departmentID];
    } @catch (NSException *exception) {
        @throw exception;
    }
    
}



/**
 * 私有方法 ：根据部门名字查找部门内部结构ID
 * @param deptname 部门名字 (使用前做了trim操作）
 * @return 部门内部标记ID - 返回的是现存DepartmentID的reference本身，非副本；
 * @throws OrganizedException 部门名字不能为空或者不在当前对象中，否则抛出异常
 */
-(OrganedDepartmentID *)_findDepartIDByName:(NSString *)deptname{
    if(![CommonFunctions functionsIsStringValidAfterTrim:deptname]){
        NSString *reasonStr = @"Department: departname being searched is empty.";
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:reasonStr userInfo:nil];
        [Ce raise];
        
    }
    deptname = [CommonFunctions functionsClearStringTrim:deptname];
    
    
    NSArray *keys  = [Instance.m_hashDepartments allKeys];
    
    for (OrganedDepartmentID *ID in keys) {
        OrganizedDepartment *depart = (OrganizedDepartment *)Instance.m_hashDepartments[ID];
        if ([depart nameIs:deptname]) {
            
            return ID;
        }
    }
    
    CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"Department:Cannot Find Department " userInfo:nil];
    [Ce raise];
    return nil;
}


/**
 * 私有方法：添加部门 - 支持添加根级部门
 * @param parentDepart - 父部门对象，为空时，添加根部门
 * @param szDepartmentName - 需要添加的部门名字 (执行trim)
 * @throws OrganizedException <p>- 添加空名字或者已经存在的名字，抛出异常。<br>
 * -边界检测失败（超出限制）抛出异常</p>
 */
-(void)_addDepartment:(OrganizedDepartment *) parentDepart newDepartName:(NSString *)szDepartmentName{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szDepartmentName ])
    {
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"添加部门名字为空 " userInfo:nil];
        [Ce raise];
    }else if([self _hasDepartmentName:szDepartmentName])
    {
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"_addDepartment:Department Name duplicated " userInfo:nil];
        [Ce raise];
        
    }
    
    szDepartmentName = [CommonFunctions functionsClearStringTrim:szDepartmentName];
    OrganedDepartmentID *newid =[self _generateDepartmentIDforNewChild:parentDepart];
    OrganizedDepartment *newdepart = [[OrganizedDepartment alloc]initWithDepartName:szDepartmentName array:nil];
    [Instance.m_hashDepartments addEntriesFromDictionary:@{newid:newdepart}];
    
}



/**
 * 判断是否存在部门名字
 * @param szDepartmentName - 使用查找前使用了trim;
 * @return	true - 部门名字已经存在； false - 不存在
 * @throws OrganizedException	参数有误；
 */
-(BOOL)_hasDepartmentName:(NSString *)szDepartmentName{
    if(![CommonFunctions  functionsIsStringValidAfterTrim:szDepartmentName]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"添加部门名字为空 " userInfo:nil];
        [Ce raise];
        
    }
    if([self _isDepartmentEmpty]) return false;
    szDepartmentName = [CommonFunctions functionsClearStringTrim:szDepartmentName];
    
    NSArray *keys  = [Instance.m_hashDepartments allKeys];
    
    for (OrganedDepartmentID *ID in keys) {
        OrganizedDepartment *depart = (OrganizedDepartment *)Instance.m_hashDepartments[ID];
        if ([depart nameIs:szDepartmentName]) {
            
            return true;
        }
    }
    
    return false;
}


/**
 * 为即将增加的元素生成新的DepartmentID; - 支持根级部门
 * @param parentDepart - 子部门添加在此部门之下，为空时，添加的部门为根部门；
 * @return 新的部门ID
 * @throws OrganizedException - 找不到指定部门时抛出异常；边界检测失败（超出限制）抛出异常
 */
-(OrganedDepartmentID *) _generateDepartmentIDforNewChild:(OrganizedDepartment *) parentDepart
{
    if(parentDepart == nil){ //-根级ID
        int iNewLevel = [self getThemeChildDepartmentCount] + 1;
        return   [[OrganedDepartmentID alloc]initWithNewDepartIDNewLevel:iNewLevel];
        }
    
    OrganedDepartmentID *idparent = [self _getDepartmentID:parentDepart];
    
    int iCurrentChildrenCount = [self _getChildDepartmentCount:idparent];
    OrganedDepartmentID *newID = [[OrganedDepartmentID alloc]initWithCopyDepartmentID:idparent];
    [newID AddLevel:iCurrentChildrenCount+1];
    return newID;
}

-(int)_getChildDepartmentCount:(OrganedDepartmentID*)ID{
    NSArray  *ids = [self _getChildrenDepartmentID:ID brec:false];
    return (ids == nil) ? 0 : (int)ids.count;
    
}


/**获取Department对应的DepartmentID - 引用
 *
 * @param Department departmt - 为空或者找不到该部门时，抛出异常
 * @return the reference of DepartmentID
 * @throws OrganizedException
 */

-(OrganedDepartmentID *)_getDepartmentID:(OrganizedDepartment *)departmt{
    
    for(OrganizedDepartment *dptrue in  [Instance.m_hashDepartments allValues]){
        
        if([dptrue equals:departmt]){
            
            OrganedDepartmentID *idpart = [[Instance.m_hashDepartments allKeysForObject:dptrue] lastObject];
            return idpart;
        }
    }
    return nil;
}
    

/**
 * 获取根级部门的数量，根级部门指公司直属部门；
 * @return 部门数量
 *
 */
-(int)getThemeChildDepartmentCount{
    return [self  _getChildDepartmentCount:nil];
}


/**
 * 获取指定部门的直接子集部门数量
 * @param szParent - 父级名称
 * @return 部门数量；如果没有子部门或者指定部门不存在，返回0
 * @throws OrganizedException - 部门名字不能为""或者纯空白或者不在当前对象中，否则抛出异常
 */

-(int)getChildDepartmentCount:(NSString *) szParent{
    NSArray  *arrChildren = [self getChildDepartmentList:szParent];
    return arrChildren == nil ? 0 : (int)arrChildren.count;
}


/**
 * 获取公司直属的部门名称列表（非递归模式）
 * @return 部门名字数组
 * <p>参考： {@link #getChildDepartmentList(String)}</p>
 */
-(NSArray *)getThemeChildDepartmentList{
    if([self _isDepartmentEmpty]) return nil;
    @try {
        return [self getChildDepartmentList:nil];
    } @catch (NSException *exception) {
        NSLog(@"理论应无异常,未知错误");
    }
    
    return nil;
}

-(NSArray *) _departIDListToDepartNameArray:(NSArray *)lstDptID{
    if(lstDptID == nil) return nil;
    
//    Collections.sort(lstDptID);
    //lstDptID.sort(_sortComparator());
    //	lstDptID.sort(DepartmentID.compa);
    NSMutableArray *departlist = [NSMutableArray array];
    for(OrganedDepartmentID *idfind in lstDptID){
    
        [departlist addObject:[self _getDepartNameByID:idfind]];
    }
    return departlist;
}

-(NSString *)_getDepartNameByID:(OrganedDepartmentID *) ID{
    if(ID == nil ||[self  _isDepartmentEmpty]){
        return nil;
    }
    if(![[Instance.m_hashDepartments allKeys] containsObject:ID]){ //可能因为是DeparmentID的副本 （通过getparentid得来的）

        for(OrganedDepartmentID *idtrue in  [Instance.m_hashDepartments allKeys]){
            if([idtrue equals:ID]){
                OrganizedDepartment *depart = (OrganizedDepartment *)Instance.m_hashDepartments[idtrue];
                return depart.m_szDepartmentName;
            }
        }
    }else{
          OrganizedDepartment *depart = (OrganizedDepartment *)Instance.m_hashDepartments[ID];
        return depart.m_szDepartmentName;
    }
    return nil;
}

/**
 * 获取指定部门的子部门名字列表
 * @param szParentDepartment - 要查询的父部门；<br> 为null的时候，返回公司直属部门列表；
 * <br>非null时，查找前trim();
 * @param bRecuresively - 是否递归查询所有子集的子集；
 * @return 子部门数组（如果没有子部门，返回空）
 * @throws OrganizedException - 部门名字不能为""或者纯空白或者不在当前对象中，否则抛出异常
 */
-(NSArray *)getChildDepartmentList:(NSString *) szParentDepartment bRec:(BOOL)bRecuresively{
    
    OrganedDepartmentID *idDepartmentID = nil;
    if(szParentDepartment != nil){
        szParentDepartment = [CommonFunctions functionsClearStringTrim:szParentDepartment];
        idDepartmentID =[self  _findDepartIDByName:szParentDepartment];
    }
    
    
    NSMutableArray  *ids =(NSMutableArray *)[self _getChildrenDepartmentID:idDepartmentID brec:bRecuresively];
    return [self _departIDListToDepartNameArray:ids];
}

/**
 * 获取指定部门的直接子部门名字列表 （非递归模式）- 支持查询根部门
 * @param szParentDepartment - 要查询的父部门, 为null的时候，返回公司直属部门列表；
 * @return 子部门名字数组
 * @throws OrganizedException  - - 部门名字不能为""或者纯空白或者不在当前对象中，否则抛出异常
 * <p>参考： {@link #getChildDepartmentList(String,boolean)}</p>
 */
-(NSArray *)getChildDepartmentList:(NSString *) szParentDepartment{
    return  [self getChildDepartmentList:szParentDepartment bRec:false];

}


            
            
/**
 * 私有方法 ：取指定部门ID的子部门ID列表（拷贝项）。
 * @param idparent - 父ID，可以为空，空时返回根级部门列表
 * @param bRecursively - 是否递归查询子集的所有子集；
 * @return ArrayList<DepartmentID> - 无子部门时，返回null
 * <p>不抛异常，吞掉了对象有parent，却无法获取parent的DepartmentID 的异常</p>
 */

-(NSArray *)_getChildrenDepartmentID:(OrganedDepartmentID *)idparent brec:(BOOL)bRecursively{
    if([self _isDepartmentEmpty]) return nil;
   if(idparent == nil){ //空时返回根级部门列表
       if(bRecursively)
       return [NSArray arrayWithArray:[Instance.m_hashDepartments allKeys]];
       else{
           NSMutableArray *arrOutput = [NSMutableArray array];
           for(OrganedDepartmentID *idtocheck in [Instance.m_hashDepartments allKeys]){
               if([idtocheck getLevelCount] == 1){
                   [arrOutput addObject:idtocheck];
               }
           }
           return arrOutput;
       }
   }else{
       NSMutableArray  *arrOutput = [NSMutableArray array];
       
       
       
       for(OrganedDepartmentID *idtocheck in Instance.m_hashDepartments){
          
           if([idtocheck getLevelCount]<= [idparent getLevelCount]) continue; //待处理的是上级或者同级
           BOOL bConditionCheckResult = NO;
           BOOL ischilde = [idtocheck isChildOf:idparent];
           OrganedDepartmentID *restoreID = idtocheck;
           NSString *childStr = [restoreID toString];
           
           NSString *parentStr = [idparent toString];
           NSString *str1 =[childStr substringWithRange:NSMakeRange(0, parentStr.length )];
           
        
           @try{
               bConditionCheckResult = (bRecursively == NO) ?
           ischilde:[str1  isEqualToString:parentStr];
           
           }@catch (NSException *exception){
           
               CodeException *Ce =[[CodeException alloc]initWithName:@"" reason:@"getChildrenDepartmentID->isChildOf:对象有parent，却无法获取parent的DepartmentID " userInfo:nil];
               [Ce raise];
           
           }
           
        //只要是逻辑上上级（隔层OK）
           if(bConditionCheckResult){
               [arrOutput addObject:idtocheck];
           }
       }
       
       if( arrOutput.count == 0 ) return nil;
       return arrOutput;
   }
    
    
}


-(NSMutableArray *)getJobtitle{
    return _m_rootJobTitles;

}



@end
