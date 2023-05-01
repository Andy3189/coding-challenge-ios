//
//  CoinGeckUrlBuilder.h
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//
#import <Foundation/Foundation.h>

@interface CoinGeckoUrlBuilder : NSObject
@property (nonatomic, strong) NSMutableString *url;
@property bool firstParameter;
-(id) initWithUrl: (NSString*) url;
-(instancetype) addParameter: (NSString*) parameter andValue: (NSString *)parameterValue;
-(NSString*) build;
@end
