//
//  Annotation.h
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 31/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Annotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
