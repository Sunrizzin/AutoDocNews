//
//  ItemView.swift
//  AutoDocNews
//
//  Created by Алексей Усанов on 02.02.2023.
//

import SwiftUI

struct ItemView: View {
    var news: News
    var action: () -> Void
    
    @State var open: Bool = false
    
    var body: some View {
        Color.clear.overlay(
            CachedImageImage(url: URL(string: news.titleImageUrl ?? ""), transaction: Transaction(animation: .easeInOut(duration: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .opacity(open ? 0 : 1)
                        .overlay(
                            ZStack {
                                if open {
                                    WebView(url: URL(string: news.fullUrl)!)
                                        .aspectRatio(0.5, contentMode: .fit)
                                } else {
                                    image
                                        .resizable()
                                        .blur(radius: 20)
                                        .scaledToFill()
                                        .clipped()
                                        .mask(gradient)
                                    gradient
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Text(news.title)
                                                .foregroundColor(.white)
                                                .font(.title3)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        HStack(alignment: .bottom) {
                                            Text(news.description)
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                }
                            }
                        )
                case .empty:
                    if let _ = news.titleImageUrl {
                        ProgressView()
                    } else {
                        if open {
                            WebView(url: URL(string: news.fullUrl)!)
                                .aspectRatio(0.5, contentMode: .fit)
                        } else {
                            VStack(alignment: .leading) {
                                Text(news.title)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .multilineTextAlignment(.leading)
                                Text(news.description)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                        }
                    }
                default:
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                }
            }
        )
        .frame(maxWidth: .infinity)
        .aspectRatio(open ? 0.5 : 1.5, contentMode: .fit)
        .onTapGesture {
            withAnimation {
                open.toggle()
                action()
            }
        }
    }
    
    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.5)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(news: Mocks.news, action: {})
    }
}
