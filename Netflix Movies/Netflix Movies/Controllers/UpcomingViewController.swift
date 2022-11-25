//
//  UpcomingViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//

import UIKit

final class UpcomingViewController: UIViewController {
    
    let titleRepository = TitleRepository()
    private var listUpcoming: [Title] = [Title]()
    
    private let upcomingTable: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcomming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
    }
    
    private func fetchUpcoming() {
        titleRepository.getData(urlApi: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.listUpcoming = data
                    self.upcomingTable.reloadData()
                }
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUpcoming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listUpcoming[indexPath.row].originalName ?? listUpcoming[indexPath.row].originalTitle ?? "Unkown"
        return cell
    }
}
