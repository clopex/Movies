//
//  ViewController.swift
//  Movies
//
//  Created by Adis Mulabdic on 12.06.2021..
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel  = MovieViewModel.build()
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        startActivityIndicator(style: .large, location: nil, color: .magenta)
        title = "Movies"
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    private func setupTableView() {
        tableView.registerCell(ofType: MovieCell.self)
        tableView.contentInset.top = 60
        let bgView = UIView()
        bgView.backgroundColor = .clear
        tableView.backgroundView = bgView
    }
    
    private func getMovies(_ page: Int) {
        startActivityIndicator()
        viewModel.delegate = self
    }
    
    private func loadMoreData() {
        viewModel.sortTaped = false
        if !viewModel.isLoading {
            viewModel.page = viewModel.page + 1
            viewModel.isLoading = true
            viewModel.fetchMovies()
        }
    }
    
    private func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        if tableView.indexPathExists(indexPath: indexPath) {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                viewModel.movieSort = .topRated
            case 1:
                viewModel.movieSort = .popular
            default: break
        }
    }
}

//MARK: TableView
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: MovieCell.self)
        cell.selectionStyle = .none
        let movie = viewModel.movies[indexPath.row]
        cell.setup(movie)
        
        if indexPath.row == viewModel.movies.count - 1 {
            loadMoreData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let detailVC: MovieDetailsViewController = UIStoryboard.storyboard(.MovieDetail).instantiateViewController()
        detailVC.viewModel.movieId = viewModel.getId(from: row)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.backgroundView?.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

//MARK: Delegates
extension MoviesViewController: MoviesFetchedDelegate {
    func scroll() {
        scrollToTop()
    }
    
    func success(_ message: String?) {
        stopActivityIndicator()
        if let msg = message {
            showAlertDialog(alertText: "Error", alertMessage: msg)
        } else {
            tableView.reloadData()
        }
    }
}
