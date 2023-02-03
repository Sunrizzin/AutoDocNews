//
//  ContentView.swift
//  AutoDocNews
//
//  Created by Алексей Усанов on 02.02.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var model: NewsViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Group {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 300))],
                            spacing: 0
                        ) {
                            ForEach(model.news, id: \.id) { item in
                                ItemView(news: item) {
                                    withAnimation {
                                        proxy.scrollTo(item.id)
                                    }
                                }
                                .id(item.id)
                            }
                        }
                        Button {
                            model.getMore()
                        } label: {
                            Text("Загрузить ещё")
                                .foregroundColor(.red)
                        }
                        
                    }
                }
            }
        }
        .task {
            await self.model.load()
        }
        .alert(model.error, isPresented: $model.errorShow) {
            Button("Обновить", role: .cancel) {
                model.reload()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NewsViewModel())
    }
}
