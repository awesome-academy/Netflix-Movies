//
//  HomeViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 15/11/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Popular", "Trending TV", "Upcomming", "Top Reced"]
    let numberOfSelection = 40
    let numberHeightForRowAt = 200
    
    let homeFeedTable: UITableView = {
        let tableMovies = UITableView(frame: .zero, style: .grouped)
        tableMovies.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
            return tableMovies
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configugeNavbar()
            
            homeFeedTable.delegate = self
            homeFeedTable.dataSource = self
            
            //set CGRect hero header
            let headerView = HeroHeaderUIVIew(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
            homeFeedTable.tableHeaderView = headerView
            
            view.backgroundColor = .systemBackground
            view.addSubview(homeFeedTable)
        }
    
        // navbar
    func configugeNavbar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .black
    }
    //set scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
    }
    
    //layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
//    var heightForHeader: Int? = 40
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    //set header in movie
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(numberHeightForRowAt)
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(numberOfSelection)
    }
}
