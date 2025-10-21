//
//  ContentView.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var price: String = ""
    @State private var description: String = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("New Property Classified")
                        .font(.system(size: DesignMetric.large, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, DesignMetric.extraLarge)
                    XeTextField(title: "Title", text: $title)
                    XeTextField(title: "Location", text: $location)
                    XeTextField(title: "Price", text: $price)
                    XeTextEditor(title: "Description", text: $description)
                }.padding()
            }

            HStack(spacing: 40) {
                XeButton(title: "Submit", color: .green)
                XeButton(title: "Clear", color: .red)
            }
            .padding(.horizontal, DesignMetric.extraLarge)
        }
    }
}

#Preview {
    ContentView()
}
