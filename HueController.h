//
//  HueController.h
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Light.h"
#import "Lights.h"

@interface HueController : UITableViewController
@property (nonatomic, weak) Light *light;
@end
