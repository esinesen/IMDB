//
//  UserDataProvider.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation

final class UserDataProvider {

    private let userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults.standard
    }

    func isFavorite(movieId: Int) -> Bool {
        return getFavoriteMovies().contains { $0.id == movieId}
    }

    func addMovieToFavorites(movie: MovieDetailResponse) {
        var favorites = getFavoriteMovies()
        guard !favorites.contains(where: {$0.id == movie.id }) else {return}
        favorites.append(movie)
        saveFavoriteMovies(movies: favorites)
    }

    func removeMovieFromFavorites(movie: MovieDetailResponse) {
        var favorites = getFavoriteMovies()
        guard let indx = favorites.firstIndex(where: {$0.id == movie.id}) else {return}
        favorites.remove(at: indx)
        saveFavoriteMovies(movies: favorites)
    }

    func getFavoriteMovies() -> [MovieDetailResponse] {
        guard let favoritesData = userDefaults.object(forKey: "favoriteMovies") as? Data else {return []}
        let decoder = JSONDecoder()
        guard let favoriteMovies = try? decoder.decode([MovieDetailResponse].self, from: favoritesData) else {return []}
        return favoriteMovies
    }

    private func saveFavoriteMovies(movies: [MovieDetailResponse]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movies) {
            userDefaults.set(encoded, forKey: "favoriteMovies")
        }
    }
}
