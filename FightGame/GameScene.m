//
//  GameScene.m
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    //SKShapeNode *_spinnyNode;
    //SKLabelNode *_label;
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    SKSpriteNode *_upperHUD;
    SKSpriteNode *_lowerHUD;
    
    SKSpriteNode *_mainActionScreen;
    SKShapeNode *_upperLeftScreen;
    SKShapeNode *_upperRightScreen;
    SKShapeNode *_lowerLeftScreen;
    SKShapeNode *_lowerRightScreen;
    
    SKSpriteNode *_opponentSprite;
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
    
    //Opponent
    [self addOpponent];
    
    //UIGestureRecognizer
    [self addGestureRecognizers];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
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
    
    //Stamina and HP bars
    CGSize barSize = CGSizeMake(upperHUD.size.width / 3, upperHUD.size.height / 5);
    
    SKShapeNode *hpBarBackgroundNode = [SKShapeNode shapeNodeWithRectOfSize:barSize];
    hpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width / 6 + _upperHUD.size.width * 0.05, - barSize.height * 1.5);
    hpBarBackgroundNode.zPosition = 11;
    hpBarBackgroundNode.strokeColor = [SKColor blackColor];
    hpBarBackgroundNode.fillColor = [SKColor greenColor];
    [_upperHUD addChild:hpBarBackgroundNode];

    //Lower HUD
    SKSpriteNode *lowerHUD = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:hudSize];
    lowerHUD.anchorPoint = CGPointMake(0, 0);
    lowerHUD.position = CGPointMake(0, 0);
    lowerHUD.zPosition = 10;
    _lowerHUD = lowerHUD;
    [self addChild:_lowerHUD];
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

- (void)addOpponent {

    CGSize opponentSize = CGSizeMake(screenWidth/4, screenHeight/2);
    SKSpriteNode *opponent = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:opponentSize];
    opponent.anchorPoint = CGPointMake(0.5,0.5);
    opponent.position = CGPointMake(screenWidth/2, screenHeight/2);
    opponent.zPosition = 2;
    [self addChild:opponent];
}

#pragma mark - UIGestureRecognizer
- (void)addGestureRecognizers {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *rightSwipePunch = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleRightSwipePunch:)];
    rightSwipePunch.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipePunch];
    
    UISwipeGestureRecognizer *leftSwipePunch = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftSwipePunch:)];
    leftSwipePunch.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftSwipePunch];
    
    UISwipeGestureRecognizer *downSwipeBlock = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleDownSwipeBlock:)];
    downSwipeBlock.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipeBlock];
}

- (void)handleTap:(UITapGestureRecognizer *) tapGesture {

    NSLog(@"Tap!");
    
    //Detect which node was tapped
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [tapGesture locationInView:tapGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer

        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation];//Находим нод, который соответствует позиции на GameScene
        
        NSLog(@"NODE WHICH WAS TAPPED: %@", touchedNode.name);
    }
}

- (void)handleRightSwipePunch:(UITapGestureRecognizer *) rightSwipePunchGesture {

    NSLog(@"RightSwipePunchGesture!");
    
    //Detect which node was swiped
    if (rightSwipePunchGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [rightSwipePunchGesture locationInView:rightSwipePunchGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        NSLog(@"NODE WHICH WAS SWIPED FROM RIGHT TO LEFT: %@", touchedNode.name);
    }
}

- (void)handleLeftSwipePunch:(UITapGestureRecognizer *) leftSwipePunchGesture {
    
    NSLog(@"leftSwipePunchGesture!");
    
    //Detect which node was swiped
    if (leftSwipePunchGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [leftSwipePunchGesture locationInView:leftSwipePunchGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        NSLog(@"NODE WHICH WAS SWIPED FROM LEFT TO RIGHT: %@", touchedNode.name);
    }
}

- (void)handleDownSwipeBlock: (UISwipeGestureRecognizer *) downSwipeBlockGesture {

    NSLog(@"DownSwipeBlockGesture!");
    
    if (downSwipeBlockGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [downSwipeBlockGesture locationInView:downSwipeBlockGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        NSLog(@"NODE WHICH WAS SWIPED DOWN: %@", touchedNode.name);
    }
}

@end
