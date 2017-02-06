//
//  BaseArgumentList.m
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"

@implementation BaseArgumentList

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_mapArguments forKey:@"m_mapArguments"];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.m_mapArguments = [aDecoder decodeObjectForKey:@"m_mapArguments"];
    }
    return self;
}
-(NSMutableDictionary *)m_mapArguments{
    
    if (_m_mapArguments == nil) {
        _m_mapArguments = [NSMutableDictionary dictionary];
    }
    return _m_mapArguments;
}

/**
 * 只检查Key是否为空。不检查Value
 *  object - 目标JSONObject,数据源；
 *  keysets - 需要读入的KEYSET，如果为null,导入所有；
 * @throws OrganizedException 参数错误，抛出异常，比如object为null;
 */

-(instancetype)initWithDictionary:(NSDictionary *)dic keysets:(NSArray *)keysets{
    if (self = [super init] ) {
        [self importValueFromJsonObject:dic keysets:keysets];
    }
    
    return self;
}


-(instancetype)initWithJson:(NSString *)json{

    if (self = [super init]) {
        NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:json];
        [self importValueFromJsonObject:dic keysets:[dic allKeys]];
    }
    return self;
}

/**
 * 导入KeySets定义的所有JSONObject的key对应的值；
 * @param object - 需要导入键值对的JSONObject数据源
 * @param keysets - 需要读入的KEYSET，如果为null,导入所有
 * @throws OrganizedException object为null抛出异常；
 */
-(void)importValueFromJsonObject:(NSDictionary *)object keysets:(NSArray *) keysets{
    if(object == nil){
        CodeException *Ce =[[CodeException alloc]initWithName:@"BASEARGUMENTLIST_WRONGARGUMENT" reason:@"BaseArgumentList字典错误" userInfo:nil];
        [Ce raise];
    }
    if(keysets != nil){ //自定义指定要导入的KEYS；可以是多个keySet;
        for(NSString *szKey in keysets){
            if ([[object allKeys] containsObject:szKey]) {
                //1.将value转成json字符串
                NSString *objectStr =  [CommonFunctions functionsFromObjectToJsonString:object[szKey]];
                //2.添加json和key
                [self.m_mapArguments addEntriesFromDictionary:@{szKey:objectStr}];
            }else{
#warning -字典里面不能添加nil 或者null
                [self.m_mapArguments addEntriesFromDictionary:@{szKey:@""}];
                
            }
        }
    }else{
        NSArray *keys = [object allKeys];
        
        if(keys != nil){
            for(NSString *szKey in keys){
                NSString *objectStr =  [CommonFunctions functionsFromObjectToJsonString:object[szKey]];
                [self.m_mapArguments addEntriesFromDictionary:@{szKey:objectStr}];
                //
            }
        }
    }
}


/**
 * BaseArgumentList转换为jsonobject
 * @return JSONObject 不为null,如果没有额外参数，则返回一个length == 0的JSONObject;
 */
-(NSDictionary *)toJsonObject{
    NSMutableDictionary  *object = [NSMutableDictionary dictionary];
    if(self.m_mapArguments != nil && self.m_mapArguments.count > 0){
        
        [self.m_mapArguments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [object addEntriesFromDictionary:@{key:obj}];
        }];
        
    }
    return object; //此处不返回null,如果没有参数，则返回空的JSONObject对象；
}


/**
 *  按指定的属性列表进行输出JSON；
 * <br>不包含空的KEY,但是包含null的value;
 *
 * @param arrkeys - 仅导入指定的key数组对应的键值对；
 * @return JSONObject, 不会返回null值； 结果中的键值不会超过参数定义的范围；
 */
-(NSDictionary *)toJsonWithArr:(NSArray *)arrkeys{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    if(arrkeys == nil || arrkeys.count == 0) return object;
    for(NSString *szKey in arrkeys){
        if([CommonFunctions functionsIsStringValidAfterTrim:szKey]){
            [object addEntriesFromDictionary:@{szKey:self.m_mapArguments[szKey]}];
        }
    }
    return object; //此处不返回null,如果没有参数，则返回空的JSONObject对象；
}

/**
 * 获取遍历的参数的KEY的合集
 * null - 如果没有参数的话； 有参数，则返回参数hashmap的keyset;
 */
-(NSArray *) __getArgumentKeySet{
    if(![self __hasArgument]) return nil;
    return [self.m_mapArguments allKeys];
}

/**
 * 根据KEY返回参数的value;
 *  szKey - 需查找的key
 * @return 如果没有参数或者没有对应的key，则返回null;否则返回相应的值；
 */
-(NSString *) 	__getArgumentValue:(NSString *) szKey{
    if(![self __hasArgument]) return nil;
    return self.m_mapArguments[szKey];
}
/**
 * 根据key移掉参数对；
 * <br>找不到KEY的情况下，什么也不做；
 *  szKey 用户指定的key;
 */
-(void)__removeArgumentPair:(NSString *)szKey{
    if([self __hasArgument] && [[self.m_mapArguments allKeys] containsObject:szKey]){
        [self.m_mapArguments removeObjectForKey:szKey];
        
    }
}



/**
 * 增加参数对 - 键值对
 * <br>如果增加的键已经存在，则覆盖原先的；否则创建新的参数对；
 * <br>不可添加键不通过isStringValidAfterTrim的参数, 值也不可为null,但可为""或者空白字符串；
 *  szKey - 键
 *  szValue - 值
 * @throws OrganizedException 键值不可以为null,否则跳出异常；
 */
-(void)__addArgumentPairKey:(NSString *)szKey value:(NSString *) szValue{
    
    if(![CommonFunctions functionsIsStringValidAfterTrim:szKey]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"BASEARGUMENTLIST_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
    }
    [self.m_mapArguments setObject:szValue forKey:szKey];
}


//

/**
 * 添加参数 - 类型为用户自定义类对象；
 * @param object  对象本身；添加对象时，对象本身不可为null;
 * @throws OrganizedException 对象为null抛出异常；或者对象的isvalid判断返回false, toString 为null, 抛出异常；
 */

-(void)__addArgumentObject:(BaseArgumentList *)object{
    if(object == nil){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"" userInfo:nil];
        [Ce raise];

    }
    
    [self __addArgumentObject:[object class] szObject:[object toString]];

}


-(void)__addArgumentObject:(id)classKey szObject:(NSString  *)szObject{
    if(classKey == nil || szObject == nil) {
        CodeException *Ce =[[CodeException alloc]initWithName:@"参数为空" reason:@"" userInfo:nil];
        [Ce raise];
    }
    NSString *className =  [NSStringFromClass([classKey class]) uppercaseString];
    [self __addArgumentPairKey:className value:szObject];
}



/**
 * 根据ClassKey返回参数的value;
 * @param classKey - 需查找的key，为一个Class的类；
 * @return 如果没有参数或者没有对应的key，则返回null;否则返回相应的值；
 */
-(id) __getArgumentObject:(id) classKey{
    if(classKey == nil) return nil;
    
     NSString *className =  [NSStringFromClass([classKey class]) uppercaseString];
    NSString *szObjJsonString  = [self __getArgumentValue:className];
#warning -反射构造对象
    @try {
        //反射组成OBJ；
        if ([classKey isKindOfClass:[BaseArgumentList class]]) {
            BaseArgumentList *baseA =  [[BaseArgumentList alloc]initWithJson:szObjJsonString];
            return baseA;
            
            
        }
        
    } @catch (NSException *exception) {
        return  nil;
    }
    
}
-(OrganizedMember *)getOrganizedMember:(NSString *)member{
    
    NSString *szObjJsonString  = [self __getArgumentValue:member];
    
    @try {
        //反射组成OBJ；
        OrganizedMember *baseA =  [[OrganizedMember alloc]initWith:szObjJsonString];
        return baseA;
        
    } @catch (NSException *exception) {
        return  nil;
    }

}

//
/**
 * 添加参数 - 类型为Interface DBColumns；
 * <br>  此处做了参数值的校验；
 * @param statid Interface DBColumns名
 * @param szValue  interface对应的值;
 * @throws OrganizedException 属性为定义或者 值非有效的属性对应的值，抛出异常；
 */

-(void)__addArgumentPair:(NSString *)statid szValue:(NSString *)szValue{
    if(statid == nil ){
    CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_SET_ERROR" reason:@"" userInfo:nil];
    [Ce raise];
    
}
    [self __addArgumentPairKey:statid  value:szValue];
    
}



/**
 * 根据DBColumns属性值，返回对应的值
 * @param statid - 属性值。
 * @return 属性对应的string值
 */
//-(NSString *)__getArgumentValueObject:(id<DBColumns> )statid{
//    
//    return  [self __getArgumentValue:[statid getDBColumnName]];
//    
//}

/**
 * 设置DBColumn对应的键值对；
 *  mpValues
 * @throws OrganizedException
 */

-(void)__setDBColumsStatValue:(NSDictionary *)mpValues{
    if(mpValues == nil || mpValues.count == 0){
//        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"" userInfo:nil];
//        [Ce raise];
        return;
    }
    for(NSString *stat in [mpValues allKeys]){
        [self __addArgumentPair:stat szValue:mpValues[stat]];
    }
}








/**
 * 测试用函数，用来在格式化打印出对象的内容
 * @param bShowNull - 是否显示值为NULL的对象；
 * @return	格式化对象字串
 */
//
//- (NSString *)testObjectString:(BOOL)bShowNull {
//    [CommonFunctions ]
//    return CommonFunctions.formatTestStringHashMap(m_mapArguments, bShowNull)
//}

/**
 * 判断对象是否有效；
 * <br>判断逻辑：
 * <ul>
 * <li>1. 在有参数的情况下，所有key都不可以为null, 否则返回false;</li>
 * </ul>
 */

-(BOOL)isValid{
    if(self.m_mapArguments != nil && self.m_mapArguments.count > 0){
        if([[self.m_mapArguments allKeys] isEqual: @""]) return false;
        //			if(m_mapArguments.containsKey(null) || m_mapArguments.containsValue(null)) return false;
    }
    return true;
}

/**
 * 判断是否有参数；
 * @return 列表中有参数-true; 无参数-false;
 */
-(BOOL) __hasArgument{
    if(self.m_mapArguments == nil || self.m_mapArguments.count == 0) return false;
    return true;
}


/**
 * 静态方法： 方便快捷的把一系列属性键值对，转化为json对象
 * <br>其中检测了是否包含有空的键值，以及属性是否匹配其值；
 * @param mpValues 需转换的属性值；
 * @return  转换成功的jsonobject；
 * @throws OrganizedException 转换失败或者参数不正确，值不符合参数属性等；
 */
+(NSDictionary *)convertHashMapToJSONObject:(NSDictionary *) mpValues{
    BaseArgumentList *list = [[BaseArgumentList alloc]init];
    [list __setDBColumsStatValue:mpValues];
    
    return [list toJsonObject];
}


/**
 * 静态方法： 方便快捷的把一系列属性键值对，转化为json对象
 * <br>其中检测了是否包含有空的键值，以及属性是否匹配其值；
 
 * @return  转换成功的jsonobject；
 * @throws OrganizedException 转换失败或者参数不正确，值不符合参数属性等；
 */
+(NSDictionary *)convertJSONObjectToHashMap:(NSDictionary *)object{
    BaseArgumentList *list =[[BaseArgumentList alloc]initWithDictionary:object keysets:nil];
    
    return list.m_mapArguments;
}

@end
