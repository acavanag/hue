//
//  Light.h
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Light : NSObject
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) NSNumber *brightness;
@property (nonatomic, strong) NSNumber *saturation;
@property (nonatomic, strong) NSNumber *hue;
@property (nonatomic, strong) NSString *effect;
+ (Light *)lightForKey:(NSString *)key data:(NSDictionary *)lightDictionary;
@end
