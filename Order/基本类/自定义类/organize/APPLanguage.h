//
//  APPLanguage.h
//  organizeClass
//
//  Created by wang on 16/9/26.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * APP语言的枚举类型；当前支持的语言；
 * <pre>
 * <b style="color:green">-英文:</b> 		LAN_ENGLISH,
 * <b style="color:green">-中文简体：</b>	LAN_CHINESE_SIMPLE,
 * <b style="color:green">-中文繁体：</b>	LAN_CHINESE_TRADITIONAL,
 * </pre>
 * @author Sophie_WS
 *
 */
typedef enum  APPlanguage{
    LAN_ENGLISH,
    LAN_CHINESE_SIMPLE,
    LAN_CHINESE_TRADITIONAL,
}APPlanguage;

/**
 *
 * 字典类型
 * <pre>
 * <b style="color:green">-错误:</b> 	DICT_ERROR_CODE,
 * <b style="color:green">-说明：</b>	DICT_DESCRIPTIONS,
 * </pre>
 *
 */
typedef enum  DictType{
    DICT_ERROR_CODE,
    DICT_DESCRIPTIONS
}DictType;

typedef enum LanSuffixResult{
    LANSUFFIX_IS_CORRECT,
    LANSUFFIX_IS_WRONG,
    LANSUFFIX_EMPTY,
    LANSUFFIX_STRING_EMPTY
}LanSuffixResult;

@interface APPLanguage : NSObject

@property(nonatomic,strong) NSMutableArray *m_xmldictErr;
@property(nonatomic,strong) NSMutableArray *m_xmldictDes;
@end
