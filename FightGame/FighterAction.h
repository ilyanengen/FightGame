//
//  FighterAction.h
//  FightGame
//
//  Created by Илья on 13.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, verticalDirectionType) {
    verticalDirectionTypeUp,
    verticalDirectionTypeDown
};

typedef NS_ENUM(NSUInteger, horizontalDirectionType) {
    horizontalDirectionTypeLeft,
    horizontalDirectionTypeRight
};

typedef NS_ENUM(NSUInteger, actionVariantType) {
    actionVariantTypeStraight,
    actionVariantTypeSwing,
    actionVariantTypeHigh,
    actionVariantTypeBlock
};

@interface FighterAction : NSObject

@property (strong, nonatomic) NSString *actionName;
@property (assign, nonatomic) int damage;
@property (assign, nonatomic) int stamina;

@property (assign, nonatomic) verticalDirectionType verticalDirection;
@property (assign, nonatomic) horizontalDirectionType horizontalDirection;
@property (assign, nonatomic) actionVariantType actionVariant;
@property (assign, nonatomic) int priorityLevel;

- (instancetype)initWithActionName:(NSString *)actionName
                  stamina:(int)staminaValue
                    damage:(int)damageValue;

@end
