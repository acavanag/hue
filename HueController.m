//
//  HueController.m
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "HueController.h"

@interface HueController ()
@property (weak, nonatomic) IBOutlet UISwitch *strobeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UILabel *hueLabel;
@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@end

@implementation HueController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.brightnessSlider addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
    [self.saturationSlider addTarget:self action:@selector(saturationChanged:) forControlEvents:UIControlEventValueChanged];
    [self.hueSlider addTarget:self action:@selector(hueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.strobeSwitch addTarget:self action:@selector(strobeSwitched:) forControlEvents:UIControlEventValueChanged];
    
    [self configureLight];
    [self configureStrobeSwitch:self.light];
}

- (void)brightnessChanged:(UISlider *)slider {
    [[Lights sharedInstance] changeBrightness:slider.value forKey:self.light.key];
    [self.brightnessLabel setText:[NSString stringWithFormat:@"Brightness: %hhu/255", (UInt8)slider.value]];
}

- (void)saturationChanged:(UISlider *)slider {
    [[Lights sharedInstance] changeSaturation:slider.value forKey:self.light.key];
    [self.saturationLabel setText:[NSString stringWithFormat:@"Saturation: %hhu/255", (UInt8)slider.value]];
}

- (void)hueChanged:(UISlider *)slider {
    [[Lights sharedInstance] changeHue:slider.value forKey:self.light.key];
    [self.hueLabel setText:[NSString stringWithFormat:@"Hue: %hu/65535", (UInt16)slider.value]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureLight {
    
    [self.brightnessLabel setText:[NSString stringWithFormat:@"Brightness: %@/255", self.light.brightness]];
    [self.saturationLabel setText:[NSString stringWithFormat:@"Saturation: %@/255", self.light.saturation]];
    [self.hueLabel setText:[NSString stringWithFormat:@"Hue: %@/65535", self.light.hue]];
    
    [self.brightnessSlider setValue:[self.light.brightness floatValue] animated:YES];
    [self.saturationSlider setValue:[self.light.saturation floatValue] animated:YES];
    [self.hueSlider setValue:[self.light.hue floatValue] animated:YES];
    
    [self setTitle:[NSString stringWithFormat:@"%@ - %@", self.light.key, self.light.name]];
}

- (void)configureStrobeSwitch:(Light *)light {
    if ([light.effect isEqualToString:@"colorloop"]) {
        [self.strobeSwitch setOn:YES animated:YES];
    } else {
        [self.strobeSwitch setOn:NO animated:YES];
    }
}

- (void)strobeSwitched:(id)sender {
    [[Lights sharedInstance] colorLoop:self.strobeSwitch.on forKey:self.light.key];
}

#pragma mark - Table view data source

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
