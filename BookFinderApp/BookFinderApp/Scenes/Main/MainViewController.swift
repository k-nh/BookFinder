//
//  MainViewController.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainDisplayLogic: class {
    func displayBookData(viewModel: Main.BookData.ViewModelSuccess)
}

class MainViewController: UITableViewController, MainDisplayLogic {
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색어를 입력해주세요."
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIP()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIP()
    }
    
    // MARK: Setup
    
    private func setupVIP() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "책 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: Do something
    func displayBookData(viewModel: Main.BookData.ViewModelSuccess) {
        tableView.reloadData()
    }
    
    func displayErrorAlert(viewModel: Main.BookData.ViewModelFailure) {
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request = Main.BookData.Request(keyword: searchBar.text)
        interactor?.doSomething(request: request)
    }
    
}
