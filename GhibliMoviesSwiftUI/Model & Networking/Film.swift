//
//  Film.swift
//  GhibliMovies
//
//  Created by Clément Cardonnel on 21/10/2020.
//

import Foundation

/**
 Fillm is the major data structure of the app.
 
 It represents a film, with all its the informations.
 */
struct Film {
    
    let id: String
    
    let title: String
    
    let description: String
    
    let director: String
    
    let producer: String
    
    /// A release date (gregorian year)
    let releaseDate: Int

    var formattedReleaseDate: String? {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: DateComponents(year: releaseDate))?
            .formatted(.dateTime.year())
    }
    
    /// Scrore from 0 to 100
    let score: Int
    
//    let people
    
    let url: URL
    
    var isFavorite: Bool {
        didSet {
            UserDataController.shared.updateFavorite(film: self)
        }
    }
    
    
    
    init(id: String, title: String, description: String, director: String, producer: String, releaseDate: Int, score: Int, url: URL) {
        self.id = id
        self.title = title
        self.description = description
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.score = score
        self.url = url
        self.isFavorite = UserDataController.shared.isFavorite(filmId: id)
    }
    
}



// MARK: - Decodable

extension Film: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case director
        case producer
        case releaseDate = "release_date"
        case score = "rt_score"
        case url
        case people
    }
    
    // Custom decodable implementation that casts some elements to more appropriate Swift types.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the most straightforward values
        let id = try values.decode(String.self, forKey: .id)
        let title = try values.decode(String.self, forKey: .title)
        let director = try values.decode(String.self, forKey: .director)
        let producer = try values.decode(String.self, forKey: .producer)
        let description = try values.decode(String.self, forKey: .description)
        
        // These values first have to be casted to string…
        let stringDate = try values.decode(String.self, forKey: .releaseDate)
        let stringScore = try values.decode(String.self, forKey: .score)
        let stringUrl = try values.decode(String.self, forKey: .url)
        
        // … And then casted to another type.
        if let intDate = Int(stringDate),
           let intScore = Int(stringScore),
           let url = URL(string: stringUrl) {
            let releaseDate = intDate
            let score = intScore
            let url = url
            
            self.init(
                id: id,
                title: title,
                description: description,
                director: director,
                producer: producer,
                releaseDate: releaseDate,
                score: score,
                url: url)
        } else {
            // Something went wrong during the parsing.
            throw GhibliError.failedToParseFilm
        }
    }
    
}



// MARK: - Hashable

extension Film: Hashable {
    
    func hash(into hasher: inout Hasher) {
        // hash value will be exhaustive
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(director)
        hasher.combine(producer)
        hasher.combine(releaseDate)
        hasher.combine(score)
        hasher.combine(url)
        hasher.combine(isFavorite)
    }

    static func == (lhs: Film, rhs: Film) -> Bool {
        // To compare two movies, we only need to check their ids.
        return lhs.id == rhs.id
    }
    
}

// MARK: - Identifiable
extension Film: Identifiable {  }

// MARK: - Preview
extension Film {
    static let preview: Film = {
        Film(id: "0440483e-ca0e-4120-8c50-4c8cd9b965d6",
             title: "Princess Mononoke",
             description: "Ashitaka, a prince of the disappearing Ainu tribe, is cursed by a demonized board god and must journey to the west to find a cure. Along the way, he encounters San, a young human woman fighting to protect the forest, and Lady Eboshi, who is trying to destroy it. Ashitaka must find a way to bring balance to this conflict.",
             director: "Hayao Myazaki",
             producer: "Toshio Suzuki",
             releaseDate: 1997,
             score: 9,
             url: URL(string: "https://www.google.com")!)
    }()
}
