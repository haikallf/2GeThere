//
//  RefreshableScrollView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 27/03/23.
//

import SwiftUI

public struct RefreshableScrollView<Content: View>: View {
    var content: Content
    var onRefresh: () -> Void

    public init(content: @escaping () -> Content, onRefresh: @escaping () -> Void) {
        self.content = content()
        self.onRefresh = onRefresh
    }

    public var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
        }
        .listStyle(.plain)
        .refreshable {
            onRefresh()
        }
    }
}
