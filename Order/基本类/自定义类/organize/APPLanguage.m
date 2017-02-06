//
//  APPLanguage.m
//  organizeClass
//
//  Created by wang on 16/9/26.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "APPLanguage.h"
#import "CommonFunctions.h"
@implementation APPLanguage
/**
 * 获取ErrorCodes.xml中的错误代码的各语言对应的描述信息
 * @param szKeyError - OrganizedException中的Error code串，如 10001，10002，etc.
 * @param applan - 可省略，指的是语言枚举变量，英语，中文简体，或者中文繁体。
 * @return Error的描述
 */
//+(NSString*)languageGetErrorMsg:(NSString *)szKeyError applan:(APPlanguage )appLanguage{
//    
//    return getValeForKey(DictType.DICT_ERROR_CODE,szKeyError,applan);
//}
//
//
//+(NSString *)getValeForKey:(DictType)dcty key:(NSString*)szKey applan:(APPlanguage)applan
//{
//    //初始化DICTIONARY
//    
//    if(!_initDictionary()) return "";
//    
//    szKey = formatKeyPerLanguage(szKey,applan);
//    if(dcty == DictType.DICT_DESCRIPTIONS)
//    {
//        if(m_xmldictDes != null && !m_xmldictDes.isEmpty() && !szKey.isEmpty() && m_xmldictDes.containsKey(szKey)){
//            return m_xmldictDes.get(szKey);
//        }
//    }
//    else if(dcty == DictType.DICT_ERROR_CODE)
//    {
//        if(m_xmldictErr != null && !m_xmldictErr.isEmpty() && !szKey.isEmpty() && m_xmldictErr.containsKey(szKey)){
//            return m_xmldictErr.get(szKey);
//        }
//    }		
//    return "";
//}
//
//
//-(BOOL)_initDictionary{
//    NSString *szXMLERROR = @"ErrorCodes.xml";
//    NSString *szXMLDescription = @"Descriptions.xml";
//    if([CommonFunctions functionsIsRunningOnPC]){
//        String szParent = _getWebInfURI();
//        szXMLDescription = szParent.concat(szXMLDescription);
//        szXMLERROR = szParent.concat(szXMLERROR);
//    }
//    if(initDict(DictType.DICT_ERROR_CODE, szXMLERROR) && initDict(DictType.DICT_DESCRIPTIONS, szXMLDescription))
//    {
//        return true;
//    }
//    else
//    {
//        return false;
//    }
//}
//+(NSString *)getWebInfURI{
//    NSString *szWEBINFURI = XMLDictionary.class.getResource("").toString();
//    String szPackageName = XMLDictionary.class.getPackage().toString();
//    szPackageName = szPackageName.replace("package ", "");
//    szPackageName = szPackageName.replace('.', '/');
//    int iPackagestarter = szWEBINFURI.indexOf(szPackageName);
//    if(iPackagestarter >= 0){
//        szWEBINFURI = szWEBINFURI.substring(0, iPackagestarter);
//    }
//    
//    return szWEBINFURI;
//}
@end
