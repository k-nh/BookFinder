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

import SafariServices
import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayBookData(viewModel: Main.BookData.ViewModelSuccess)
    func displayError(viewModel: Main.BookData.ViewModelFailure)
}

class MainViewController: UITableViewController, MainDisplayLogic {
    var interactor: MainBusinessLogic?
    
    // MARK: UIComponents
    private lazy var searchController = UISearchController().then {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "검색어를 입력해주세요."
        $0.searchBar.enablesReturnKeyAutomatically = false
        $0.searchBar.delegate = self
    }
    
    private lazy var loadingFooterView = LoadingView().then {
        $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
    
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
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    var totalItemCount: Int?
    var displayedBooks: [Book] = []
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    var lastKeyword: String?
    
    // MARK: Do something
    func displayBookData(viewModel: Main.BookData.ViewModelSuccess) {
        tableView.tableFooterView = nil
        
        if totalItemCount == nil {
            totalItemCount = viewModel.displayedBooks.totalItemCount
        }
        
        guard let newData = viewModel.displayedBooks.books else { return }
        self.displayedBooks.append(contentsOf: newData)
        
        let currentDataCount = self.displayedBooks.count
        let totalCount = self.totalItemCount ?? 0
        self.hasNextPage =  currentDataCount >= totalCount - 10 ? false : true
        self.isPaging = false
        
        self.tableView.reloadData()
    }
    
    func displayError(viewModel: Main.BookData.ViewModelFailure) {
        let alertController = UIAlertController(title: "오류", message: viewModel.errorMessage, preferredStyle: .alert)
    
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: TableView
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBooks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedBook = displayedBooks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        cell.configureData(displayedBook)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let count = totalItemCount {
            return "결과 \(count)개"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedBook = displayedBooks[indexPath.row]
        if let url = URL(string: displayedBook.infoLink) {
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            if hasNextPage && !isPaging {
                startPaging()
            }
        }
    }
}

// MARK: SearchBar
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            displayError(viewModel: Main.BookData.ViewModelFailure.init(errorMessage: "검색어를 입력해주세요."))
        } else {
            lastKeyword = searchBar.text
            totalItemCount = nil
            displayedBooks.removeAll()
            tableView.reloadData()
            tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.height), animated: true)
            fetchBookData()
        }
    }
}

// MARK: Private
private extension MainViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "책 검색"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func startPaging() {
        isPaging = true
        tableView.tableFooterView = loadingFooterView
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchBookData()
        }
    }
    
    func fetchBookData() {
        if let keyword = lastKeyword {
            let request = Main.BookData.Request(keyword: keyword, startIndex: self.displayedBooks.count)
            interactor?.fetchBookData(request: request)
        }
    }
}
