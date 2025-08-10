# CryptoTask 📱

An elegant iOS cryptocurrency portfolio and exchange application crafted with SwiftUI, featuring a sophisticated dark theme and intuitive user experience for crypto enthusiasts.

## 📱 App Preview

### 🎥 Demo Video
https://github.com/user-attachments/assets/46de2359-324c-486a-bace-19a01785e48a

## ✨ Core Capabilities

### 🏦 Portfolio Management
- **Real-time Portfolio Tracking**: Live portfolio value monitoring with elegant currency formatting
- **Performance Analytics**: Individual cryptocurrency performance cards with detailed metrics
- **Transaction History**: Comprehensive transaction tracking with visual status indicators
- **Custom Chart Integration**: Interactive charts with touch-responsive data visualization

### 📈 Advanced Analytics
- **Interactive Charting**: Custom-built chart components with smooth touch interactions
- **Multi-timeframe Analysis**: Flexible time range selection (1d, 1w, 1m, 3m, 6m, 1y)
- **Portfolio Insights**: Detailed analytics dashboard with performance metrics
- **Recent Activity Tracking**: Real-time transaction monitoring and history

### 💰 Exchange Operations
- **Balance Management**: Comprehensive balance display with change indicators
- **Quick Actions**: Streamlined send/receive functionality with intuitive controls
- **Transaction Processing**: Complete transaction management and tracking system
- **Exchange History**: Detailed activity logs with transaction categorization

### 🎨 Premium Design System
- **Dark Theme Excellence**: Sophisticated black background with premium gradient accents
- **Fluid Animations**: Seamless transitions and micro-interactions throughout the app
- **Custom UI Components**: Purpose-built components optimized for cryptocurrency workflows
- **Modern iOS Design**: Following Apple's latest design guidelines and best practices

## 🚀 Quick Start Guide

### System Requirements
- **Development Environment**: Xcode 16.3+ (Latest version strongly recommended)
- **Target Platform**: iOS 18.4+ (Minimum deployment target)
- **Host System**: macOS (Required for iOS development)
- **Testing**: Apple Developer Account (Required for physical device testing)

### Getting Started

**Step 1: Repository Setup**
```bash
git clone https://github.com/ilakshaygupt/CryptoPortfolio-Swift
cd CryptoTask
```

**Step 2: Launch Development Environment**
```bash
open CryptoTask.xcodeproj
```

**Step 3: Dependency Resolution**
- Swift Package Manager handles all dependencies automatically
- Primary dependency: **NavKit** (v1.0.4) for advanced navigation
- All packages resolve automatically upon project opening

**Step 4: Build & Deploy**
- Select your preferred target (iPhone Simulator or physical device)
- Execute build: `Cmd + R` or use the Run button
- Application should compile and launch successfully

## 🏗️ Architecture Overview

### Project Organization
```
CryptoTask/
├── 📱 App/
│   └── CryptoTaskApp.swift          # Application entry point & configuration
├── 🗂️ Models/
│   ├── Transaction.swift            # Core transaction data structures
│   ├── ExchangeTransaction.swift    # Exchange-specific transaction models
│   └── AppTheme.swift              # Centralized theme & styling system
├── 🧠 ViewModels/
│   ├── MainViewModel.swift          # Primary application state management
│   ├── ChartViewModel.swift         # Chart data processing & interactions
│   ├── ExchangeViewModel.swift      # Exchange operations & logic
│   ├── PortfolioViewModel.swift     # Portfolio data management
│   └── TransactionViewModel.swift   # Transaction processing & history
├── 🎨 Views/
│   ├── MainView.swift              # Main application container
│   ├── ChartView.swift             # Interactive charting component
│   ├── ExchangeScreen.swift        # Exchange interface & controls
│   ├── PortfolioHeaderView.swift   # Portfolio overview dashboard
│   ├── BottomNavBar.swift          # Navigation system
│   └── [Additional UI Components...]
└── 🎭 Assets.xcassets/             # Visual assets & color definitions
```

### Navigation Structure
- **Analytics Hub**: Portfolio overview with interactive data visualization
- **Exchange Center**: Balance management and transaction processing
- **Record Keeper**: Transaction logging interface (development in progress)
- **Wallet Manager**: Digital wallet management (development in progress)


<img width="237" height="515" alt="Screenshot 2025-08-08 at 10 23 57 PM" src="https://github.com/user-attachments/assets/03dcc4f1-aa4e-44cb-94fd-41f7e3fb5fd3" />
<img width="245" height="517" alt="Screenshot 2025-08-08 at 10 24 53 PM" src="https://github.com/user-attachments/assets/4a804d8a-d508-40ac-8421-96edbddcf85b" />
<img width="236" height="509" alt="Screenshot 2025-08-08 at 10 25 22 PM" src="https://github.com/user-attachments/assets/a090357e-aa0b-456b-9fea-78d8137be07a" />
<img width="245" height="516" alt="Screenshot 2025-08-08 at 10 24 25 PM" src="https://github.com/user-attachments/assets/c575300c-9d5e-4b15-8930-ef2250fe4d8e" />
<img width="240" height="515" alt="Screenshot 2025-08-08 at 10 23 17 PM" src="https://github.com/user-attachments/assets/926d0325-c645-47d0-8406-b38c8084081e" />
<img width="242" height="517" alt="Screenshot 2025-08-08 at 10 24 42 PM" src="https://github.com/user-attachments/assets/752aa52b-fd28-48cc-a587-d7df1acc0df9" />
<img width="241" height="517" alt="Screenshot 2025-08-08 at 10 24 11 PM" src="https://github.com/user-attachments/assets/1325bdd7-b2df-411c-9bbd-8945455bb163" />
<img width="247" height="519" alt="Screenshot 2025-08-08 at 10 23 43 PM" src="https://github.com/user-attachments/assets/99b35b09-4277-4b3e-bd39-dd5838abb767" />


#### 🟢 Future Enhancements
6. **Advanced Trading Features**
   - Direct trading functionality integration
   - Cryptocurrency news feed integration
   - Social trading features and community aspects
   - Professional-grade charting tools and technical indicators

## 🔧 Troubleshooting Guide

### Development Issues

**Build Configuration Problems**
- Verify Xcode version meets minimum requirement (16.3+)
- Execute clean build: `Cmd + Shift + K`
- Reset all package caches via Xcode preferences

**Dependency Resolution Failures**
- Remove `DerivedData` folder completely
- Navigate to File → Packages → Reset Package Caches
- Perform complete project rebuild

**Simulator Performance Issues**
- Reset simulator: Device → Erase All Content and Settings
- Test with multiple iOS simulator versions
- Verify adequate system resources availability

> **Development Note**: CryptoTask represents a demonstration of advanced SwiftUI development capabilities and modern iOS application architecture patterns. Production deployment would require additional security hardening, comprehensive testing suites.