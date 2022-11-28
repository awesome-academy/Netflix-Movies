//
//  HomeViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 15/11/2022.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcomming = 3
    case TopRaced = 4
}

final class HomeViewController: UIViewController  {
    
    let sectionTitles: [String] = ["Trending Movies", "Trending TV",  "Popular", "Upcomming Movies", "Top Raced"]
    let numberOfSelection = 40
    let numberHeightForRowAt = 200
    let titleRepository = TitleRepository()
    var listTitle = [Title]()
    private var titleInfo: Title?
    private let network = APICaller.shared
    
    let homeFeedTable: UITableView = {
        let tableMovies = UITableView(frame: .zero, style: .grouped)
        tableMovies.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.defaultReuseIdentifier)
            return tableMovies
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configugeNavbar()
            
            //set CGRect hero header
            let headerView = HeroHeaderUIVIew(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
            homeFeedTable.tableHeaderView = headerView
            
            homeFeedTable.delegate = self
            homeFeedTable.dataSource = self
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.defaultReuseIdentifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            titleRepository.getData(urlApi: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.TrendingTv.rawValue:
            titleRepository.getData(urlApi: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.Popular.rawValue:
            titleRepository.getData(urlApi: "\(Constants.baseURL)//3/movie/popular?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.Upcomming.rawValue:
            titleRepository.getData(urlApi: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.TopRaced.rawValue:
            titleRepository.getData(urlApi: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        default:
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
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .red
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(numberHeightForRowAt)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(numberOfSelection)
    }
}
