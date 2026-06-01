import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme.dart';
import 'data.dart';

class ProjectDetailDialog extends StatelessWidget {
  final Project project;

  const ProjectDetailDialog({super.key, required this.project});

  /// Show this dialog. Use from anywhere with:
  /// `ProjectDetailDialog.show(context, project);`
  static void show(BuildContext context, Project project) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (_) => ProjectDetailDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1100;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 32,
        vertical: isMobile ? 24 : 32,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1100,
          maxHeight: screenSize.height * 0.9,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              border: Border.all(
                color: project.gradient[0].withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                // Main content — adaptive layout
                SingleChildScrollView(
                  child: isMobile || isTablet
                      ? _buildStackedLayout(context)
                      : _buildSplitLayout(context),
                ),
                // Close button overlay
                Positioned(
                  top: 16,
                  right: 16,
                  child: _CloseButton(
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.easeOutCubic,
        );
  }

  // ==========================================================
  // Desktop layout: side-by-side (description left, mockup right)
  // ==========================================================
  Widget _buildSplitLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Left: Description column ===
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(48, 56, 40, 48),
              child: _buildDescription(context),
            ),
          ),
          // === Right: Visual showcase column ===
          Expanded(
            flex: 4,
            child: _VisualShowcase(project: project),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // Mobile/tablet layout: stacked vertically
  // ==========================================================
  Widget _buildStackedLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Visual showcase on top
        SizedBox(
          height: 320,
          child: _VisualShowcase(project: project),
        ),
        // Description below
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
          child: _buildDescription(context),
        ),
      ],
    );
  }

  // ==========================================================
  // Shared description content
  // ==========================================================
  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: project.gradient[0].withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            project.category.toUpperCase(),
            style: TextStyle(
              color: project.gradient[0],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          project.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 6),
        Text(
          project.subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textTertiary,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 24),

        // Description
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 28),

        // Tech stack section
        Text(
          'TECH STACK',
          style: TextStyle(
            color: AppTheme.textTertiary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack
              .map((t) => _TechChip(label: t, color: project.gradient[0]))
              .toList(),
        ),
        const SizedBox(height: 28),

        // Key Impact card — mirrors PDF design
        _KeyImpactCard(
          impacts: project.impact,
          accentColor: project.gradient[0],
        ),
      ],
    );
  }
}

// ============================================================
// Right-side visual showcase (phone mockups + gradient bg)
// ============================================================
class _VisualShowcase extends StatelessWidget {
  final Project project;
  const _VisualShowcase({required this.project});

  @override
  Widget build(BuildContext context) {
    final hasScreenshots = project.screenshots.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            project.gradient[0].withOpacity(0.85),
            project.gradient[1].withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circuit-pattern lines (matches PDF aesthetic)
          Positioned.fill(child: _CircuitDecoration()),

          // Phone mockups — two stacked with slight offset
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: 320,
                height: 420,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back phone (slightly rotated, behind)
                    Positioned(
                      right: 8,
                      top: 12,
                      child: Transform.rotate(
                        angle: 0.04,
                        child: _PhoneFrame(
                          project: project,
                          screenshotPath:
                              hasScreenshots && project.screenshots.length > 1
                                  ? project.screenshots[1]
                                  : null,
                          isBack: true,
                        ),
                      ),
                    ),
                    // Front phone
                    Positioned(
                      left: 8,
                      top: 0,
                      child: Transform.rotate(
                        angle: -0.03,
                        child: _PhoneFrame(
                          project: project,
                          screenshotPath: hasScreenshots
                              ? project.screenshots[0]
                              : null,
                          isBack: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Phone frame mockup — used when no real screenshot or as wrapper
// ============================================================
class _PhoneFrame extends StatelessWidget {
  final Project project;
  final String? screenshotPath;
  final bool isBack;

  const _PhoneFrame({
    required this.project,
    required this.screenshotPath,
    required this.isBack,
  });

  @override
  Widget build(BuildContext context) {
    final width = isBack ? 180.0 : 200.0;
    final height = isBack ? 360.0 : 400.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF2A3B5A),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Screen content
            if (screenshotPath != null)
              Image.asset(
                screenshotPath!,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholderScreen(),
              )
            else
              _buildPlaceholderScreen(),

            // Notch (top center)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 80,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1628),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            project.gradient[0].withOpacity(0.4),
            project.gradient[1].withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              project.icon,
              color: Colors.white.withOpacity(0.9),
              size: 64,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                project.title.split('·').first.trim(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Circuit-pattern decoration (background ambient)
// ============================================================
class _CircuitDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _CircuitPainter(),
      ),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Horizontal lines
    for (int i = 0; i < 8; i++) {
      final y = (size.height / 8) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width * 0.3, y),
        paint,
      );
      canvas.drawLine(
        Offset(size.width * 0.7, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Decorative dots
    final dotPaint = Paint()..color = Colors.white.withOpacity(0.15);
    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(
        Offset(
          (size.width / 12) * i,
          (i % 3 + 1) * (size.height / 5),
        ),
        2,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ============================================================
// Key Impact card (mirrors PDF "Key Impact" section)
// ============================================================
class _KeyImpactCard extends StatelessWidget {
  final List<String> impacts;
  final Color accentColor;

  const _KeyImpactCard({
    required this.impacts,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgElevated.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: accentColor, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bolt_rounded, color: accentColor, size: 18),
              const SizedBox(width: 8),
              Text(
                'Key Impact',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...impacts.asMap().entries.map(
                (entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key == impacts.length - 1 ? 0 : 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

// ============================================================
// Tech stack chip with accent color hover
// ============================================================
class _TechChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TechChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ============================================================
// Close button (X) — top-right of dialog
// ============================================================
class _CloseButton extends StatefulWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _hovering
                ? AppTheme.bgElevated
                : AppTheme.bgCard.withOpacity(0.7),
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovering
                  ? AppTheme.accentBlue.withOpacity(0.5)
                  : AppTheme.borderColor,
            ),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 18,
            color: _hovering ? AppTheme.accentBlue : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
