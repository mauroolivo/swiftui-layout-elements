import SwiftUI

struct Stage0PreviewVariant: Identifiable, Hashable {
    let id: String
    let title: String
    let size: CGSize?
    let dynamicTypeSize: DynamicTypeSize
    let layoutDirection: LayoutDirection

    init(
        _ title: String,
        size: CGSize? = nil,
        dynamicTypeSize: DynamicTypeSize = .large,
        layoutDirection: LayoutDirection = .leftToRight
    ) {
        self.id = title
        self.title = title
        self.size = size
        self.dynamicTypeSize = dynamicTypeSize
        self.layoutDirection = layoutDirection
    }
}

enum Stage0PreviewPresets {
    static let narrow = Stage0PreviewVariant(
        "Narrow",
        size: CGSize(width: 320, height: 640)
    )

    static let standard = Stage0PreviewVariant(
        "Standard",
        size: CGSize(width: 390, height: 844)
    )

    static let wide = Stage0PreviewVariant(
        "Wide",
        size: CGSize(width: 744, height: 780)
    )

    static let portrait = Stage0PreviewVariant(
        "Portrait",
        size: CGSize(width: 390, height: 844)
    )

    static let landscape = Stage0PreviewVariant(
        "Landscape",
        size: CGSize(width: 844, height: 390)
    )

    static let largeDynamicType = Stage0PreviewVariant(
        "Large Type",
        size: CGSize(width: 390, height: 844),
        dynamicTypeSize: .accessibility1
    )

    static let accessibilityDynamicType = Stage0PreviewVariant(
        "Accessibility Type",
        size: CGSize(width: 390, height: 844),
        dynamicTypeSize: .accessibility3
    )

    static let leftToRight = Stage0PreviewVariant(
        "LTR",
        size: CGSize(width: 390, height: 844),
        layoutDirection: .leftToRight
    )

    static let rightToLeft = Stage0PreviewVariant(
        "RTL",
        size: CGSize(width: 390, height: 844),
        layoutDirection: .rightToLeft
    )

    static let showcase: [Stage0PreviewVariant] = [
        narrow,
        standard,
        wide,
        portrait,
        landscape,
        largeDynamicType,
        accessibilityDynamicType,
        leftToRight,
        rightToLeft
    ]
}

struct Stage0PreviewMatrix<Content: View>: View {
    let variants: [Stage0PreviewVariant]
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 16)], spacing: 16) {
                ForEach(variants) { variant in
                    Stage0PreviewVariantCard(variant: variant) {
                        content()
                    }
                }
            }
            .padding(16)
        }
        .background(Color(.systemGroupedBackground))
    }
}

private struct Stage0PreviewVariantCard<Content: View>: View {
    let variant: Stage0PreviewVariant
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(variant.title)
                    .font(.headline)
                Text(details)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }

            Group {
                if let size = variant.size {
                    content()
                        .frame(width: size.width, height: size.height)
                } else {
                    content()
                }
            }
            .environment(\.dynamicTypeSize, variant.dynamicTypeSize)
            .environment(\.layoutDirection, variant.layoutDirection)
            .debugBounds(.pink)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(.pink.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(12)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var details: String {
        var parts: [String] = []
        if let size = variant.size {
            parts.append("\(Int(size.width))×\(Int(size.height))")
        } else {
            parts.append("Flexible size")
        }
        if variant.dynamicTypeSize.isAccessibilitySize {
            parts.append("Accessibility Type")
        } else if variant.dynamicTypeSize > .large {
            parts.append("Large Type")
        } else {
            parts.append("Default Type")
        }
        parts.append(variant.layoutDirection == .rightToLeft ? "RTL" : "LTR")
        return parts.joined(separator: " • ")
    }
}

extension View {
    func debugBounds(_ color: Color = .pink, lineWidth: CGFloat = 1) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(color.opacity(0.7), style: StrokeStyle(lineWidth: lineWidth, dash: [6, 4]))
        )
    }
}

struct Stage0LabCard<Content: View>: View {
    let title: String
    let subtitle: String?
    @ViewBuilder let content: () -> Content

    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            content()
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .debugBounds(.teal)
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.teal.opacity(0.18), lineWidth: 1)
        )
    }
}
