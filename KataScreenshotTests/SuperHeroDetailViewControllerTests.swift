//
//  SuperHeroDetailViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Sergio Gutiérrez on 22/12/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
@testable import KataScreenshot

class SuperHeroDetailViewControllerTests: ScreenshotTest {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsSuperHeroWithNoBadge() {
        let superHero = givenASuperHero(isAvenger: false)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)

        verify(viewController: viewController)
    }

    func testShowsSuperHeroWithBadge() {
        let superHero = givenASuperHero(isAvenger: true)

        let viewController = getSuperHeroDetailViewController(superHero.name)

        verify(viewController: viewController)
    }
    
    func testShowsLongNameBeingAvenger() {
        let superHero = givenASuperHeroWithLongName(isAvenger: true)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    func testShowsLongNameNotBeingAvenger() {
        let superHero = givenASuperHeroWithLongName(isAvenger: false)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    func testShowsLongDescriptionBeingAvenger() {
        let superHero = givenASuperHeroWithLongDescription(isAvenger: true)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    func testShowsLongDescriptionNotBeingAvenger() {
        let superHero = givenASuperHeroWithLongDescription(isAvenger: false)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    func testShowsSuperHeroWithEmptyDescription() {
        let superHero = givenASuperHeroWithEmptyDescription(isAvenger: false)
        
        let viewController = getSuperHeroDetailViewController(superHero.name)
        
        verify(viewController: viewController)
    }
    
    func testShowsNoSuperHero() {
        givenNotSuperHero()
        
        let viewController = getSuperHeroDetailViewController("no valid")
        
        verify(viewController: viewController)
    }
    
    func givenNotSuperHero() {
        repository.superHeroes = []
    }
    
    func givenASuperHero(isAvenger: Bool) -> SuperHero {
        let superHero = SuperHeroMother.givenASuperHero(isAvenger: isAvenger)
        repository.superHeroes = [superHero]
        return superHero
    }
    
    func givenASuperHeroWithLongName(isAvenger: Bool) -> SuperHero {
        let superHero = SuperHeroMother.givenASuperHeroWithLongName(isAvenger: isAvenger)
        repository.superHeroes = [superHero]
        return superHero
    }

    func givenASuperHeroWithLongDescription(isAvenger: Bool) -> SuperHero {
        let superHero = SuperHeroMother.givenASuperHeroWithLongDescription(isAvenger: isAvenger)
        repository.superHeroes = [superHero]
        return superHero
    }
    
    func givenASuperHeroWithEmptyDescription(isAvenger: Bool) -> SuperHero {
        let superHero = SuperHeroMother.givenASuperHeroWithEmptyDescription(isAvenger: isAvenger)
        repository.superHeroes = [superHero]
        return superHero
    }
    
    fileprivate func getSuperHeroDetailViewController(_ superHeroName: String) -> UIViewController {
        let superHeroDetailViewController = ServiceLocator()
            .provideSuperHeroDetailViewController(superHeroName) as! SuperHeroDetailViewController
        superHeroDetailViewController.presenter = SuperHeroDetailPresenter(
            ui: superHeroDetailViewController,
            superHeroName: superHeroName,
            getSuperHeroByName: GetSuperHeroByName(repository: repository)
        )

        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroDetailViewController]
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
        return rootViewController
    }
}
