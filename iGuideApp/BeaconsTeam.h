//
//  BeaconsTeam.h
//  iGuideApp
//
//  Created by Maria cristina rodriguez on 10/16/16.
//  Copyright © 2016 Maria cristina rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeaconData.h"

@interface BeaconsTeam : NSObject

@property NSString *name;
@property NSString *poiDescription;
@property BeaconData *beacon;
@property BeaconData *supportedBeacon;
@property NSNumber *finalRssi;

@end
