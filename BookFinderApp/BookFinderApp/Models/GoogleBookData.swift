//
//  GoogleBookData.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation

// MARK: - GoogleBookData
struct GoogleBookData {
    let id: String
    let kind, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
}

// MARK: - AccessInfo
struct AccessInfo {
    let country, viewability: String
    let embeddable, publicDomain: Bool
    let textToSpeechPermission: String
    let epub: Epub
    let pdf: PDF
    let accessViewStatus: String
}

// MARK: - Epub
struct Epub {
    let isAvailable: Bool
    let acsTokenLink: String
}

// MARK: - PDF
struct PDF {
    let isAvailable: Bool
}

// MARK: - SaleInfo
struct SaleInfo {
    let country, saleability: String
    let isEbook: Bool
    let listPrice, retailPrice: Price
    let buyLink: String
}

// MARK: - Price
struct Price {
    let amount: Double
    let currencyCode: String
}

// MARK: - VolumeInfo
struct VolumeInfo {
    let title: String
    let authors: [String]
    let publisher, publishedDate, volumeInfoDescription: String
    let industryIdentifiers: [IndustryIdentifier]
    let pageCount: Int
    let dimensions: Dimensions
    let printType, mainCategory: String
    let categories: [String]
    let averageRating: Double
    let ratingsCount: Int
    let contentVersion: String
    let imageLinks: ImageLinks
    let language: String
    let infoLink: String
    let canonicalVolumeLink: String
}

// MARK: - Dimensions
struct Dimensions {
    let height, width, thickness: String
}

// MARK: - ImageLinks
struct ImageLinks {
    let smallThumbnail, thumbnail, small, medium: String
    let large, extraLarge: String
}

// MARK: - IndustryIdentifier
struct IndustryIdentifier {
    let type, identifier: String
}
