//
//  ContentView.swift
//  BucketList
//
//  Created by Mit Sheth on 2/10/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.339707, longitude: -71.090208 ), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    @State private var viewModel = ViewModel()
    

    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 24, height: 24)
                                    .background(.white)
                                    .clipShape(.capsule)
                                    .onLongPressGesture() {
                                        viewModel.selectedLocation = location
                                    }
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .mapStyle(viewModel.mapMode ? .hybrid(elevation: .realistic) : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedLocation) { place in
                        EditLocation(location: place){
                            viewModel.updateLocation(location: $0)
                            
                        }
                    }
                }
                HStack {
                    Spacer()
                    VStack {
                        Button("Change Map View", action: viewModel.changeMapMode)
                            .font(.callout)
                            .padding()
                            .foregroundStyle(.black)
                            .buttonStyle(.bordered)
                            .controlSize(.small)
                        Spacer()
                        
                    }
                    
                }
            }
            
            
    } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
        
}

#Preview {
    ContentView()
}
