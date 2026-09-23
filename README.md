# 📱 Viral Content Simulator (Flutter)

A dynamic social media engagement simulator built with Flutter & Dart, demonstrating state management and tactile micro-interactions.

## ✨ Features
- **Engagement Tracking**: Likes, comments, shares, saves
- **Trending Detection**: "TRENDING 🔥" banner at 20+ engagement points
- **Tactile Buttons**: 3D neomorphic buttons with press feedback
- **Engagement Streak**: Tracks consecutive interactions
- **Adaptive Theme**: Light/Dark mode toggle

## 🛠️ Tech Stack
- **Framework**: Flutter (Material 3)
- **Language**: Dart
- **Key Widgets**: `StatefulWidget`, `StatelessWidget`, `GestureDetector`

## 🎯 Build Challenge (Round 3)

**Theme**: Viral Content Studio

**State Variables**:
- `int likes` — Post likes
- `int comments` — Comments (2 points each)
- `int shares` — Shares (3 points each)
- `int saves` — Saves (2 points each)
- `int streak` — Engagement streak
- `bool isTrending` — Unlocks at 20+ points

**Trending Condition**: `likes + (comments × 2) + (shares × 3) + (saves × 2) ≥ 20`

## 🐛 Bug Hunt (Round 2)

✅ BUG #1: Moved `isPressed` to local button state  
✅ BUG #2: Added `setState()` to slider  
✅ BUG #3: Fixed shadow offsets (pressed: 2,2 / unpressed: 8,8)  
✅ BUG #4: Fixed callback timing  

---

**Team**: Jason Kim 