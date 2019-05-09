//
//  SuperHeroTableViewCellTests.swift
//  KataScreenshot
//
//  Created by Sergio Gutiérrez on 09/01/17.
//  Copyright © 2017 Karumi. All rights reserved.
//

import UIKit
import XCTest
@testable import KataScreenshot

class SuperHeroTableViewCellTests: ScreenshotTest {

    private let anyAvengerSuperHero: SuperHero = SuperHero(name: "Hero",
                                                           photo: nil,
                                                           isAvenger: true,
                                                           description: "Yeah")
     private let anyNotAvengerSuperHero: SuperHero = SuperHero(name: "Batman",
                                                               photo: nil,
                                                               isAvenger: false,
                                                               description: "Batman must be loaded!")
    private let anySuperHeroWithLongName: SuperHero = SuperHero(name: "Long name is my name, do u get my?",
                                                           photo: nil,
                                                           isAvenger: true,
                                                           description: "Yeah")
    private let anySuperHeroWithEmptyName: SuperHero = SuperHero(name: "",
                                                              photo: nil,
                                                              isAvenger: false,
                                                              description: "Batman must be loaded!")
    
    func testShouldTestCellWithAvenger(){
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: anyAvengerSuperHero)
        
        verify(view: cell)
    }
    
    func testShouldTestCellWithNotAvenger(){
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: anyNotAvengerSuperHero)
        
        verify(view: cell)
    }
    
    func testShouldTestCellWithLongName(){
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: anySuperHeroWithLongName)
        
        verify(view: cell)
    }
    
    func testShouldTestCellWithEmptyName(){
        
        let cell = givenASuperHeroTableViewCell()
        
        cell.configure(forItem: anySuperHeroWithEmptyName)
        
        verify(view: cell)
    }
    
    
    private func givenASuperHeroTableViewCell() -> SuperHeroTableViewCell {
        return UINib(nibName: "SuperHeroTableViewCell", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! SuperHeroTableViewCell
    }
}
