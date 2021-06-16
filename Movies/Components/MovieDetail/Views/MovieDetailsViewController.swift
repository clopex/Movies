//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genresStackView: UIStackView!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var similarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MovieDetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchDetails()
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel  = MovieDetailViewModel.build()
        super.init(coder: aDecoder)
    }
    
    func fetchDetails() {
        startActivityIndicator(style: .large, location: nil, color: .black)
        viewModel.delegate = self
        viewModel.getDetails()
        viewModel.fetchSimilarMovies()
    }
    
    func setupCollectionView(){
        let nib = UINib(nibName: "SimilarMovieCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "SimilarMovieCell")
    }
    
    private func setupUI() {
        let coverPath = APIBase.baseImageURL + viewModel.getCoverImagePath()
        coverImage.setThumbnailFrom(coverPath)
        let posterPath = APIBase.baseImageURL + viewModel.getPosterImagePath()
        posterImage.setThumbnailFrom(posterPath)
        movieTitle.text = viewModel.getTitle()
        releaseDate.text = viewModel.getReleaseDate()
        movieOverview.text = viewModel.getOverview()
        for genre in viewModel.getGenres() {
            let genreView: GenreView = .fromNib()
            genreView.genreTitle.text = genre
            genresStackView.addArrangedSubview(genreView)
        }
    }
    
    private func loadMoreData() {
        viewModel.page = viewModel.page + 1
        viewModel.fetchSimilarMovies()
    }
}

//MARK: Delegates 
extension MovieDetailsViewController: DetailMovieDelegate {
    func similar(_ loaded: Bool) {
        if loaded {
            collectionView.reloadData()
            similarView.animateViewWith(alpha: 1)
        }
    }
    
    func completed(_ message: String?) {
        stopActivityIndicator()
        if let msg = message {
            showAlertDialog(alertText: "Error", alertMessage: msg)
        } else {
            setupUI()
        }
    }
}

//MARK: CollectionView
extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMovieCell
        let movie = viewModel.movies[indexPath.row]
        cell.setup(movie)

        if !viewModel.isEndOfPagination() {
            if indexPath.row == viewModel.movies.count - 1 {
                loadMoreData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 110)
    }
}
