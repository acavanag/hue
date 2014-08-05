//
//  Lights.m
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "Lights.h"
#import <UIKit/UIKit.h>

@interface Lights()
@property (nonatomic, strong) NSOperationQueue *opQueue;
@property (nonatomic, strong) NSString *bridgeIP;
@property (nonatomic, strong) NSTimer *timer;
@end

static NSString *const kHueURL = @"https://www.meethue.com/api/nupnp";

@implementation Lights

- (instancetype)init {
    self = [super init];
    if (self ) {
        _opQueue = [[NSOperationQueue alloc] init];
        [_opQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

+ (Lights *)sharedInstance {
    static Lights *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)findBridgeWithCompletionBlock:(FindBridgeCompletionBlock)handler {
    
    if (self.bridgeIP) {
        handler(self.bridgeIP, nil);
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kHueURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:_opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json.count > 0) {
                NSDictionary *bridge = json[0];
                self.bridgeIP = bridge[@"internalipaddress"];
                handler(self.bridgeIP, nil);
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No bridges found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                handler(nil, nil);
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[connectionError description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            handler(nil, connectionError);
        }
    }];
}

- (void)discoverLightsWithCompletionBlock:(DiscoverLightsCompletionBlock)handler {
    NSString *urlString = [NSString stringWithFormat:@"http://%@/api/newdeveloper/lights", self.bridgeIP];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:_opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *lights = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            handler(lights, nil);
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[connectionError description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            handler(nil, connectionError);
        }
    }];
}

- (void)turnLightOnForKey:(NSString *)key {
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"on" : @YES};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)turnLightOffForKey:(NSString *)key {
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"on" : @NO};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)changeBrightness:(float)brightness forKey:(NSString *)key {
    UInt8 brightnessInt = (UInt8)brightness;
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"bri" : [NSNumber numberWithUnsignedInt:brightnessInt]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)changeSaturation:(float)saturation forKey:(NSString *)key {
    UInt8 saturationInt = (UInt8)saturation;
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"sat" : [NSNumber numberWithUnsignedInt:saturationInt]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)changeHue:(float)hue forKey:(NSString *)key {
    UInt16 hueInt = (UInt16)hue;
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"hue" : [NSNumber numberWithUnsignedInt:hueInt]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)colorLoop:(BOOL)colorLoop forKey:(NSString *)key {
    NSString *loop;
    if (colorLoop) {
        loop = @"colorloop";
    } else {
        loop = @"none";
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.5.119/api/newdeveloper/lights/%@/state", key];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSDictionary *payloadDictionary = @{@"effect" : loop};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDictionary options:0 error:nil];
    NSString *payload = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *bodyData = [payload dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [mRequest setHTTPMethod:@"PUT"];
    [mRequest setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:mRequest queue:self.opQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    }];
}

- (void)beatHeart {
    [self findBridgeWithCompletionBlock:^(NSString *bridgeIP, NSError *error) {
        if (!bridgeIP) return;
        [self discoverLightsWithCompletionBlock:^(NSDictionary *lights, NSError *error) {
            if (!lights) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lightsData = lights;
            });
        }];
    }];
}

- (void)fibrillateWithCompletionHandler:(HeartBeatCompletionBlock)handler {
    [self findBridgeWithCompletionBlock:^(NSString *bridgeIP, NSError *error) {
        if (!bridgeIP) return;
        [self discoverLightsWithCompletionBlock:^(NSDictionary *lights, NSError *error) {
            if (!lights) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(lights, error);
            });
        }];
    }];
}

- (void)startHeartBeart {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(beatHeart) userInfo:nil repeats:YES];
}

- (void)killHeartBeat {
    [self.timer invalidate];
    self.timer = nil;
}

@end
