import SwiftUI

struct AppTheme {
    // MARK: - Background Colors
    static var background: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.black
            case .light, .unspecified:
                return UIColor.systemBackground
            @unknown default:
                return UIColor.systemBackground
            }
        })
    }
    
    static var secondaryBackground: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 1.0)
            case .light, .unspecified:
                return UIColor.systemGray6
            @unknown default:
                return UIColor.systemGray6
            }
        })
    }
    
    static var cardBackground: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.black.withAlphaComponent(0.2)
            case .light, .unspecified:
                return UIColor.systemBackground
            @unknown default:
                return UIColor.systemBackground
            }
        })
    }
    
    // MARK: - Text Colors
    static var primaryText: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.white
            case .light, .unspecified:
                return UIColor.label
            @unknown default:
                return UIColor.label
            }
        })
    }
    
    static var secondaryText: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.gray
            case .light, .unspecified:
                return UIColor.secondaryLabel
            @unknown default:
                return UIColor.secondaryLabel
            }
        })
    }
    
    static var mutedText: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.white.withAlphaComponent(0.7)
            case .light, .unspecified:
                return UIColor.secondaryLabel
            @unknown default:
                return UIColor.secondaryLabel
            }
        })
    }
    
    // MARK: - Border Colors
    static var border: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.white.withAlphaComponent(0.15)
            case .light, .unspecified:
                return UIColor.separator
            @unknown default:
                return UIColor.separator
            }
        })
    }
    
    static var cardBorder: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.white.withAlphaComponent(0.15)
            case .light, .unspecified:
                return UIColor.systemGray4
            @unknown default:
                return UIColor.systemGray4
            }
        })
    }
    
    // MARK: - Accent Colors
    static var primaryAccent: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemBlue
            case .light, .unspecified:
                return UIColor.systemBlue
            @unknown default:
                return UIColor.systemBlue
            }
        })
    }
    
    static var secondaryAccent: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(red: 0.3, green: 0.43, blue: 0.96, alpha: 1.0)
            case .light, .unspecified:
                return UIColor.systemBlue
            @unknown default:
                return UIColor.systemBlue
            }
        })
    }
    
    // MARK: - Status Colors
    static var positive: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemGreen
            case .light, .unspecified:
                return UIColor.systemGreen
            @unknown default:
                return UIColor.systemGreen
            }
        })
    }
    
    static var negative: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemRed
            case .light, .unspecified:
                return UIColor.systemRed
            @unknown default:
                return UIColor.systemRed
            }
        })
    }
    
    static var warning: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemOrange
            case .light, .unspecified:
                return UIColor.systemOrange
            @unknown default:
                return UIColor.systemOrange
            }
        })
    }
    
    // MARK: - Gradient Colors
    static var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor(red: 0.3, green: 0.43, blue: 0.96, alpha: 1.0)
                    case .light, .unspecified:
                        return UIColor.systemBlue
                    @unknown default:
                        return UIColor.systemBlue
                    }
                }),
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor(red: 0.21, green: 0.31, blue: 0.78, alpha: 1.0)
                    case .light, .unspecified:
                        return UIColor.systemBlue.withAlphaComponent(0.8)
                    @unknown default:
                        return UIColor.systemBlue.withAlphaComponent(0.8)
                    }
                })
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var secondaryGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor(red: 0.4, green: 0.3, blue: 0.8, alpha: 1.0)
                    case .light, .unspecified:
                        return UIColor.systemPurple
                    @unknown default:
                        return UIColor.systemPurple
                    }
                }),
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1.0)
                    case .light, .unspecified:
                        return UIColor.systemBlue
                    @unknown default:
                        return UIColor.systemBlue
                    }
                })
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var cardGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor.black.withAlphaComponent(0.2)
                    case .light, .unspecified:
                        return UIColor.systemBackground
                    @unknown default:
                        return UIColor.systemBackground
                    }
                }),
                Color(UIColor { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor.black.withAlphaComponent(0.05)
                    case .light, .unspecified:
                        return UIColor.systemGray6
                    @unknown default:
                        return UIColor.systemGray6
                    }
                })
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Material Colors
    static var materialBackground: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemGray6.withAlphaComponent(0.3)
            case .light, .unspecified:
                return UIColor.systemBackground.withAlphaComponent(0.8)
            @unknown default:
                return UIColor.systemBackground.withAlphaComponent(0.8)
            }
        })
    }
    
    // MARK: - Shadow Colors
    static var shadow: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.black.withAlphaComponent(0.3)
            case .light, .unspecified:
                return UIColor.black.withAlphaComponent(0.1)
            @unknown default:
                return UIColor.black.withAlphaComponent(0.1)
            }
        })
    }
    
    static var accentShadow: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.systemBlue.withAlphaComponent(0.3)
            case .light, .unspecified:
                return UIColor.systemBlue.withAlphaComponent(0.2)
            @unknown default:
                return UIColor.systemBlue.withAlphaComponent(0.2)
            }
        })
    }
} 