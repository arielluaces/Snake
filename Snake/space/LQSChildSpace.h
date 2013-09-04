//
//  LQSChildSpace.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSChildSpace.h"

@interface LQSChildSpace : NSObject <ILQSChildSpace>

@property (nonatomic) NSObject<ILQSAdjacentSpace> *parent;
@property (nonatomic) NSObject<ILQSTransformation> *transformToParent;

@end
