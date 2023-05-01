//
//  GeckoUrlBuilder.m
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

#import "CoinGeckoUrlBuilder.h"

@implementation CoinGeckoUrlBuilder

- (id) initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = [NSMutableString stringWithString: url];
        self.firstParameter = YES;
    }
    return self;
}

- (instancetype) addParameter:(NSString *)parameter andValue: (NSString *)parameterValue {
    if (_firstParameter) {
        [_url appendFormat:@"?%@=%@", parameter, parameterValue];
        _firstParameter = NO;
    } else {
        [_url appendFormat:@"&%@=%@", parameter, parameterValue];
    }
    return self;
}

- (NSString *)build {
    return _url;
}

@end
