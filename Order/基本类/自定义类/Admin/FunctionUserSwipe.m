//
//  FunctionUserSwipe.m
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "FunctionUserSwipe.h"

@implementation FunctionUserSwipe



/**
 * 创建一个具有单个默认的打卡节点的对象
 * <br>此时对象非完整，必须指定打卡节点和节点名称（地图定位打卡，WIFI打卡）
 * @throws OrganizedException 节点hashmap为null或者空，则跳出异常；
 */
-(instancetype)initFunctionUserSwipe{
    if (self = [super init]) {
        SingleSwipe *swipeOnDuty =  [[SingleSwipe alloc]initSingleSwipeWithDescription:@"上班" songleSules:nil];
        
        [swipeOnDuty  setBeforeRule:@"9:00"];
    
        SingleSwipe *swipeOffDuty =  [[SingleSwipe alloc]initSingleSwipeWithDescription:@"下班" songleSules:nil];
        
         [swipeOffDuty  setBeforeRule:@"18:00"];
        
        _m_arrSwipePairConfig = [NSMutableArray array];
        PairSwipe *pairSwipe =  [[PairSwipe alloc]initPairSwipeWithFirstS:swipeOnDuty sencodS:swipeOffDuty];
        [_m_arrSwipePairConfig addObject:pairSwipe];
    }
    return self;
    
    
}


/**
 * 创建一个设置了打卡节点，具有一个默认的打卡节点的对象
 * @param nodeInformation - 打卡节点和节点名字的hashmap
 * @throws OrganizedException 节点hashmap为null或者空，则跳出异常；
 */

-(instancetype)initFunctionUserSwipeWithDic:(NSDictionary<NSString *,NSArray<NSString *>*> *)nodeInformation{
   self = [self initFunctionUserSwipe];
    _m_mapSwipeNodeNames = (NSMutableDictionary *)nodeInformation;

    
    for(NSString *node in [_m_mapSwipeNodeNames allKeys]){
        NSMutableArray<NSString *> *nodes = [NSMutableArray array];
        nodes = (NSMutableArray *)_m_mapSwipeNodeNames[node];
        
        if(nodes != nil && nodes.count > 0){
            for(int i=0; i!=nodes.count; ++i){
                NSString *nodeStr = [nodes[i] uppercaseString];
                [nodes replaceObjectAtIndex:i withObject:nodeStr];
            
            }
        }
    }
    return self;
}




/**
 * 从json格式的字符串恢复成一个打卡功能的配置信息对象；
 * @param szJsonString		- 符合对象格式的JSON字符串；
 * @throws JSONException	- 参数不合法，无法解析成有效的JSON对象
 * @throws OrganizedException	- 参数可以解析为JSON对象，但不符合本类的格式；
 */

-(instancetype)initFunctionUserSwipeWithJsonString:(NSString *)szJsonString{

    NSDictionary *dic =[CommonFunctions functionsFromJsonStringToObject:szJsonString];
    return [self initFunctionUserSwipeWithDic:dic];
}

-(instancetype)initFunctionUserSwipeWithJsonDic:(NSDictionary *)object{
    if(object == nil || object.count == 0){
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_NOTVALIDJSONSTRING" reason:@"nil" userInfo:nil];
        [Ce raise];
       
    }
    if (self = [super init]) {
            NSArray<NSString *> *keySet = [object allKeys];
            if(keySet != nil){
                for(NSString *szKey in keySet){
                    if ([szKey isEqualToString:@"SWPNODES"]) {
                        NSMutableDictionary *objectItem = object[szKey];
                        _m_mapSwipeNodeNames = [NSMutableDictionary dictionary];
                        NSArray<NSString *> * nodetypes = [objectItem allKeys];
                        for(NSString *nodeType in nodetypes){
                            
                            NSString *szNodeName = objectItem[nodeType];
                            NSArray<NSString *> *liAddressNames = [CommonFunctions functionsStringToAddressArray:szNodeName];
                            [_m_mapSwipeNodeNames addEntriesFromDictionary:@{nodeType:liAddressNames}];

                          
                        }
                    }else if ([szKey isEqualToString:@"SSWP"]){
                        NSArray *arrayItem = object[szKey];
                        if(arrayItem != nil){
                            _m_arrSingleSwipeConfig = [NSMutableArray array];
                        for(id obj in arrayItem){
//                            String szObjJsonString = obj.toString();
//                            SingleSwipe swipedata = new SingleSwipe(szObjJsonString);
//                            m_arrSingleSwipeConfig.add(swipedata);
                        }
                        }
                    }else if ([szKey isEqualToString:@"PSWP"]){
                        NSDictionary *arrayItem = object[szKey];
                        _m_arrSwipePairConfig = [NSMutableArray array];
//                        for(Object obj:arrayItem){
//                            String szObjJsonString = obj.toString();
//                            PairSwipe swipedata = new PairSwipe(szObjJsonString);
//                            m_arrSwipePairConfig.add(swipedata);
//                        }
                    
                    
                    }
                    
    }
            }
  
}
    
      return self;
}




/**
 * 返回支持的打卡节点类型的数组
 * @return - 支持的打卡节点类型的数组，若当前不支持任何打卡类型则返回null;
 */
-(NSArray *)getSwipeNodeTypeArray{
    if(_m_mapSwipeNodeNames == nil || _m_mapSwipeNodeNames.count == 0) return nil;
    return [_m_mapSwipeNodeNames allKeys];
}



/**
 * 判断参数中指定的打卡节点类型是否被支持
 * @param type - 指定打卡节点类型
 * @return  true - 支持； false - 不支持
 */
-(BOOL)isSwipeNodeTypeSupported:(SWIPENODETYPE )type{
    NSString *typeStr = [FunctionUserSwipePublic SwipenodeTypeString:type];
    if(_m_mapSwipeNodeNames == nil || _m_mapSwipeNodeNames.count == 0|| ![[_m_mapSwipeNodeNames allKeys] containsObject:typeStr] ||
       _m_mapSwipeNodeNames[typeStr] == nil ) return false;
    return true;
}


/**
 * 查询是否指定的打卡节点和名称被支持
 *
 * @param type - 指定打卡节点类型
 * @param szName - 打卡节点的名字；
 * @return  true - 有效的打卡方式；false - 无效的打卡方式；
 */
-(BOOL)isSwipeNodeTypeAndNameSupported:(SWIPENODETYPE)type Name:(NSString *)szName {
    //<br> 多个地图地址和多个WIFI节点的情况下，需要使用；
    if(szName == nil) return false;
    szName = [szName uppercaseString]; //存储的均为大写；
    if([self isSwipeNodeTypeSupported:type] && [[_m_mapSwipeNodeNames allKeys]containsObject:szName]) return true;
    return false;
}


/**
 * 根据执行的打卡类型返回其对应的节点名称。
 * <br> 如-百度地图打卡时，返回地址；WIFI打卡时-返回网关的MAC地址；
 * @param type - 指定的打卡类型；
 * @return 对应的节点名称
 */
-(NSArray<NSString *> *)getSwipeNodeName:(SWIPENODETYPE) type{
    NSString *typeStr = [FunctionUserSwipePublic SwipenodeTypeString:type];
    if(_m_mapSwipeNodeNames == nil || _m_mapSwipeNodeNames.count ==0 || ![[_m_mapSwipeNodeNames allKeys] containsObject:typeStr]) return nil;
    NSArray<NSString *> *liNodeNames =  _m_mapSwipeNodeNames[typeStr];
    if(liNodeNames == nil || liNodeNames.count == 0) return nil;
    return liNodeNames;
}


/**
 * 用户打卡 - 成对打卡配置上打卡
 * @param userBean - 打卡的当前用户的userbean对象；
 * <br><b style="color:red">注：里面的必须放置已登录用户的帐号，非邮件，也非手机号；</b>
 * @param type - 打卡节点的类型；{@linkplain SWIPENODETYPE};
 * @param szSwipeNodeName - 新增参数（适应多个打卡地址，WIFI节点的情形） 打卡节点类型对应的节点名；wifi的情况下，为wifi节点名字， 定位的情况下，为使用的定位地址；
 * @param szSwipeMemberName - 成对打卡对应此次打卡的名字；如，用户打卡操作在“上班_下班”(成对打卡的虚拟名)上，此时打的是下班卡，则此处应为“下班";
 * @return UserSwipe,用户打卡数据对象；
 * @throws OrganizedException 参数包含无效参数抛出异常；
 */
-(UserSwipe *)onUserPairSwipe:(UserBean *)userBean type:(SWIPENODETYPE )type swip:(NSString *)szSwipeNodeName szSwipeMemberName:(NSString *)szSwipeMemberName{
    
    
    return [self _onUserSwipe:userBean type:type name:szSwipeNodeName swipName:szSwipeMemberName bSwip:YES];
    
}
-(UserSwipe *)onUserSingleSwipe:(UserBean *)userBean type:(SWIPENODETYPE )type swip:(NSString *)szSwipeNodeName szSwipeMemberName:(NSString *)szSwipeMemberName{
     return [self _onUserSwipe:userBean type:type name:szSwipeNodeName swipName:szSwipeMemberName bSwip:false];
}


/**
 * 刷卡类型名字是否有效
 * <br>规则同用户名，公司名等，但长度小于或等于16个字节；
 * @param szName - 刷卡的名字，如“上班”,"午饭“，"晚饭"等；
 * @return
 */
+(BOOL)_isValidSwipeName:(NSArray<NSString *> *)arrName{
    if(arrName == nil) return false;
    for(int i= 0; i!= arrName.count; ++i){
        NSString *szName = arrName[i];
        if(  szName.length <= MAXSWIPENAMELENGTH){
            continue;
        }
        return false;
    }
    return true;
}

+(BOOL)isValidVirtualNameFormat:(NSString  *)nametotest{
    if(![CommonFunctions functionsIsStringValid:nametotest]) return false;
    NSArray<NSString *> * names = [nametotest componentsSeparatedByString:@":"];
   
    if(names!=nil && names.count == 2 && [self _isValidSwipeName:names]){
        return true;
    }
    return false;
}

-(UserSwipe *)_onUserSwipe:(UserBean *)userBean type:(SWIPENODETYPE)type name:(NSString *)szSwipNodeName swipName:(NSString *)szSwipeName bSwip:(BOOL)bSwipePair{
    if(!type  ||  ![self isSwipeNodeTypeAndNameSupported:type Name:szSwipNodeName]|| ![FunctionUserSwipe _isValidSwipeName:@[szSwipeName]]){
        return nil;
    }
    szSwipNodeName = [szSwipNodeName uppercaseString]; //打卡节点名称大写；
    
    SingleSwipe *swipe = bSwipePair ?[self  _findSingleSwipeInPairSwipe:szSwipeName]:[self getSingleSwipeByName:szSwipeName];
    if(swipe != nil && [swipe isValid]){
        return [swipe _onUserSwipe:userBean type:type swipName:szSwipNodeName ];
    }
    return nil;
}

/**
 * 校验SwipeNode对应的名字是否合法；
 * @param type
 * @param szNodeName
 * @return
 */

-(BOOL)_validateSwipeNodeName:(SWIPENODETYPE)type Name:(NSArray *)arrNodeName{
    NSString *nameStr = [FunctionUserSwipePublic SwipenodeTypeString:type];
    if(nameStr == nil) return false;
    for(NSString *szNodeName in arrNodeName){
        switch (type) {
            case WIFIGATEWAY:
//                if(!CommonFunctions.isMacAddress(szNodeName)){
//                    return false;
//                }
//                break;
//            case BAIDUMAP:
//                if(!CommonFunctions.isAddress(szNodeName)){
//                    return false;
//                }
//                break;
//            case MANUAL: //特殊，个人打卡类型仅供管理员修改数据时使用，必须是管理员名字；
//                if(!CommonFunctions.isValidUserName(szNodeName)){
//                    return false;
//                }
                break;
            default:
                break;
        }
    }
    return true;
}

/**
 * 添加打卡判断节点对
 * <br>-没有该类型的节点时，创建新的节点，有节点的情况下，抛出异常；
 * @param type  - 打卡类型，如地图定位打卡（BAIDUMAP），或wifi打卡；
 * @param arrSwipeNodeNames	- 打卡类型对应的单个或多个节点，百度地图情况下，为地址；wifi - 则为wifi的接入点的mac;
 * @throws OrganizedException - 参数错误，或者冲突，则抛出异常；
 */

-(void)addSwipeNode:(SWIPENODETYPE)type NodeNames:(NSArray<NSString *> *)arrSwipeNodeNames{
    if(!type  || arrSwipeNodeNames == nil){
        return ;
    }
    if(_m_mapSwipeNodeNames == nil){
        _m_mapSwipeNodeNames = [NSMutableDictionary dictionary];
    }
    NSString *swipenodStr =  [FunctionUserSwipePublic SwipenodeTypeString:type];
    NSMutableArray<NSString *> *liNodeNames = (NSMutableArray *)_m_mapSwipeNodeNames[swipenodStr];
    if(liNodeNames == nil){
        liNodeNames = [NSMutableArray array];
        [_m_mapSwipeNodeNames addEntriesFromDictionary:@{swipenodStr:liNodeNames}];

    }
    //遍历需要添加的节点名并除重复；
    for(NSString *szNodeName in arrSwipeNodeNames){
        //全转大写：
       NSString *str = [szNodeName uppercaseString];
        //节点名有效
        if([self _validateSwipeNodeName:type Name:@[str]]){
            if([liNodeNames containsObject:str]) continue; //已经存在了，不重复添加；
            [liNodeNames addObject:str];

        }			
    }
}


/**
 * 删除指定的打卡方式中的打卡节点；
 * <br>如；地图打卡方式中，预先定义了多个地址，则可以在此处进行删除其中一个或多个；
 * <br>若把支持的地址都删除了，则不再支持该打卡方式，即地图打卡方式中的地址全部清除了，则该打卡方式不再支持；
 * @param type 节点类型
 * @param szSwipeNodeName 需要删除的节点名称；
 */
-(void)removeSwipNodeName:(SWIPENODETYPE)type Name:(NSString *)szSwipeNodeName{
    //名字存在才删除；
    NSString *swipeStr = [FunctionUserSwipePublic SwipenodeTypeString:type];
    if([self  isSwipeNodeTypeAndNameSupported:type Name:szSwipeNodeName]){
        szSwipeNodeName = [szSwipeNodeName uppercaseString];
        NSMutableArray<NSString *> *liNames = (NSMutableArray *)_m_mapSwipeNodeNames[swipeStr];
        [liNames removeObject:szSwipeNodeName];
        
        if(liNames.count != 0){ //删除后如果名字都为空了，则不再支持此种打卡方式；
            [_m_mapSwipeNodeNames removeObjectForKey:swipeStr];
            
            if(_m_mapSwipeNodeNames.count != 0){ //如果所有打卡方式都移除了。则清空对象；
                _m_mapSwipeNodeNames = nil;
            }
        }
    }
}



/**
 * 删除指定的打卡判断节点
 * @param type - 打卡类型
 * @throws OrganizedException - 指定的参数为null或者其不存在于当前的配置中，抛出异常；
 */
-(void)removeSwipeNode:(SWIPENODETYPE )type{
    NSString *swipStr = [FunctionUserSwipePublic SwipenodeTypeString:type];

    if(swipStr == nil){
        return;
    }else if(_m_mapSwipeNodeNames == nil || ![[_m_mapSwipeNodeNames allKeys] containsObject:swipStr]){
        return ;
    }
    [_m_mapSwipeNodeNames removeObjectForKey:swipStr];
    
    if(_m_mapSwipeNodeNames.count == 0){
        _m_mapSwipeNodeNames = nil;
    }
}


//-(PairSwipe *)getPairSwipeByVirtualName:(NSString  *)szVirtualName{
//    if(!CommonFunctions.isStringValid(szVirtualName)){
//        throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_WRONGARGUMENT);
//    }
//    if(m_arrSwipePairConfig == null || m_arrSwipePairConfig.isEmpty() || m_arrSwipePairConfig.contains(null)){
//        throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_SWIPENAMENOTEXIST);
//    }
//    for(PairSwipe swipe:m_arrSwipePairConfig){
//        if(!swipe.isValid()) throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_INVALIDPAIRSWIPECONFIG);
//        if(swipe.getVirtualName().equals(szVirtualName)){
//            return swipe;
//        }
//    }
//    throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_SWIPENAMENOTEXIST);
//}

/**
 * 在成对打卡配置中根据名字查找SINGLESWIPE成员
* @param szName
* @return
* @throws OrganizedException
*/

-(SingleSwipe *)_findSingleSwipeInPairSwipe:(NSString *) szName{
 
  if(_m_arrSwipePairConfig == nil || _m_arrSwipePairConfig.count >0 ){
      return nil;
  }
  
  for(PairSwipe *swipe in _m_arrSwipePairConfig){
      
      SingleSwipe *swipe2 = [swipe findMemberSwipeByName:szName];
      if(swipe2 != nil) return swipe2;
  }
    
    return nil;
}

-(SingleSwipe*)getSingleSwipeByName:(NSString *) szSingleSwipeName{
    
    if(_m_arrSingleSwipeConfig == nil || _m_arrSingleSwipeConfig.count == 0){
        return nil;
    }
    
    for(SingleSwipe *swipe in _m_arrSingleSwipeConfig){
        if([swipe.m_szSwipeDescription isEqualToString:szSingleSwipeName ]){
            return swipe;
        }
    }
    return nil;
}
                                                                                       
@end
