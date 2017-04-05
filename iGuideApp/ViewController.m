//
//  ViewController.m
//  iGuideApp
//
//  Created by Maria cristina rodriguez on 10/16/16.
//  Copyright © 2016 Maria cristina rodriguez. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconsTeam.h"

@interface ViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) NSMutableDictionary *beaconsRead, *supportBeacons;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property NSMutableArray *beaconsTeams;
@property BOOL firstTime;
@end

@implementation ViewController

long alpha = 0.3;

- (IBAction)singleTapRecognizer:(id)sender {
    NSLog(@"Single tap recognized");
}

- (IBAction)longPressRecognizer:(id)sender {
    NSLog(@"Long pressed recognized");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTime = NO;
    [self configBeacons];
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) configBeacons {
    self.beaconsRead = [[NSDictionary alloc] init];
    self.supportBeacons = [[NSDictionary alloc] init];
    
    [self configBeaconsTeams];
   

}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *firstBeacon = [beacons firstObject];
    
    //[self updateDotPositionForDistance:firstBeacon.accuracy];
    

//    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd,yyyy HH:mm:ss");
//    Date resultdate = new Date(yourmilliseconds);
    NSLog(@"didRangeBeacons");
    
    if (beacons.count == 10){
        self.firstTime = YES;
    }
    
    if (self.firstTime && beacons.count > 0) {
        self [detectBeacon :beacons];
    }
}

- (void) detectBeacon:(NSArray *)beacons {
    
    for (CLBeacon *beacon in beacons) {
        [self updateBeaconRssi:beacon];
    }
    
}


-(void) updateBeaconRssi: (CLBeacon *)beacon {
    long lastRssi = [self.beaconsRead objectForKey:beacon.minor];
    if (lastRssi) {
        long actualRssi = beacon.rssi * -1;
        actualRssi = (alpha * actualRssi + (1 - alpha) * lastRssi);
        [self.beaconsRead setObject:@(actualRssi) forKey:beacon.minor];
        NSLog(@"Updated Rssi for %s with %n", beacon.minor, actualRssi);
    }
    
    lastRssi = [self.supportBeacons objectForKey:beacon.minor];
    if (lastRssi) {
        long actualRssi = beacon.rssi * -1;
        actualRssi = (alpha * actualRssi + (1 - alpha) * lastRssi);
        [self.supportBeacons setObject:@(actualRssi) forKey:beacon.minor];
        NSLog(@"Updated Rssi for supported beacon %s with %n", beacon.minor, actualRssi);
        
        //TODO : verificar que funciona filtro
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.supportedBeaconMinor contains[cd] %n", beacon.minor];
        NSArray *filteredArray = [self.beaconsTeams filteredArrayUsingPredicate:bPredicate];
        
        BeaconsTeam *currentBeaconsTeam = filteredArray[0];
        
        NSLog(@"HERE %@",currentBeaconsTeam.name);
        
        rssiCarry = currentBeaconsTeam.beaconMinor;<#(nonnull id)#>
        equipoAmarillo = rssiCarry + actualRssi;
        
        switch (beacon.minor) {
                case <#constant#>:
                rssiCarry = readsBc.get(52909);
                equipoCandy = rssiCarry + actualRssi;<#statements#>
                break;
                
            default:
                break;
        }
        equipoCandy = rssiCarry + actualRssi;
    }
    
}

-(void) configBeaconsTeams {
    self.beaconsTeams = [[NSMutableArray alloc] init];
    
    BeaconsTeam *equipoVerde = [[BeaconsTeam alloc] init];
    equipoVerde.poiDescription = @"Entrada";
    equipoVerde.beacon = [[BeaconData alloc] init];
    equipoVerde.beacon.minor = @4739;
    equipoVerde.beacon.rssi = 0;
    equipoVerde.supportedBeacon = [[BeaconData alloc] init];
    equipoVerde.supportedBeacon.minor = @13451;
    equipoVerde.supportedBeacon.rssi = 0;
    equipoVerde.finalRssi = 0;
    equipoVerde.name = @"equipoVerde";
    [self.beaconsTeams addObject:equipoVerde];
    
    BeaconsTeam *equipoRemolacha = [[BeaconsTeam alloc] init];
    equipoRemolacha.poiDescription = @"Escaleras";
    equipoRemolacha.beacon = [[BeaconData alloc] init];
    equipoRemolacha.beacon.minor = @1731;
    equipoRemolacha.beacon.rssi = 0;
    equipoRemolacha.supportedBeacon = [[BeaconData alloc] init];
    equipoRemolacha.supportedBeacon.minor = @25989;
    equipoRemolacha.supportedBeacon.rssi = 0;
    equipoRemolacha.finalRssi = 0;
    equipoVerde.name = @"equipoRemolacha";
    [self.beaconsTeams addObject:equipoRemolacha];
    
    BeaconsTeam *equipoAzul = [[BeaconsTeam alloc] init];
    equipoAzul.poiDescription = @"Baños";
    equipoAzul.beacon = [[BeaconData alloc] init];
    equipoAzul.beacon.minor = @17578;
    equipoAzul.beacon.rssi = 0;
    equipoAzul.supportedBeacon = [[BeaconData alloc] init];
    equipoAzul.supportedBeacon.minor = @20799;
    equipoAzul.supportedBeacon.rssi = 0;
    equipoAzul.finalRssi = 0;
    equipoVerde.name = @"equipoAzul";
    [self.beaconsTeams addObject:equipoAzul];
    
    BeaconsTeam *equipoCandy = [[BeaconsTeam alloc] init];
    equipoCandy.poiDescription = @"Molinetes";
    equipoCandy.beacon = [[BeaconData alloc] init];
    equipoCandy.beacon.minor = @52909;
    equipoCandy.beacon.rssi = 0;
    equipoCandy.supportedBeacon = [[BeaconData alloc] init];
    equipoCandy.supportedBeacon.minor = @27802;
    equipoCandy.supportedBeacon.rssi = 0;
    equipoCandy.finalRssi = 0;
    equipoVerde.name = @"equipoCandy";
    [self.beaconsTeams addObject:equipoCandy];
    
    BeaconsTeam *equipoAmarillo = [[BeaconsTeam alloc] init];
    equipoAmarillo.poiDescription = @"Andén";
    equipoAmarillo.beacon = [[BeaconData alloc] init];
    equipoAmarillo.beacon.minor = @28695;
    equipoAmarillo.beacon.rssi = 0;
    equipoAmarillo.supportedBeacon = [[BeaconData alloc] init];
    equipoAmarillo.supportedBeacon.minor = @28617;
    equipoAmarillo.supportedBeacon.rssi = 0;
    equipoAmarillo.finalRssi = 0;
    equipoVerde.name = @"equipoAmarillo";
    [self.beaconsTeams addObject:equipoAmarillo];
    
}





@end
