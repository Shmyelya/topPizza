//
//  MainView.swift
//  TopPizza
//
//  Created by Yelzhan Yelikbaev on 25.07.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var presenter: MainPresenter
    @State private var selectedCategoryID: String?
    @State private var selectedCity = "Москва"
    
    private let cities = ["Москва", "Санкт-Петербург", "Казань"]

    @MainActor
    init() {
        _presenter = StateObject(wrappedValue: MainPresenter())
    }

    init(presenterForPreview: MainPresenter) {
        _presenter = StateObject(wrappedValue: presenterForPreview)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                bannersView
                    .padding(.vertical)
                
                Group {
                    if let viewModel = presenter.viewModel {
                        contentView(for: viewModel)
                    } else if presenter.isLoading {
                        loadingView
                    } else if let errorMessage = presenter.errorMessage {
                        errorView(message: errorMessage)
                    }
                }
            }
            .navigationTitle("Меню")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { cityMenuToolbar }
        }
        .task {
            if presenter.viewModel == nil {
                await presenter.fetchMenu()
                selectedCategoryID = presenter.viewModel?.categories.first?.id
            }
        }
    }
}

// MARK: - Private UI Components
private extension MainView {
    
    var bannersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Image("Bunner1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .cornerRadius(12)
                Image("Bunner1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
    }
    
    func contentView(for viewModel: MainViewModel) -> some View {
        ScrollViewReader { scrollProxy in
            VStack(spacing: 0) {
                categoriesBarView(viewModel: viewModel, scrollProxy: scrollProxy)
                    .padding(.bottom, 10)
                
                ScrollView {
                    menuListView(viewModel: viewModel)
                }
            }
        }
    }
    
    func categoriesBarView(viewModel: MainViewModel, scrollProxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.categories) { category in
                    Button(action: {
                        selectedCategoryID = category.id
                        withAnimation {
                            scrollProxy.scrollTo(category.id, anchor: .top)
                        }
                    }) {
                        Text(category.name)
                            .font(.subheadline)
                            .fontWeight(selectedCategoryID == category.id ? .bold : .regular)
                            .foregroundColor(selectedCategoryID == category.id ? .white : .pink)
                            .padding(.horizontal, 18)
                            .frame(height: 36)
                            // This block is now restored to your original style
                            .background(selectedCategoryID == category.id ? Color.pink : Color.pink.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    func menuListView(viewModel: MainViewModel) -> some View {
        LazyVStack(spacing: 0) {
            ForEach(viewModel.categories) { category in
                if !category.items.isEmpty {
                    Section {
                        ForEach(category.items) { item in
                            MenuItemRowView(item: item)
                                .padding(.bottom)
                        }
                    } header: {
                        Text(category.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.background)
                    }
                    .id(category.id)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    func errorView(message: String) -> some View {
        Text(message)
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(12)
    }
    
    var cityMenuToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Menu {
                ForEach(cities, id: \.self) { city in
                    Button(city) {
                        selectedCity = city
                    }
                }
            } label: {
                HStack {
                    Text(selectedCity)
                    Image(systemName: "chevron.down")
                }
                .font(.subheadline)
                .foregroundColor(.primary)
            }
        }
    }
}
    
#Preview {
    let sampleItems = [
        PizzaMenuItem(id: "p1", name: "Пепперони", thumbnail: "", description: "...", price: 10.0),
        PizzaMenuItem(id: "p2", name: "Маргарита", thumbnail: "", description: "...", price: 12.0)
    ]
    let sampleCategories = [
        MenuCategory(id: "c1", name: "Пицца", thumbnail: "", items: sampleItems),
        MenuCategory(id: "c2", name: "Закуски", thumbnail: "", items: [])
    ]
    let sampleViewModel = MainViewModel(categories: sampleCategories)
    let stubbedPresenter = MainPresenter(stubbedViewModel: sampleViewModel)
    return MainView(presenterForPreview: stubbedPresenter)
}
