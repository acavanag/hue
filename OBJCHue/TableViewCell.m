//
//  TableViewCell.m
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "TableViewCell.h"
#import "Lights.h"

@interface TableViewCell()
@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.lightSwitch = [[UISwitch alloc] init];
        [self.lightSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.lightSwitch];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

- (void)setLight:(Light *)light {
    _light = light;
    [self.nameLabel setText:[NSString stringWithFormat:@"%@ %@", light.key, light.name]];
    [self.lightSwitch setOn:[light.state boolValue] animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.nameLabel sizeToFit];
    
    [self.nameLabel setFrame:CGRectMake(10, (self.contentView.frame.size.height - self.nameLabel.frame.size.height) * 0.5, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height)];
    [self.lightSwitch setFrame:CGRectMake(self.contentView.frame.size.width - self.lightSwitch.frame.size.width - 10, (self.contentView.frame.size.height - self.lightSwitch.frame.size.height)*0.5, self.lightSwitch.frame.size.width, self.lightSwitch.frame.size.height)];
}

- (void)switchChanged:(id)sender {
    if (!self.lightSwitch.on) {
        [[Lights sharedInstance] turnLightOffForKey:self.light.key];
    } else {
        [[Lights sharedInstance] turnLightOnForKey:self.light.key];
    }
}

@end
