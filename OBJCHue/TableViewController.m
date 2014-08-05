//
//  TableViewController.m
//  OBJCHue
//
//  Created by Andrew Cavanagh on 8/3/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "Lights.h"
#import "Light.h"
#import "HueController.h"

static NSString *const lightsKeyPath = @"lightsData";

@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"lightCell"];
    self.dataSource = [[NSMutableArray alloc] init];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(beat)]];
    
//    [[Lights sharedInstance]  addObserver:self forKeyPath:lightsKeyPath options:NSKeyValueObservingOptionNew context:NULL];
//    [[Lights sharedInstance]  startHeartBeart];
}

- (void)beat {
    [[Lights sharedInstance] fibrillateWithCompletionHandler:^(NSDictionary *lights, NSError *error) {
        [self processLights:lights];
    }];
}

- (void)dealloc {
//    [[Lights sharedInstance]  removeObserver:self forKeyPath:lightsKeyPath context:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self beat];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:lightsKeyPath]) {
        NSLog(@"Lub Dub");
        [self processLights:[Lights sharedInstance].lightsData];
    }
}

- (void)processLights:(NSDictionary *)lights {
    [self.dataSource removeAllObjects];
    for (NSString *key in [lights allKeys]) {
        NSDictionary *lightDictionary = lights[key];
        Light *light = [Light lightForKey:key data:lightDictionary];
        [self.dataSource addObject:light];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Ident = @"lightCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Ident forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Light *light = self.dataSource[indexPath.row];
    [cell setLight:light];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"lightSegue" sender:self];
}

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"lightSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        Light *light = self.dataSource[selectedIndexPath.row];
        
        HueController *hueController = (HueController *)[segue destinationViewController];
        hueController.light = light;
    }
}

@end
