//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroesViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCase() {
        givenThereAreNoSuperHeroes()

        let viewController = getSuperHeroViewController()

        verify(viewController: viewController)
    }
    
    func testShowOneSuperHeroAvenger() {
        givenThereAreSomeSuperHeroes(1, avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowOneSuperHeroNotAvenger() {
        givenThereAreSomeSuperHeroes(1, avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTwoSuperHeroAvengers() {
        givenThereAreSomeSuperHeroes(2, avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTwoSuperHeroNotAvengers() {
        givenThereAreSomeSuperHeroes(2, avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTenSuperHeroAvengers() {
        givenThereAreSomeSuperHeroes(10, avengers: true)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowTenSuperHeroNotAvengers() {
        givenThereAreSomeSuperHeroes(10, avengers: false)
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testShowMixedSuperHeroList() {
        givenThereAreSomeSuperHerosMixed()
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testHerosWithLongName() {
        givenThereAHerosWithLongName()
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    func testHerosWithLongNameWithTwoLines() {
        givenThereAHerosWithLongNameAndTwoLines()
        
        let viewController = getSuperHeroViewController()
        
        verify(viewController: viewController)
    }
    
    fileprivate func givenThereAHerosWithLongName() {
        var superHeros = givenThereAreSomeSuperHeroes(4)
        
        let superHeroOne = SuperHero(name: superHeros[0].name + " Looooooooooooooooooooooooooooooong name",
                                     photo: superHeros[0].photo,
                                     isAvenger: true,
                                     description: superHeros[0].description)
        
        superHeros[0] = superHeroOne
        repository.superHeroes = superHeros
    }
    
    fileprivate func givenThereAHerosWithLongNameAndTwoLines() {
        var superHeros = givenThereAreSomeSuperHeroes(4)
        
        let superHeroOne = SuperHero(name: superHeros[0].name + " Looooooooooooooooooooooooooooooong name\n Nameeeeeeeeeeeeeeeeeeeeeeeeeeeee",
                                     photo: superHeros[0].photo,
                                     isAvenger: true,
                                     description: superHeros[0].description)
        
        superHeros[0] = superHeroOne
        repository.superHeroes = superHeros
    }
    
    fileprivate func givenThereAreSomeSuperHerosMixed() {
        var superHeros = givenThereAreSomeSuperHeroes(4)
        
        let superHeroOne = SuperHero(name: superHeros[0].name,
                                     photo: superHeros[0].photo,
                                     isAvenger: true,
                                     description: superHeros[0].description)

        let superHeroTwo = SuperHero(name: superHeros[0].name,
                                     photo: superHeros[0].photo,
                                     isAvenger: true,
                                     description: superHeros[0].description)
        
 
        
        superHeros[0] = superHeroOne
        superHeros[2] = superHeroTwo

        repository.superHeroes = superHeros
    }
    
    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: URL(string: ""),
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func getSuperHeroViewController() -> UIViewController {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(
            ui: superHeroesViewController,
            getSuperHeroes: GetSuperHeroes(repository: repository)
        )

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
        return rootViewController
    }
}
