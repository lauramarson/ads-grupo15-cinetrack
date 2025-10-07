//
//  Constants.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI

let baseAPI: String = "http://api.themoviedb.org/3"
let imageAPISmall: String = "https://image.tmdb.org/t/p/w154/"
let imageAPIMedium: String = "https://image.tmdb.org/t/p/w780/"

let token: String = ""

let movieGenres: [Int: String] = [
    28: "Ação",
    12: "Aventura",
    16: "Animação",
    35: "Comédia",
    80: "Crime",
    99: "Documentário",
    18: "Drama",
    10751: "Família",
    14: "Fantasia",
    36: "História",
    27: "Terror",
    10402: "Musical",
    9648: "Mistério",
    10749: "Romance",
    878: "Ficção Científica",
    10770: "Filme para TV",
    53: "Suspense",
    10752: "Guerra",
    37: "Faroeste"
]

let tvGenres: [Int: String] = [
    10759: "Ação e Aventura",
    16: "Animação",
    35: "Comédia",
    80: "Crime",
    99: "Documentário",
    18: "Drama",
    10751: "Família",
    10762: "Infantil",
    9648: "Mistério",
    10763: "Notícias",
    10764: "Reality Show",
    10765: "Ficção Científica e Fantasia",
    10766: "Novela",
    10767: "Talk Show",
    10768: "Guerra e Política",
    37: "Faroeste"
]

#if DEBUG

let batman = Movie(
      adult: false,
      backdropPath: "/z6cCtZmBd37p6XzTsDdO2TGwVhA.jpg",
      genreIds: [35, 28, 80, 12],
      id: 1332473,
      originalLanguage: "en",
      originalTitle: "Batman a Modrý Joker Mají Problém",
      overview: "Batman finally catches The Joker and tries to interrogate him about the dissappearence of Herobrine, but Joker has become a blue lipstick liberal and now Batman has to discover his secrets, accompanied by his new companion - Robin /Terkel! The whole movie is improvized and has been made in less than a week",
      popularity: 0.0975,
      posterPath: "/tnUhWYdmMGkshSX2uqQ82Qm1ENW.jpg",
      releaseDate: "2024-08-17",
      title: "Batman and Blue Joker in Trouble",
      video: false,
      voteAverage: 0,
      voteCount: 0
  )

let batmanVersus = Movie(
      adult: false,
      backdropPath: "/55z9m0roHIVZ4LIe1Y0Zj5G71s5.jpg",
      genreIds: [16],
      id: 978619,
      originalLanguage: "xx",
      originalTitle: "Batman Versus",
      overview: "",
      popularity: 0.0143,
      posterPath: "/fojq0MUMLYzcC2Wi9ogOPQTWRyk.jpg",
      releaseDate: "",
      title: "Batman Versus",
      video: false,
      voteAverage: 0,
      voteCount: 0
  )

let batmanPuppetMaster = Movie(
      adult: false,
      backdropPath: nil,
      genreIds: [28],
      id: 1272910,
      originalLanguage: "es",
      originalTitle: "Batman y el Titiritero",
      overview: "",
      popularity: 0.0734,
      posterPath: "/eu0iistQfM7TjK9FJY2R63lyAhk.jpg",
      releaseDate: "2012-04-10",
      title: "Batman Puppet Master",
      video: false,
      voteAverage: 7,
      voteCount: 1
  )

#endif


// MARK: - UI

extension Color {
    
    static let cellBackground: Color = .gray
    static let background: Color = Color(hex: "01052E")!
    static let softWhite: Color = Color(hex: "F5F5F5")!
    static let buttonBackground: Color = Color(hex: "5108f7")!
    static let pink: Color = Color(hex: "d210f8")!
}

extension Color {
    
    var uiColor: UIColor {
        UIColor(self)
    }
    
}
