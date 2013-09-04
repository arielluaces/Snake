//
//  LQSCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSCollection.h"

@interface LQSCollection : NSObject <ILQSCollection>

@property (nonatomic) NSMutableArray *array;

@end
