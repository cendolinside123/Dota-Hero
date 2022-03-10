//
//  ListHeroTC.swift
//  Hero DotaTests
//
//  Created by Jan Sebastian on 10/03/22.
//

import XCTest
@testable import Hero_Dota
import CoreData

class ListHeroTC: XCTestCase {

    var viewModel: ListHeroStatVMGuideline?
    
    
    func testLoadAPI() {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let cdStack = CoreDataStack(modelName: "Hero_Dota")
        cdStack.getStoreContainer().persistentStoreDescriptions = [persistentStoreDescription]
        
        let useCase = ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: cdStack))
        viewModel = ListHeroStatViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of hero")
        viewModel?.heroResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation.fulfill()
        }
        viewModel?.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        viewModel?.loadHero(retry: 3)
        wait(for: [loadExpectation], timeout: 5)
    }
    
    func testFilter() {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let cdStack = CoreDataStack(modelName: "Hero_Dota")
        cdStack.getStoreContainer().persistentStoreDescriptions = [persistentStoreDescription]
        
        let useCase = ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: cdStack))
        viewModel = ListHeroStatViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of hero")
        let loadExpectation2 = expectation(description: "should return list of filtered hero")
        viewModel?.heroResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation.fulfill()
        }
        viewModel?.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.heroFilter = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation2.fulfill()
        }
        viewModel?.loadHero(retry: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.filterHero(role: .Disabler)
        wait(for: [loadExpectation2], timeout: 1)
    }

    func testSorting() {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let cdStack = CoreDataStack(modelName: "Hero_Dota")
        cdStack.getStoreContainer().persistentStoreDescriptions = [persistentStoreDescription]
        
        let useCase = ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: cdStack))
        viewModel = ListHeroStatViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of hero")
        let loadExpectation2 = expectation(description: "should return list of sorted hero")
        var temp = [Hero]()
        viewModel?.heroResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            temp = self.viewModel!.result
            loadExpectation.fulfill()
        }
        viewModel?.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.sortHero = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            XCTAssertEqual(self.viewModel!.result.count, temp.count)
            loadExpectation2.fulfill()
        }
        viewModel?.loadHero(retry: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.sortHero(by: .B_Attk)
        wait(for: [loadExpectation2], timeout: 1)
    }
    
    func testSortFilter() {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let cdStack = CoreDataStack(modelName: "Hero_Dota")
        cdStack.getStoreContainer().persistentStoreDescriptions = [persistentStoreDescription]
        
        let useCase = ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: cdStack))
        viewModel = ListHeroStatViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of hero")
        let loadExpectation2 = expectation(description: "should return list of sorted hero")
        let loadExpectation3 = expectation(description: "should return list of filtered hero")
        var temp = [Hero]()
        viewModel?.heroResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            temp = self.viewModel!.result
            loadExpectation.fulfill()
        }
        viewModel?.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.sortHero = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            XCTAssertEqual(self.viewModel!.result.count, temp.count)
            loadExpectation2.fulfill()
        }
        
        viewModel?.heroFilter = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation3.fulfill()
        }
        viewModel?.loadHero(retry: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.sortHero(by: .B_Attk)
        wait(for: [loadExpectation2], timeout: 1)
        viewModel?.filterHero(role: .Disabler)
        wait(for: [loadExpectation3], timeout: 1)
    }
    
    func testFilterSort() {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let cdStack = CoreDataStack(modelName: "Hero_Dota")
        cdStack.getStoreContainer().persistentStoreDescriptions = [persistentStoreDescription]
        
        let useCase = ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: cdStack))
        viewModel = ListHeroStatViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return list of hero")
        let loadExpectation3 = expectation(description: "should return list of sorted hero")
        let loadExpectation2 = expectation(description: "should return list of filtered hero")
        viewModel?.heroResult = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation.fulfill()
        }
        viewModel?.fetchError = { error in
            print("error: \(error.localizedDescription)")
            XCTAssert(false)
        }
        
        viewModel?.sortHero = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation3.fulfill()
        }
        
        viewModel?.heroFilter = { _ in
            XCTAssertGreaterThan(self.viewModel!.result.count, 0)
            loadExpectation2.fulfill()
        }
        viewModel?.loadHero(retry: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.filterHero(role: .Disabler)
        wait(for: [loadExpectation2], timeout: 1)
        viewModel?.sortHero(by: .B_Attk)
        wait(for: [loadExpectation3], timeout: 1)
        
    }
    
}
