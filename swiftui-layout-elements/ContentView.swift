//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header

                Stage0LabCard(
                    title: "Layout probe",
                    subtitle: "A tiny composition for observing the parent → child → parent loop."
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue.gradient)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Image(systemName: "square.grid.2x2")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.white)
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Preview the same composition across different proposals.")
                                    .font(.callout)
                                    .foregroundStyle(.primary)

                                Text("This surface is intentionally simple so the preview matrix can do the heavy lifting.")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer(minLength: 0)
                        }

                        Divider()

                        HStack(spacing: 12) {
                            Label("Bounds", systemImage: "ruler")
                                .font(.footnote.weight(.semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.blue.opacity(0.12), in: Capsule())

                            Label("Diagnostics", systemImage: "waveform.path.ecg")
                                .font(.footnote.weight(.semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.green.opacity(0.12), in: Capsule())

                            Spacer(minLength: 0)
                        }
                    }
                }

                Stage0LabCard(
                    title: "Stage 0 checklist",
                    subtitle: "What this stage should make cheap to reproduce."
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        Stage0ChecklistRow(text: "Narrow, standard, and wide containers")
                        Stage0ChecklistRow(text: "Portrait and landscape")
                        Stage0ChecklistRow(text: "Default, large, and accessibility Dynamic Type")
                        Stage0ChecklistRow(text: "Left-to-right and right-to-left layout")
                    }
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("AdaptiveLayoutLab")
                .font(.largeTitle.bold())

            Text("Stage 0 — Layout laboratory")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.secondary)

            Text("This app starts as a controlled environment for layout experiments. The real work begins in previews, not on the final screen.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 4)
    }
}

private struct Stage0ChecklistRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            Text(text)
                .font(.callout)
            Spacer(minLength: 0)
        }
        .debugBounds(.mint)
    }
}

#Preview {
    ContentView()
}

#Preview("Stage 0 matrix") {
    Stage0PreviewMatrix(variants: Stage0PreviewPresets.showcase) {
        ContentView()
    }
}
