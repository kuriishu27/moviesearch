# Movie Search

![version](https://img.shields.io/badge/swift-iOS-purple.svg?maxAge=2592000)

## Requirements
Build a simple app to fetch a list of movies and implement a search bar to filter by name.
You can use an open API for this or a local JSON file to filter out with the search bar.

![alt text](https://drive.google.com/uc?id=1rxvDTzPWqDlMfBDom9t2qjlpPAherfag)

## MVP Architecture

![alt text](https://drive.google.com/uc?id=1Ov0AKpBEOhrcNnXC1UFknRv9SBZsQxOX)


## API

[OMDb API](http://www.omdbapi.com/) is and open data movies. Due API limitation we dowload several movies searching word = "world". So after do this local implementation we can scale easy to network service

Example of request:
```
http://omdbapi.com/?apikey=[apikey]&s=world
```

## MovieFactory

With this abstraction we can get movies with json file but we can add new implmentations of this protocol from downloading fron network or inject Mocks.

## Movie Presenter

Get movies from repository, show movies in presenter owner (SearchViewcontroller) a filter movies by title
```
protocol MoviesPresenter: class {
  // Presenter Owner <--> Presenter
  func moviesToShow(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
  func filterMovies(filter: String, completion: @escaping ([Movie]) -> Void )
  
  // Presenter <--> Repository
  func getMovies(completion: @escaping (Result<SuccessCode, Error>) -> Void)

}
```

## UI: SearchViewController
Show view and communicate with presenter.

- [kingfisher](https://github.com/onevcat/Kingfisher) for image cache.
- Spinner show async interaction.

