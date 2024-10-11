import SwiftUI
import AVKit
import PhotosUI
import Foundation
import AVFoundation

enum PersonalizationOption {
    case familyMember, virtualCharacter
}

struct ModelPersonalizationView: View {
    let option: PersonalizationOption
    
    var body: some View {
        Text("Personalizing for: \(option.rawValue)")
        // ... 其余代码 ...
    }
}