//
//  Lights.h
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FindBridgeCompletionBlock)(NSString *bridgeIP, NSError *error);
typedef void (^DiscoverLightsCompletionBlock)(NSDictionary *lights, NSError *error);
typedef void (^HeartBeatCompletionBlock)(NSDictionary *lights, NSError *error);

@interface Lights : NSObject
@property (nonatomic, strong) NSDictionary *lightsData;
+ (Lights *)sharedInstance;
- (void)fibrillateWithCompletionHandler:(HeartBeatCompletionBlock)handler;
- (void)startHeartBeart;
- (void)killHeartBeat;
- (void)turnLightOnForKey:(NSString *)key;
- (void)turnLightOffForKey:(NSString *)key;
- (void)changeBrightness:(float)brightness forKey:(NSString *)key;
- (void)changeSaturation:(float)saturation forKey:(NSString *)key;
- (void)changeHue:(float)hue forKey:(NSString *)key;
- (void)colorLoop:(BOOL)colorLoop forKey:(NSString *)key;
@end
