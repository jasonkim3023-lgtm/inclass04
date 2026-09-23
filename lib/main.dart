// Team Name: Jason Kim Solo
// Team Members:
// - Jason Kim | 002568176

import 'package:flutter/material.dart';

void main() {
  runApp(const ViralContentApp());
}

class ViralContentApp extends StatefulWidget {
  const ViralContentApp({super.key});

  @override
  State<ViralContentApp> createState() => _ViralContentAppState();
}

class _ViralContentAppState extends State<ViralContentApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viral Content Studio',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: ViralContentStudio(
        isDark: isDarkMode,
        onToggleTheme: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class ViralContentStudio extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ViralContentStudio({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ViralContentStudio> createState() => _ViralContentStudioState();
}

class _ViralContentStudioState extends State<ViralContentStudio> {
  int likes = 0;
  int comments = 0;
  int shares = 0;
  int saves = 0;
  int streak = 0;
  bool isTrending = false;

  void _addLike() {
    setState(() {
      likes++;
      _checkTrending();
    });
  }

  void _addComment() {
    setState(() {
      comments++;
      streak++;
      _checkTrending();
    });
  }

  void _addShare() {
    setState(() {
      shares++;
      streak++;
      _checkTrending();
    });
  }

  void _addSave() {
    setState(() {
      saves++;
      _checkTrending();
    });
  }

  void _checkTrending() {
    int totalEngagement = likes + (comments * 2) + (shares * 3) + (saves * 2);
    isTrending = totalEngagement >= 20;
  }

  int getTotalEngagement() {
    return likes + (comments * 2) + (shares * 3) + (saves * 2);
  }

  @override
  Widget build(BuildContext context) {
    final screenBg = widget.isDark
        ? const Color(0xFF0A0E27)
        : const Color(0xFFF5F5F5);
    final cardBg = widget.isDark ? const Color(0xFF1A1F3A) : Colors.white;
    final trendingBg = isTrending
        ? (widget.isDark ? const Color(0xFF2A1F1A) : const Color(0xFFFFF3E0))
        : screenBg;

    return Scaffold(
      backgroundColor: isTrending ? trendingBg : screenBg,
      appBar: AppBar(
        title: const Text(
          "📱 VIRAL CONTENT STUDIO",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Trending Banner
            if (isTrending)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.local_fire_department,
                      size: 28,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "TRENDING 🔥",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            if (isTrending) const SizedBox(height: 20),

            // Post Card
            PostCard(isDark: widget.isDark),
            const SizedBox(height: 28),

            // Engagement Metrics
            EngagementMetrics(
              likes: likes,
              comments: comments,
              shares: shares,
              saves: saves,
              isDark: widget.isDark,
            ),
            const SizedBox(height: 28),

            // Engagement Progress Bar
            Text(
              "Engagement Score: ${getTotalEngagement()} / 20",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (getTotalEngagement() / 20).clamp(0.0, 1.0),
                minHeight: 12,
                backgroundColor: Colors.grey.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isTrending ? Colors.orange : Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Streak Counter
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(widget.isDark ? 0.3 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Engagement Streak",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$streak",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Interactive Buttons
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                EngagementButton(
                  icon: Icons.favorite,
                  label: "LIKE",
                  accentColor: Colors.redAccent,
                  isDark: widget.isDark,
                  onPressed: _addLike,
                ),
                EngagementButton(
                  icon: Icons.comment,
                  label: "COMMENT",
                  accentColor: Colors.blueAccent,
                  isDark: widget.isDark,
                  onPressed: _addComment,
                ),
                EngagementButton(
                  icon: Icons.share,
                  label: "SHARE",
                  accentColor: Colors.greenAccent,
                  isDark: widget.isDark,
                  onPressed: _addShare,
                ),
                EngagementButton(
                  icon: Icons.bookmark,
                  label: "SAVE",
                  accentColor: Colors.yellowAccent,
                  isDark: widget.isDark,
                  onPressed: _addSave,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless Widget: Post Card Display
class PostCard extends StatelessWidget {
  final bool isDark;

  const PostCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1A1F3A) : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "@Creator",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    "2 hours ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade400, Colors.purple.shade600],
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 80, color: Colors.white30),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Check out this amazing content! 🚀 #viral #trending",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Stateless Widget: Engagement Metrics
class EngagementMetrics extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final bool isDark;

  const EngagementMetrics({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1A1F3A) : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MetricColumn(label: "Likes", value: likes, color: Colors.redAccent),
          _MetricColumn(
            label: "Comments",
            value: comments,
            color: Colors.blueAccent,
          ),
          _MetricColumn(
            label: "Shares",
            value: shares,
            color: Colors.greenAccent,
          ),
          _MetricColumn(
            label: "Saves",
            value: saves,
            color: Colors.yellowAccent,
          ),
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _MetricColumn({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.trending_up, color: color, size: 20),
        const SizedBox(height: 8),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

// Stateful Widget: Engagement Button with Tactile Response
class EngagementButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onPressed;

  const EngagementButton({
    super.key,
    required this.icon,
    required this.label,
    required this.accentColor,
    required this.isDark,
    required this.onPressed,
  });

  @override
  State<EngagementButton> createState() => _EngagementButtonState();
}

class _EngagementButtonState extends State<EngagementButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDark ? const Color(0xFF1A1F3A) : Colors.white;
    final darkShadow = widget.isDark ? Colors.black87 : const Color(0xFFA3B1C6);
    final lightShadow = widget.isDark ? const Color(0xFF2F3244) : Colors.white;

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: darkShadow.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: lightShadow.withOpacity(0.5),
                    offset: const Offset(-2, -2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: darkShadow.withOpacity(0.7),
                    offset: const Offset(8, 8),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: lightShadow.withOpacity(0.9),
                    offset: const Offset(-8, -8),
                    blurRadius: 16,
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: isPressed ? 36 : 42,
              color: isPressed
                  ? widget.accentColor
                  : (widget.isDark ? Colors.white70 : Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 0.8,
                color: isPressed
                    ? widget.accentColor
                    : (widget.isDark ? Colors.white54 : Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
