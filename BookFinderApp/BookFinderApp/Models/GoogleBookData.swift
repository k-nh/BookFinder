//
//  GoogleBookData.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation

// MARK: - GoogleBookData
struct GoogleBookData: Codable {
    let kind: String?
    let totalItems: Int?
    let items: [Item]?
    
    func toDomain() -> DisplayedBookData {
        return DisplayedBookData(
            totalItemCount: totalItems ?? 0,
            books: items?.map { item in
                item.toDomain()
            })
    }
}

// MARK: - Item
struct Item: Codable {
    let kind, id, etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
    let searchInfo: SearchInfo?
    
    func toDomain() -> Book {
        return Book(
            title: volumeInfo?.title ?? "",
            authors: volumeInfo?.authors ?? [],
            description: volumeInfo?.volumeInfoDescription ?? "",
            thumbnailURL: volumeInfo?.imageLinks?.thumbnail ?? "",
            infoLink: volumeInfo?.infoLink ?? "",
            publishedDate: volumeInfo?.publishedDate ?? ""
        )
    }
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, volumeInfoDescription: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let comicsContent: Bool?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    let seriesInfo: SeriesInfo?
    let publishedDate: String?

    enum CodingKeys: String, CodingKey {
        case title, authors, publisher
        case volumeInfoDescription = "description"
        case industryIdentifiers, readingModes, pageCount, printType, categories, maturityRating, allowAnonLogging, contentVersion, panelizationSummary, comicsContent, imageLinks, language, previewLink, infoLink, canonicalVolumeLink, seriesInfo, publishedDate
    }
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let country, viewability: String?
    let embeddable, publicDomain: Bool?
    let textToSpeechPermission: String?
    let epub: Epub?
    let pdf: PDF?
    let webReaderLink: String?
    let accessViewStatus: String?
    let quoteSharingAllowed: Bool?
}

// MARK: - Epub
struct Epub: Codable {
    let isAvailable: Bool?
}

// MARK: - PDF
struct PDF: Codable {
    let isAvailable: Bool?
    let acsTokenLink: String?
}

// MARK: - SaleInfo
struct SaleInfo: Codable {
    let country, saleability: String?
    let isEbook: Bool?
    let listPrice, retailPrice: SaleInfoListPrice?
    let buyLink: String?
    let offers: [Offer]?
}

// MARK: - SaleInfoListPrice
struct SaleInfoListPrice: Codable {
    let amount: Int?
    let currencyCode: String?
}

// MARK: - Offer
struct Offer: Codable {
    let finskyOfferType: Int?
    let listPrice, retailPrice: OfferListPrice?
}

// MARK: - OfferListPrice
struct OfferListPrice: Codable {
    let amountInMicros: Int?
    let currencyCode: String?
}

// MARK: - SearchInfo
struct SearchInfo: Codable {
    let textSnippet: String?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}

// MARK: - IndustryIdentifier
struct IndustryIdentifier: Codable {
    let type, identifier: String?
}

// MARK: - PanelizationSummary
struct PanelizationSummary: Codable {
    let containsEpubBubbles, containsImageBubbles: Bool?
}

// MARK: - ReadingModes
struct ReadingModes: Codable {
    let text, image: Bool?
}

// MARK: - SeriesInfo
struct SeriesInfo: Codable {
    let kind, bookDisplayNumber: String?
    let volumeSeries: [VolumeSery]?
}

// MARK: - VolumeSery
struct VolumeSery: Codable {
    let seriesID, seriesBookType: String?
    let orderNumber: Int?

    enum CodingKeys: String, CodingKey {
        case seriesID = "seriesId"
        case seriesBookType, orderNumber
    }
}
