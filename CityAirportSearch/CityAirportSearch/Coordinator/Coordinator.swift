//
//  Coordinator.swift
//  CityAirportSearch
//
//  Created by gigas on 2021/05/04.
//

import Foundation

protocol Coordinator: class {
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) -> Void {
        childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) -> Void {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator })
    }
}
