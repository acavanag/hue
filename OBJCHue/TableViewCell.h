//
//  TableViewCell.h
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Light.h"

@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UISwitch *lightSwitch;
@property (nonatomic, strong) Light *light;
@end
