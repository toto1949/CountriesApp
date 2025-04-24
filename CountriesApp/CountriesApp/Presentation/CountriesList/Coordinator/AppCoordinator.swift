//
//  AppCoordinator.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showCountriesList()
    }
    
    private func showCountriesList() {
        let networkService = NetworkService()
        let countryService = CountryService(networkService: networkService)
        let viewModel = CountriesListViewModel(countryService: countryService)
        let viewController = CountriesListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

