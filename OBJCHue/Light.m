//
//  Light.m
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "Light.h"

@implementation Light

+ (Light *)lightForKey:(NSString *)key data:(NSDictionary *)lightDictionary {
    
    Light *light = [[Light alloc] init];
    
    light.key = key;
    light.name = lightDictionary[@"name"];
    light.state = lightDictionary[@"state"][@"on"];
    light.brightness = lightDictionary[@"state"][@"bri"];
    light.saturation = lightDictionary[@"state"][@"sat"];
    light.hue = lightDictionary[@"state"][@"hue"];
    light.effect = lightDictionary[@"state"][@"effect"];
    
    return light;
    
}

@end
