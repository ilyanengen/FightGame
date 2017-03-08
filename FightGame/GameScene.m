//
//  GameScene.m
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "GameScene.h"
#import "Fighter.h"
#import "FighterAction.h"

typedef NS_ENUM(NSUInteger, resultOfActionComparison) {
    
    resultOfActionComparisonNoDamageForBoth,
    resultOfActionComparisonPlayerWin,
    resultOfActionComparisonOpponentWin,
    resultOfActionComparisonFiftyPercentForBoth
};

@implementation GameScene {
    
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    SKSpriteNode *_upperHUD;
    SKSpriteNode *_lowerHUD;
    
    CGSize _defaultBarSize;
    
    SKSpriteNode *_playerHpBar;
    SKSpriteNode *_opponentHpBar;
    
    SKSpriteNode *_playerStaminaBar;
    SKSpriteNode *_opponentStaminaBar;
    
    SKSpriteNode *_mainActionScreen;
    SKShapeNode *_upperLeftScreen;
    SKShapeNode *_upperRightScreen;
    SKShapeNode *_lowerLeftScreen;
    SKShapeNode *_lowerRightScreen;
    
    Fighter *_player;
    Fighter *_opponent;
    
    NSArray *_opponentActionsArray;
    
    //Gameplay variables
    
    BOOL _playerFirstAndSecondActionsAreAlreadySet;
    BOOL _opponentFirstAndSecondActionsAreAlreadySet;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    self.backgroundColor = [SKColor whiteColor];
    
    //Get screen size to use later
    screenWidth = view.bounds.size.width;
    screenHeight = view.bounds.size.height;
    
    //HUD
    [self addHUD];
    
    //Action Screens
    [self addActionScreens];
    
    //UIGestureRecognizer
    [self addGestureRecognizers];
    
    //Add player
    [self addPlayer];
    
    //Opponent
    [self addOpponent];
    
    //Set up gameplay variables
    _playerFirstAndSecondActionsAreAlreadySet = NO;
    _opponentFirstAndSecondActionsAreAlreadySet = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

#pragma mark - UPDATE METHOD
-(void)update:(CFTimeInterval)currentTime {

}

#pragma mark - Addition of main nodes to Game Scene
- (void)addHUD {
    
    //HUD
    CGSize hudSize = CGSizeMake(screenWidth, screenHeight/10);
    
    //Upper HUD
    SKSpriteNode *upperHUD = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:hudSize];
    upperHUD.anchorPoint = CGPointMake(0, 1);
    upperHUD.position = CGPointMake(0, screenHeight);
    upperHUD.zPosition = 10;
    _upperHUD = upperHUD;
    [self addChild:_upperHUD];
    
    //PLAYER's HP AND STAMINA BARS
    //HP bars
    CGSize barSize = CGSizeMake(upperHUD.size.width / 3, upperHUD.size.height / 5);
    _defaultBarSize = barSize;
    
    SKSpriteNode *hpBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    hpBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    hpBarBackgroundNode.zPosition = 11;
    hpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 2);
    [_upperHUD addChild:hpBarBackgroundNode];
    
    SKSpriteNode *hpBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:barSize];
    hpBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    hpBarNode.zPosition = 12;
    _playerHpBar = hpBarNode;
    [hpBarBackgroundNode addChild:_playerHpBar];
    
    //Stamina Bars
    SKSpriteNode *staminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    staminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    staminaBarBackgroundNode.zPosition = 11;
    staminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 4);
    [_upperHUD addChild:staminaBarBackgroundNode];
    
    SKSpriteNode *staminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    staminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    staminaBarNode.zPosition = 12;
    _playerStaminaBar = staminaBarNode;
    [staminaBarBackgroundNode addChild:_playerStaminaBar];
    
    //OPPONENT's HP AND STAMINA BARS
    //HP bars
    
    SKSpriteNode *opponentHpBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    opponentHpBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    opponentHpBarBackgroundNode.zPosition = 11;
    opponentHpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width - (_upperHUD.size.width * 0.05 + barSize.width), - barSize.height * 2);
    [_upperHUD addChild:opponentHpBarBackgroundNode];
    
    SKSpriteNode *opponentHpBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:barSize];
    opponentHpBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    opponentHpBarNode.zPosition = 12;
    _opponentHpBar = opponentHpBarNode;
    [opponentHpBarBackgroundNode addChild:_opponentHpBar];
    
    //Stamina Bars
    SKSpriteNode *opponentStaminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    opponentStaminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    opponentStaminaBarBackgroundNode.zPosition = 11;
    opponentStaminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width - (_upperHUD.size.width * 0.05 + barSize.width), - barSize.height * 4);
    [_upperHUD addChild:opponentStaminaBarBackgroundNode];
    
    SKSpriteNode *opponentStaminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    opponentStaminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    opponentStaminaBarNode.zPosition = 12;
    _opponentStaminaBar = opponentStaminaBarNode;
    [opponentStaminaBarBackgroundNode addChild:_opponentStaminaBar];
    
    //Lower HUD
    SKSpriteNode *lowerHUD = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:hudSize];
    lowerHUD.anchorPoint = CGPointMake(0, 0);
    lowerHUD.position = CGPointMake(0, 0);
    lowerHUD.zPosition = 10;
    _lowerHUD = lowerHUD;
    [self addChild:_lowerHUD];
    
    //Timer bar
    CGSize timerBarSize = CGSizeMake(upperHUD.size.width / 3 * 2, upperHUD.size.height / 3);
    SKSpriteNode *timerBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:timerBarSize];
    timerBarNode.anchorPoint = CGPointMake(0.5, 0.5); // May be need to change to (0, 0.5) to perform better reductuion of time;
    timerBarNode.position = CGPointMake(_lowerHUD.size.width / 2, _lowerHUD.size.height / 2);
    timerBarNode.zPosition = 11;
    [_lowerHUD addChild:timerBarNode];
}

- (void)addActionScreens {

    CGSize mainActionScreenSize = CGSizeMake(screenWidth, screenHeight - (_upperHUD.size.height + _lowerHUD.size.height));
    SKSpriteNode *mainActionScreen = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:mainActionScreenSize];
    mainActionScreen.anchorPoint = CGPointMake(0, 0);
    mainActionScreen.position = CGPointMake(0, _lowerHUD.size.height);
    mainActionScreen.zPosition = 1;
    
    _mainActionScreen = mainActionScreen;
    [self addChild:_mainActionScreen];
    
    //ShapeNodes
    CGSize rectSize = CGSizeMake(_mainActionScreen.size.width / 2, _mainActionScreen.size.height / 2);
    
    //upperLeft
    SKShapeNode *upperLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperLeftScreen.name = @"upperLeftScreen";
    upperLeftScreen.fillColor = [SKColor clearColor];
    upperLeftScreen.strokeColor = [SKColor grayColor];
    upperLeftScreen.position = CGPointMake(rectSize.width / 2, rectSize.height * 1.5);
    upperLeftScreen.zPosition = 10;
    upperLeftScreen.alpha = 0.3;
    _upperLeftScreen = upperLeftScreen;
    [_mainActionScreen addChild:_upperLeftScreen];
    
    //upperRight
    SKShapeNode *upperRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperRightScreen.name = @"upperRightScreen";
    upperRightScreen.fillColor = [SKColor clearColor];
    upperRightScreen.strokeColor = [SKColor grayColor];
    upperRightScreen.position = CGPointMake(rectSize.width * 1.5, rectSize.height * 1.5);
    upperRightScreen.zPosition = 10;
    upperRightScreen.alpha = 0.3;
    _upperRightScreen = upperRightScreen;
    [_mainActionScreen addChild:_upperRightScreen];
    
    //lowerLeft
    SKShapeNode *lowerLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerLeftScreen.name = @"lowerLeftScreen";
    lowerLeftScreen.fillColor = [SKColor clearColor];
    lowerLeftScreen.strokeColor = [SKColor grayColor];
    lowerLeftScreen.position = CGPointMake(rectSize.width / 2, rectSize.height / 2);
    lowerLeftScreen.zPosition = 10;
    lowerLeftScreen.alpha = 0.3;
    _lowerLeftScreen = lowerLeftScreen;
    [_mainActionScreen addChild:_lowerLeftScreen];
    
    //lowerRight
    SKShapeNode *lowerRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerRightScreen.name = @"lowerRightScreen";
    lowerRightScreen.fillColor = [SKColor clearColor];
    lowerRightScreen.strokeColor = [SKColor grayColor];
    lowerRightScreen.position = CGPointMake(rectSize.width * 1.5, rectSize.height / 2);
    lowerRightScreen.zPosition = 10;
    lowerRightScreen.alpha = 0.3;
    _lowerRightScreen = lowerRightScreen;
    [_mainActionScreen addChild:_lowerRightScreen];
}

- (void)addPlayer {

    //создаем игрока, но не добавляем его на сцену
    CGSize playerSize = CGSizeMake(screenWidth/4, screenHeight/2);
    Fighter *player = [Fighter spriteNodeWithColor:[SKColor greenColor] size:playerSize];
    player.anchorPoint = CGPointMake(0.5,0.5);
    player.position = CGPointMake(screenWidth/2, screenHeight/2);
    player.zPosition = 2;
    player.name = @"playerNode";
    
    player.fighterName = @"playerName";
    player.hp = 100;
    player.stamina = 10;
    
    //UP
    player.upBlock = [[FighterAction alloc]initWithActionName:@"upBlock" stamina:1 damage:0];
    player.upBlock.verticalDirection = verticalDirectionTypeUp;
    player.upBlock.actionVariant = actionVariantTypeBlock;
    player.upBlock.priorityLevel = 7;
    
    //leftUp
    player.leftStraightPunch = [[FighterAction alloc]initWithActionName:@"leftStraightPunch" stamina:1 damage:1];
    player.leftStraightPunch.verticalDirection = verticalDirectionTypeUp;
    player.leftStraightPunch.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftStraightPunch.actionVariant = actionVariantTypeStraight;
    player.leftStraightPunch.priorityLevel = 1;
    
    player.leftSwingPunch = [[FighterAction alloc]initWithActionName:@"leftSwingPunch" stamina:3 damage:3];
    player.leftSwingPunch.verticalDirection = verticalDirectionTypeUp;
    player.leftSwingPunch.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftSwingPunch.actionVariant = actionVariantTypeSwing;
    player.leftSwingPunch.priorityLevel = 3;
    
    player.leftUppercutPunch = [[FighterAction alloc]initWithActionName:@"leftUppercutPunch" stamina:4 damage:4];
    player.leftUppercutPunch.verticalDirection = verticalDirectionTypeUp;
    player.leftUppercutPunch.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftUppercutPunch.actionVariant = actionVariantTypeHigh;
    player.leftUppercutPunch.priorityLevel = 5;
    
    //rightUp
    player.rightStraightPunch = [[FighterAction alloc]initWithActionName:@"rightStraightPunch" stamina:1 damage:1];
    player.rightStraightPunch.verticalDirection = verticalDirectionTypeUp;
    player.rightStraightPunch.horizontalDirection = horizontalDirectionTypeRight;
    player.rightStraightPunch.actionVariant = actionVariantTypeStraight;
    player.rightStraightPunch.priorityLevel = 1;
    
    player.rightSwingPunch = [[FighterAction alloc]initWithActionName:@"rightSwingPunch" stamina:3 damage:3];
    player.rightSwingPunch.verticalDirection = verticalDirectionTypeUp;
    player.rightSwingPunch.horizontalDirection = horizontalDirectionTypeRight;
    player.rightSwingPunch.actionVariant = actionVariantTypeSwing;
    player.rightSwingPunch.priorityLevel = 3;
    
    player.rightUppercutPunch = [[FighterAction alloc]initWithActionName:@"rightUppercutPunch" stamina:4 damage:4];
    player.rightUppercutPunch.verticalDirection = verticalDirectionTypeUp;
    player.rightUppercutPunch.horizontalDirection = horizontalDirectionTypeRight;
    player.rightUppercutPunch.actionVariant = actionVariantTypeHigh;
    player.rightUppercutPunch.priorityLevel = 5;
    
    //DOWN
    player.downBlock = [[FighterAction alloc]initWithActionName:@"downBlock" stamina:1 damage:0];
    player.downBlock.verticalDirection = verticalDirectionTypeDown;
    player.downBlock.actionVariant = actionVariantTypeBlock;
    player.downBlock.priorityLevel = 7;
    
    //leftDown
    player.leftStraightKick = [[FighterAction alloc]initWithActionName:@"leftStraightKick" stamina:2 damage:2];
    player.leftStraightKick.verticalDirection = verticalDirectionTypeDown;
    player.leftStraightKick.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftStraightKick.actionVariant = actionVariantTypeStraight;
    player.leftStraightKick.priorityLevel = 2;
    
    player.leftSwingKick = [[FighterAction alloc]initWithActionName:@"leftSwingKick" stamina:3 damage:3];
    player.leftSwingKick.verticalDirection = verticalDirectionTypeDown;
    player.leftSwingKick.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftSwingKick.actionVariant = actionVariantTypeSwing;
    player.leftSwingKick.priorityLevel = 4;
    
    player.leftHighKick = [[FighterAction alloc]initWithActionName:@"leftHighKick" stamina:5 damage:5];
    player.leftHighKick.verticalDirection = verticalDirectionTypeDown;
    player.leftHighKick.horizontalDirection = horizontalDirectionTypeLeft;
    player.leftHighKick.actionVariant = actionVariantTypeHigh;
    player.leftHighKick.priorityLevel = 6;
    
    //rightDown
    player.rightStraightKick = [[FighterAction alloc]initWithActionName:@"rightStraightKick" stamina:2 damage:2];
    player.rightStraightKick.verticalDirection = verticalDirectionTypeDown;
    player.rightStraightKick.horizontalDirection = horizontalDirectionTypeRight;
    player.rightStraightKick.actionVariant = actionVariantTypeStraight;
    player.rightStraightKick.priorityLevel = 2;
    
    player.rightSwingKick = [[FighterAction alloc]initWithActionName:@"rightSwingKick" stamina:3 damage:3];
    player.rightSwingKick.verticalDirection = verticalDirectionTypeDown;
    player.rightSwingKick.horizontalDirection = horizontalDirectionTypeRight;
    player.rightSwingKick.actionVariant = actionVariantTypeSwing;
    player.rightSwingKick.priorityLevel = 4;
    
    player.rightHighKick = [[FighterAction alloc]initWithActionName:@"rightHighKick" stamina:5 damage:5];
    player.rightHighKick.verticalDirection = verticalDirectionTypeDown;
    player.rightHighKick.horizontalDirection = horizontalDirectionTypeRight;
    player.rightHighKick.actionVariant = actionVariantTypeHigh;
    player.rightHighKick.priorityLevel = 6;
    
    _player = player;
    
    //[self addChild:_player];
}

- (void)addOpponent {

    CGSize opponentSize = CGSizeMake(screenWidth/4, screenHeight/2);
    Fighter *opponent = [Fighter spriteNodeWithColor:[SKColor greenColor] size:opponentSize];
    opponent.anchorPoint = CGPointMake(0.5,0.5);
    opponent.position = CGPointMake(screenWidth/2, screenHeight/2);
    opponent.zPosition = 2;
    opponent.fighterName = @"opponentName";
    opponent.name = @"opponentNode";
    
    opponent.hp = 100;
    opponent.stamina = 10;
    
    //UP
    opponent.upBlock = [[FighterAction alloc]initWithActionName:@"upBlock" stamina:1 damage:0];
    opponent.upBlock.verticalDirection = verticalDirectionTypeUp;
    opponent.upBlock.actionVariant = actionVariantTypeBlock;
    opponent.upBlock.priorityLevel = 7;

    //leftUp
    opponent.leftStraightPunch = [[FighterAction alloc]initWithActionName:@"leftStraightPunch" stamina:1 damage:1];
    opponent.leftStraightPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.leftStraightPunch.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftStraightPunch.actionVariant = actionVariantTypeStraight;
    opponent.leftStraightPunch.priorityLevel = 1;
    
    opponent.leftSwingPunch = [[FighterAction alloc]initWithActionName:@"leftSwingPunch" stamina:3 damage:3];
    opponent.leftSwingPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.leftSwingPunch.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftSwingPunch.actionVariant = actionVariantTypeSwing;
    opponent.leftSwingPunch.priorityLevel = 3;
    
    opponent.leftUppercutPunch = [[FighterAction alloc]initWithActionName:@"leftUppercutPunch" stamina:4 damage:4];
    opponent.leftUppercutPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.leftUppercutPunch.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftUppercutPunch.actionVariant = actionVariantTypeHigh;
    opponent.leftUppercutPunch.priorityLevel = 5;
    
    //rightUp
    opponent.rightStraightPunch = [[FighterAction alloc]initWithActionName:@"rightStraightPunch" stamina:1 damage:1];
    opponent.rightStraightPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.rightStraightPunch.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightStraightPunch.actionVariant = actionVariantTypeStraight;
    opponent.rightStraightPunch.priorityLevel = 1;
    
    opponent.rightSwingPunch = [[FighterAction alloc]initWithActionName:@"rightSwingPunch" stamina:3 damage:3];
    opponent.rightSwingPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.rightSwingPunch.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightSwingPunch.actionVariant = actionVariantTypeSwing;
    opponent.rightSwingPunch.priorityLevel = 3;
    
    opponent.rightUppercutPunch = [[FighterAction alloc]initWithActionName:@"rightUppercutPunch" stamina:4 damage:4];
    opponent.rightUppercutPunch.verticalDirection = verticalDirectionTypeUp;
    opponent.rightUppercutPunch.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightUppercutPunch.actionVariant = actionVariantTypeHigh;
    opponent.rightUppercutPunch.priorityLevel = 5;
    
    //DOWN
    opponent.downBlock = [[FighterAction alloc]initWithActionName:@"downBlock" stamina:1 damage:0];
    opponent.downBlock.verticalDirection = verticalDirectionTypeDown;
    opponent.downBlock.actionVariant = actionVariantTypeBlock;
    opponent.downBlock.priorityLevel = 7;
    
    //leftDown
    opponent.leftStraightKick = [[FighterAction alloc]initWithActionName:@"leftStraightKick" stamina:2 damage:2];
    opponent.leftStraightKick.verticalDirection = verticalDirectionTypeDown;
    opponent.leftStraightKick.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftStraightKick.actionVariant = actionVariantTypeStraight;
    opponent.leftStraightKick.priorityLevel = 2;
    
    opponent.leftSwingKick = [[FighterAction alloc]initWithActionName:@"leftSwingKick" stamina:3 damage:3];
    opponent.leftSwingKick.verticalDirection = verticalDirectionTypeDown;
    opponent.leftSwingKick.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftSwingKick.actionVariant = actionVariantTypeSwing;
    opponent.leftSwingKick.priorityLevel = 4;
    
    opponent.leftHighKick = [[FighterAction alloc]initWithActionName:@"leftHighKick" stamina:5 damage:5];
    opponent.leftHighKick.verticalDirection = verticalDirectionTypeDown;
    opponent.leftHighKick.horizontalDirection = horizontalDirectionTypeLeft;
    opponent.leftHighKick.actionVariant = actionVariantTypeHigh;
    opponent.leftHighKick.priorityLevel = 6;
    
    //rightDown
    opponent.rightStraightKick = [[FighterAction alloc]initWithActionName:@"rightStraightKick" stamina:2 damage:2];
    opponent.rightStraightKick.verticalDirection = verticalDirectionTypeDown;
    opponent.rightStraightKick.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightStraightKick.actionVariant = actionVariantTypeStraight;
    opponent.rightStraightKick.priorityLevel = 2;
    
    opponent.rightSwingKick = [[FighterAction alloc]initWithActionName:@"rightSwingKick" stamina:3 damage:3];
    opponent.rightSwingKick.verticalDirection = verticalDirectionTypeDown;
    opponent.rightSwingKick.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightSwingKick.actionVariant = actionVariantTypeSwing;
    opponent.rightSwingKick.priorityLevel = 4;
    
    opponent.rightHighKick = [[FighterAction alloc]initWithActionName:@"rightHighKick" stamina:5 damage:5];
    opponent.rightHighKick.verticalDirection = verticalDirectionTypeDown;
    opponent.rightHighKick.horizontalDirection = horizontalDirectionTypeRight;
    opponent.rightHighKick.actionVariant = actionVariantTypeHigh;
    opponent.rightHighKick.priorityLevel = 6;
    
    _opponent = opponent;
    [self addChild:_opponent];
    
    _opponentActionsArray = [NSArray arrayWithObjects:
                             opponent.leftStraightPunch, opponent.leftSwingPunch, opponent.leftUppercutPunch,opponent.upBlock,
                             opponent.rightStraightPunch, opponent.rightSwingPunch, opponent.rightUppercutPunch,
                             opponent.leftStraightKick, opponent.leftSwingKick, opponent.leftHighKick, opponent.downBlock,
                             opponent.rightStraightKick, opponent.rightSwingKick, opponent.rightHighKick, nil];
}

#pragma mark - UIGestureRecognizer
- (void)addGestureRecognizers {
    
    //Создаем GestureRecognizer'ы на каждый вид жеста и добавляем на главную вьюху
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *leftToRightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftToRightSwipe:)];
    leftToRightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftToRightSwipeGesture];
    
    UISwipeGestureRecognizer *rightToLeftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleRightToLeftSwipe:)];
    rightToLeftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightToLeftSwipeGesture];
    
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleUpSwipe:)];
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipeGesture];
    
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleDownSwipe:)];
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipeGesture];
}

- (void)handleTap:(UITapGestureRecognizer *) tapGesture {
    
    //Detect which node was tapped
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [tapGesture locationInView:tapGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer

        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation];//Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self handleLeftStraightPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightStraightPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftStraightKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightStraightKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleLeftToRightSwipe:(UITapGestureRecognizer *) leftToRightSwipeGesture {
    
    //Detect which node was swiped
    if (leftToRightSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [leftToRightSwipeGesture locationInView:leftToRightSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self handleLeftSwingPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftSwingKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleRightToLeftSwipe:(UITapGestureRecognizer *) rightToLeftSwipeGesture {
    
    //Detect which node was swiped
    if (rightToLeftSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [rightToLeftSwipeGesture locationInView:rightToLeftSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightSwingPunch];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightSwingKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleUpSwipe: (UISwipeGestureRecognizer *) upSwipeGesture {

    if (upSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [upSwipeGesture locationInView:upSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self handleLeftUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftHighKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightHighKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleDownSwipe: (UISwipeGestureRecognizer *) downSwipeGesture {
    
    if (downSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [downSwipeGesture locationInView:downSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self handleUpBlock];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleUpBlock];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleDownBlock];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleDownBlock];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

#pragma mark - Player's Punches and Kicks
//leftUp
- (void)handleLeftStraightPunch {
    
    NSLog(@"leftStraightPunch");
    
    //Check if there enough stamina to perform action
    if (_player.stamina >= _player.leftStraightPunch.stamina) {
        
        //set first or second action
        [self checkPlayerFirstAndSecondActions:_player.leftStraightPunch];
        [self addOpponentFirstAndSecondActions];
        
    }
}

- (void)handleLeftSwingPunch {
    
    if (_player.stamina >= _player.leftSwingPunch.stamina) {
    
        NSLog(@"leftSwingPunch");
        [self checkPlayerFirstAndSecondActions:_player.leftSwingPunch];
        [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleLeftUppercutPunch {
    
    if (_player.stamina >= _player.leftUppercutPunch.stamina) {
        
    NSLog(@"leftUppercutPunch");
    [self checkPlayerFirstAndSecondActions:_player.leftUppercutPunch];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleUpBlock {
    
    if (_player.stamina >= _player.upBlock.stamina) {
    
    NSLog(@"upBlock");
    [self checkPlayerFirstAndSecondActions:_player.upBlock];
    [self addOpponentFirstAndSecondActions];
    }
}

//rightUp
- (void)handleRightStraightPunch {
    
    if (_player.stamina >= _player.rightStraightPunch.stamina) {
        
    NSLog(@"rightStraightPunch");
    [self checkPlayerFirstAndSecondActions:_player.rightStraightPunch];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleRightSwingPunch {
    
    if (_player.stamina >= _player.rightSwingPunch.stamina) {
    
    NSLog(@"rightSwingPunch");
    [self checkPlayerFirstAndSecondActions:_player.rightSwingPunch];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleRightUppercutPunch {
    
    if (_player.stamina >= _player.rightUppercutPunch.stamina) {
    
    NSLog(@"rightUppercutPunch");
    [self checkPlayerFirstAndSecondActions:_player.rightUppercutPunch];
    [self addOpponentFirstAndSecondActions];
    }
}

//leftDown
- (void)handleLeftStraightKick {
    
    if (_player.stamina >= _player.leftStraightKick.stamina) {
    
    NSLog(@"leftStraightKick");
    [self checkPlayerFirstAndSecondActions:_player.leftStraightKick];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleLeftSwingKick {
    
    if (_player.stamina >= _player.leftSwingKick.stamina) {
    
    NSLog(@"leftSwingKick");
    [self checkPlayerFirstAndSecondActions:_player.leftSwingKick];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleLeftHighKick {
    
    if (_player.stamina >= _player.leftHighKick.stamina) {
        
    NSLog(@"leftHighKick");
    [self checkPlayerFirstAndSecondActions:_player.leftHighKick];
    [self addOpponentFirstAndSecondActions];
    }
}
- (void)handleDownBlock {
    
    if (_player.stamina >= _player.downBlock.stamina) {
        
    NSLog(@"downBlock");
    [self checkPlayerFirstAndSecondActions:_player.downBlock];
    [self addOpponentFirstAndSecondActions];
    }
}

//rightDown
- (void)handleRightStraightKick {
    
    if (_player.stamina >= _player.rightStraightKick.stamina) {
    
    NSLog(@"rightStraightKick");
    [self checkPlayerFirstAndSecondActions:_player.leftStraightKick];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleRightSwingKick {
    
    if (_player.stamina >= _player.rightSwingKick.stamina) {
    
    NSLog(@"rightSwingKick");
    [self checkPlayerFirstAndSecondActions:_player.leftSwingKick];
    [self addOpponentFirstAndSecondActions];
    }
}

- (void)handleRightHighKick {
    
    if (_player.stamina >= _player.rightHighKick.stamina) {
    
    NSLog(@"rightHighKick");
    [self checkPlayerFirstAndSecondActions:_player.rightHighKick];
    [self addOpponentFirstAndSecondActions];
    }
}

#pragma mark - SET PLAYER'S FIRST AND SECOND ACTIONS
- (void)checkPlayerFirstAndSecondActions: (FighterAction *)fighterAction {
    
    if (!_player.firstAction) {
        
        _player.firstAction = fighterAction;
        
        //отнимаем стамину для первого действия игрока
        [self reduceStaminaOfFighter:_player
               reduceStaminaBarWidth:_playerStaminaBar
                  usingFighterAction:_player.firstAction];
        
        NSLog(@"\n\nplayer's FIRST ACTION is : %@ (stamina = %d, damage = %d)\n\n", _player.firstAction.actionName, _player.firstAction.stamina, _player.firstAction.damage);
        
    } else if (!_player.secondAction) {
        
        _player.secondAction = fighterAction;
        
        //отнимаем стамину для второго действия игрока
        [self reduceStaminaOfFighter:_player
               reduceStaminaBarWidth:_playerStaminaBar
                  usingFighterAction:_player.secondAction];
        
        NSLog(@"\n\nplayer's SECOND ACTION is : %@ (stamina = %d, damage = %d)\n\n", _player.secondAction.actionName, _player.secondAction.stamina, _player.secondAction.damage);
        
        _playerFirstAndSecondActionsAreAlreadySet = YES;
        NSLog(@"FIRST AND SECOND ACTIONS ARE ALREADY SET!");
        
    }else{
        
        NSLog(@"Sorry, but Player's First and Second actions are already set!");
    }
}

#pragma mark - OPPONENT'S ACTIONS
- (void)addOpponentFirstAndSecondActions {
    
    NSLog(@"addOpponentFirstAndSecondActions method is called");
    
    //Добавляем действия оппонента
    
    //Проверяем есть ли у оппонента стамина
    if (_opponent.stamina > 0) {
        
    //Проверяем сделал ли игрок два действия и не были ли еще выставлены все действия оппонента
    if (_playerFirstAndSecondActionsAreAlreadySet && !_opponentFirstAndSecondActionsAreAlreadySet) {

    //OPPONENT'S FIRST ACTION
    NSUInteger firstRandomObjectNumber = [self randomObjectNumberFromArray:_opponentActionsArray];
    FighterAction *opponentFirstRandomAction = [_opponentActionsArray objectAtIndex:firstRandomObjectNumber];
        
        //Если недостаточно стамины - выбираем другое действие
        if (opponentFirstRandomAction.stamina > _opponent.stamina) {
            
            NSLog(@"opponentFirstRandomAction.stamina > _opponent.stamina!!!");
            
            while (opponentFirstRandomAction.stamina > _opponent.stamina) {
                
                NSUInteger randomObjectNumber = [self randomObjectNumberFromArray:_opponentActionsArray];
                opponentFirstRandomAction = [_opponentActionsArray objectAtIndex:randomObjectNumber];
                
                if (opponentFirstRandomAction.stamina <= _opponent.stamina)
                    break;
                NSLog(@"WHOOOORAY!!!! opponentFirstRandomAction is set. Random action name is %@", opponentFirstRandomAction.actionName);
            }
        }
        _opponent.firstAction = opponentFirstRandomAction;
        NSLog(@"\n\nopponent's FIRST ACTION is : %@ (stamina = %d, damage = %d)\n\n", _opponent.firstAction.actionName, _opponent.firstAction.stamina, _opponent.firstAction.damage);
        
        //Отнимаем стамину для первого действия оппонента
        [self reduceStaminaOfFighter:_opponent
               reduceStaminaBarWidth:_opponentStaminaBar
                  usingFighterAction:_opponent.firstAction];
        
        
        //OPPONENT'S SECOND ACTION
        NSUInteger secondRandomObjectNumber = [self randomObjectNumberFromArray:_opponentActionsArray];
        FighterAction *opponentSecondRandomAction = [_opponentActionsArray objectAtIndex:secondRandomObjectNumber];
        
        if (opponentSecondRandomAction.stamina > _opponent.stamina) {
            
            NSLog(@"opponentSecondRandomAction.stamina > _opponent.stamina!!!");
            
            while (opponentSecondRandomAction.stamina > _opponent.stamina) {
                
                NSUInteger secondRandomObjectNumber = [self randomObjectNumberFromArray:_opponentActionsArray];
                NSLog(@"Lets find another randomAction!");
                opponentSecondRandomAction = [_opponentActionsArray objectAtIndex:secondRandomObjectNumber];
                
                if (opponentSecondRandomAction.stamina <= _opponent.stamina)
                    break;
                NSLog(@"WHOOOORAY!!!! opponentSecondRandomAction is set. Random action name is %@", opponentSecondRandomAction.actionName);
            }
        }
        _opponent.secondAction = opponentSecondRandomAction;
        NSLog(@"\n\nopponent's SECOND ACTION is : %@ (stamina = %d, damage = %d)\n\n", _opponent.secondAction.actionName, _opponent.secondAction.stamina, _opponent.secondAction.damage);
        
        //Отнимаем стамину для второго действия оппонента
        [self reduceStaminaOfFighter:_opponent
               reduceStaminaBarWidth:_opponentStaminaBar
                  usingFighterAction:_opponent.secondAction];
        
        //Ставим булевый флаг, что первое и второе действия оппонента назначены
        //Запускаем расчет действий и их результатов
        _opponentFirstAndSecondActionsAreAlreadySet = YES;
        [self calculateResultOfRound];
        
    }
    } else {
        
        NSLog(@"opponent stamina <= 0");
    }
}

- (NSUInteger)randomObjectNumberFromArray: (NSArray *)array {

    NSUInteger arrayCount = [array count];
    int randomInt = arc4random_uniform((int)arrayCount);
    
    return (NSUInteger)randomInt;
}

#pragma mark - CALCULATION OF RESULT

- (void)reduceStaminaOfFighter: (Fighter *)fighter reduceStaminaBarWidth: (SKSpriteNode *)fighterStaminaBar usingFighterAction:(FighterAction *)fighterAction {
    
    //reduce stamina value of fighter
    fighter.stamina = fighter.stamina - fighterAction.stamina;
    
    //reduce width of fighter's stamina bar
    CGFloat staminaBarNewWidth = fighterStaminaBar.size.width - _defaultBarSize.width * fighterAction.stamina / 10;
    fighterStaminaBar.size = CGSizeMake(staminaBarNewWidth, fighterStaminaBar.size.height);
    
    NSLog(@"%@'s stamina = %d, %@'s staminaBarWidth = %f", fighter.fighterName, fighter.stamina, fighter.fighterName, fighterStaminaBar.size.width);
}

- (void)calculateResultOfRound {
    
    //тут мы рассчитываем исход действий игрока и оппонента - FIRST ACTION
    resultOfActionComparison firstActionResult = [self compareActionOfPlayer:_player.firstAction
        withActionOfOpponent:_opponent.firstAction];
    [self printActionNumber:1 comparisonResultNumber:firstActionResult];
    
    //тут идет метод анимации ударов
    //тут идет метод сокращения HP
    
    //тут мы рассчитываем исход действий игрока и оппонента - SECOND ACTION
    resultOfActionComparison secondActionResult = [self compareActionOfPlayer:_player.secondAction
           withActionOfOpponent:_opponent.secondAction];
    [self printActionNumber:2 comparisonResultNumber:secondActionResult];
    
    //тут идет метод анимации ударов
    //тут идет метод сокращения HP
    
//тут должен быть запуск новой итерации First, Second Actions + обнуление флагов
}


- (resultOfActionComparison)compareActionOfPlayer: (FighterAction *)playerAction
                    withActionOfOpponent: (FighterAction *)opponentAction {
    
    //Объявляем переменную, которая будет возвращена из этого метода
    resultOfActionComparison result = 0;
    
    //Создадим сеты ударов противника и игрока чтобы разделять в зависимости от типа блока
    NSSet *playerCanUpBlockSet = [NSSet setWithObjects:
                                _opponent.leftStraightPunch, _opponent.rightStraightPunch,
                                _opponent.leftSwingPunch, _opponent.rightSwingPunch,
                                _opponent.leftUppercutPunch, _opponent.rightUppercutPunch,
                                _opponent.leftHighKick,_opponent.rightHighKick, nil];
    
    NSSet *playerCanDownBlockSet = [NSSet setWithObjects:
                                  _opponent.leftStraightKick, _opponent.rightStraightKick,
                                  _opponent.leftSwingKick, _opponent.rightSwingKick, nil];
    
    NSSet *opponentCanUpBlockSet = [NSSet setWithObjects:
                                      _player.leftStraightPunch, _player.rightStraightPunch,
                                      _player.leftSwingPunch, _player.rightSwingPunch,
                                      _player.leftUppercutPunch, _player.rightUppercutPunch,
                                      _player.leftHighKick, _player.rightHighKick, nil];
    
    NSSet *opponentCanDownBlockSet = [NSSet setWithObjects:
                                          _player.leftStraightKick, _player.rightStraightKick,
                                          _player.leftSwingKick, _player.rightSwingKick, nil];
    
    //CASE#1 - если действия бойцов имеют одинаковое значениe Priority Level
    if (playerAction.priorityLevel == opponentAction.priorityLevel) {
        
        if (playerAction.actionVariant != actionVariantTypeBlock || opponentAction.actionVariant != actionVariantTypeBlock ) {
        
            if (playerAction.actionVariant == opponentAction.actionVariant && playerAction.horizontalDirection == opponentAction.horizontalDirection) {
                NSLog(@"player and opponent performed the same action -> Fifty percent of damage for both fighters");
                result = resultOfActionComparisonFiftyPercentForBoth;
            } else {
                NSLog(@"player and opponent performed the same action but different sides (Right and Left) -> no damage for both");
                result = resultOfActionComparisonNoDamageForBoth;
            }
    
        } else if (playerAction.actionVariant == actionVariantTypeBlock && opponentAction.actionVariant == actionVariantTypeBlock) {
        
            NSLog(@"player and opponent performed blocks");
            result = resultOfActionComparisonNoDamageForBoth;
            
        } else {
        
            NSLog(@"ERROR! incorrect action!");
        }
    }
    
    //CASE#2 - если priorityLevel у игрока выше чем у оппонента
    if (playerAction.priorityLevel > opponentAction.priorityLevel) {
        
        //Если игрок поставил блок
        if (playerAction.actionVariant == actionVariantTypeBlock) {
            
            switch (playerAction.verticalDirection) {
                case verticalDirectionTypeUp: //Если игрок поставил верхний блок
                    if ([playerCanUpBlockSet containsObject:opponentAction]) {
                        
                        NSLog(@"canBeUpBlockedSet contains opponentAction");
                        result = resultOfActionComparisonPlayerWin;
                    } else {
                        
                        NSLog(@":( canBeUpBlockedSet does not contain opponentAction");
                        result = resultOfActionComparisonOpponentWin;
                    }
                    break;
                    
                case verticalDirectionTypeDown: //Если игрок поставил нижний блок
                    if ([playerCanDownBlockSet containsObject:opponentAction]) {
                        
                        NSLog(@"canBeDownBlockedSet contains opponentAction");
                        result = resultOfActionComparisonPlayerWin;
                    }else {
                        
                        NSLog(@"canBeDownBlockedSet does not contain opponentAction");
                        result = resultOfActionComparisonOpponentWin;
                    }
                    break;
            }
        //Если игрок сделал не блок
        } else if (playerAction.actionVariant != actionVariantTypeBlock) {
        
            result = resultOfActionComparisonPlayerWin;
        } else {
            NSLog(@"ERROR! incorrect action!");
        }
    }
    //CASE#3
    if (playerAction.priorityLevel < opponentAction.priorityLevel) {
        
        //Если оппонент поставил блок
        if (opponentAction.actionVariant == actionVariantTypeBlock) {
            
            switch (opponentAction.verticalDirection) {
                case verticalDirectionTypeUp: //Если оппонент поставил верхний блок
                    if ([opponentCanUpBlockSet containsObject:playerAction]) {
                        
                        NSLog(@":((( opponentCanBeUpBlockedSet contains playerAction");
                        result = resultOfActionComparisonOpponentWin;
                    } else {
                        
                        NSLog(@" opponentCanBeUpBlockedSet does not contain playerAction");
                        result = resultOfActionComparisonPlayerWin;
                    }
                    break;
                    
                case verticalDirectionTypeDown: //Если оппонент поставил нижний блок
                    if ([opponentCanDownBlockSet containsObject:playerAction]) {
                        
                        NSLog(@":(((( opponentCanBeDownBlockedSet contains playerAction");
                        result = resultOfActionComparisonOpponentWin;
                    }else {
                        
                        NSLog(@"opponentCanBeDownBlockedSet does not contain playerAction");
                        result = resultOfActionComparisonPlayerWin;
                    }
                    break;
            }
            //Если оппонент сделал не блок
        } else if (opponentAction.actionVariant != actionVariantTypeBlock) {
            
            result = resultOfActionComparisonOpponentWin;
        } else {
            NSLog(@"ERROR! incorrect action!");
        }
    }
    return result;
}

- (void)printActionNumber: (NSUInteger) actionNumber
   comparisonResultNumber: (NSUInteger) resultNumber {

    switch (resultNumber) {
        case 0:
            NSLog(@"\n\n Action#%ld ComparisonResult: NoDamageForBoth \n\n", actionNumber);
            break;
        case 1:
            NSLog(@"\n\n Action#%ld ComparisonResult: PlayerWin, \n\n", actionNumber);
            break;
        case 2:
            NSLog(@"\n\n Action#%ld ComparisonResult: OpponentWin \n\n", actionNumber);
            break;
        case 3:
            NSLog(@"\n\n Action#%ld ComparisonResult: FiftyPercentForBoth \n\n", actionNumber);
            break;
    }
}

@end
