//
//  PokemonTableViewController.h
//  PokedexSprintChallengeObjC
//
//  Created by Nicolas Rios on 6/13/20.
//  Copyright © 2020 Nicolas Rios. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PokedexSprintChallengeObjC-Bridging-Header.h"

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonTableViewController : UITableViewController

@property (nonatomic) PokemonController *controller;
@property (nonatomic, retain) NSArray<Pokemon *> *allPokemon;

@end

NS_ASSUME_NONNULL_END
