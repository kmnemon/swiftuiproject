//
//  EditView-ViewModel.swift
//  Bucketlist
//
//  Created by ke on 2024/11/5.
//

import Foundation

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Observable
    class ViewModel {
        enum LoadingState {
            case loading, loaded, failed
        }
        var loadingState = LoadingState.loading

        var location: Location
        var pages = [Page]()

        
        init(location: Location) {
            self.location = location
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}