import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'data.dart';
import 'project_detail_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _isMobile(BuildContext c) => MediaQuery.of(c).size.width < 768;

  bool _isTablet(BuildContext c) => MediaQuery.of(c).size.width >= 768 && MediaQuery.of(c).size.width < 1100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Stack(
        children: [
          // Background gradient decoration
          Positioned.fill(child: _BackgroundDecoration()),
          // Main scroll content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _NavBar(
                  onAbout: () => _scrollTo(_aboutKey),
                  onProjects: () => _scrollTo(_projectsKey),
                  onSkills: () => _scrollTo(_skillsKey),
                  onContact: () => _scrollTo(_contactKey),
                ),
                _HeroSection(onCtaPressed: () => _scrollTo(_projectsKey)),
                _AboutSection(key: _aboutKey),
                _ProjectsSection(key: _projectsKey),
                _SkillsSection(key: _skillsKey),
                _ContactSection(key: _contactKey),
                _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Background ambient decoration
// ============================================================
class _BackgroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Subtle radial glow top-left
        Positioned(
          top: -200,
          left: -200,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.accentBlue.withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -300,
          right: -200,
          child: Container(
            width: 700,
            height: 700,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.accentPurple.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// Navigation Bar
// ============================================================
class _NavBar extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onProjects;
  final VoidCallback onSkills;
  final VoidCallback onContact;

  const _NavBar({
    required this.onAbout,
    required this.onProjects,
    required this.onSkills,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.bgDark.withValues(alpha: 0.7),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.accentBlue, AppTheme.accentPurple],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isMobile ? 'A. Yukrisna' : 'Achmad Yukrisna',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          if (!isMobile)
            Row(
              children: [
                _NavLink(label: 'About', onTap: onAbout),
                _NavLink(label: 'Projects', onTap: onProjects),
                _NavLink(label: 'Skills', onTap: onSkills),
                _NavLink(label: 'Contact', onTap: onContact),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppTheme.bgCard,
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _MobileNavLink(
                            label: 'About',
                            onTap: () {
                              Navigator.pop(context);
                              onAbout();
                            }),
                        _MobileNavLink(
                            label: 'Projects',
                            onTap: () {
                              Navigator.pop(context);
                              onProjects();
                            }),
                        _MobileNavLink(
                            label: 'Skills',
                            onTap: () {
                              Navigator.pop(context);
                              onSkills();
                            }),
                        _MobileNavLink(
                            label: 'Contact',
                            onTap: () {
                              Navigator.pop(context);
                              onContact();
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovering ? AppTheme.accentBlue : AppTheme.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MobileNavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      onTap: onTap,
    );
  }
}

// ============================================================
// Hero Section
// ============================================================
class _HeroSection extends StatelessWidget {
  final VoidCallback onCtaPressed;

  const _HeroSection({required this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: isMobile ? 60 : 120,
      ),
      constraints: const BoxConstraints(maxWidth: 1400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A4D2E).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF4ADB7B).withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ADB7B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Open to Remote Roles · SG / AU / JP / US',
                  style: TextStyle(
                    color: const Color(0xFF4ADB7B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

          const SizedBox(height: 32),

          // Main headline
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                AppTheme.textPrimary,
                AppTheme.accentBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'Mobile apps that\ntalk to hardware.',
              style: (isMobile ? Theme.of(context).textTheme.displayMedium : Theme.of(context).textTheme.displayLarge)?.copyWith(
                color: Colors.white,
              ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // Subhead
          Container(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              "I'm Achmad Yukrisna — a Mobile Engineer with 5+ years building Flutter, Kotlin, and Swift apps that bridge complex hardware (BLE, industrial RFID, POS, IoT) with scalable software. Background in Electrical Engineering from ITS. Currently shipping for clients across Singapore, Indonesia, and the USA.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 16 : 18,
                  ),
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

          const SizedBox(height: 40),

          // CTAs
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _PrimaryButton(
                label: 'View My Work',
                icon: Icons.arrow_forward_rounded,
                onPressed: onCtaPressed,
              ),
              _SecondaryButton(
                label: 'Get in Touch',
                icon: Icons.mail_outline_rounded,
                onPressed: () => _launchURL('mailto:achmad.yukrisna@gmail.com'),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 600.ms),

          const SizedBox(height: 56),

          // Quick stats
          Wrap(
            spacing: 48,
            runSpacing: 24,
            children: const [
              _StatItem(value: '5+', label: 'Years experience'),
              _StatItem(value: '12+', label: 'Projects shipped'),
              _StatItem(value: '50K+', label: 'End users reached'),
              _StatItem(value: '4.5★', label: 'Avg store rating'),
            ],
          ).animate().fadeIn(duration: 800.ms, delay: 800.ms),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [AppTheme.accentBlue, AppTheme.accentPurple],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
              ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textTertiary,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// About Section
// ============================================================
class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'About'),
          const SizedBox(height: 16),
          Text(
            'Empowering the world\nthrough mobile innovation.',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 32 : 44,
                ),
          ),
          const SizedBox(height: 32),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile applications have evolved from simple tools into essential ecosystems that shape our daily lives — bridging distances, simplifying complex tasks, and democratizing access to information.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  "As a dedicated engineer, my mission is to build robust, user-centric applications that solve real-world problems — whether it's connecting IoT devices in a smart stadium or streamlining healthcare workflows. I focus on creating accessible technology that helps users navigate the digital world with confidence and ease.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCard.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.borderColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppTheme.accentBlue, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Engineering Edge',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Bachelor's in Electrical Engineering from Institut Teknologi Sepuluh Nopember (ITS) — which gives me a working understanding of the hardware I integrate with, not just the SDK layer on top. I read datasheets, debug with a multimeter, and write production code.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Projects Section
// ============================================================
class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1100;

    final featured = kProjects.where((p) => p.featured).toList();
    final others = kProjects.where((p) => !p.featured).toList();

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'Featured Work'),
          const SizedBox(height: 16),
          Text(
            'Hardware integration\nat scale.',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 32 : 44,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'Projects where mobile meets industrial hardware — RFID handhelds, BLE gateways, IoT ecosystems. The differentiator: bridging native SDKs with cross-platform UI through method channels.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 48),

          // Featured projects — bigger cards
          ...featured.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _FeaturedProjectCard(project: p),
              )),

          const SizedBox(height: 48),

          // All other projects header
          _SectionLabel(text: 'More Work'),
          const SizedBox(height: 16),
          Text(
            'Across industries.',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: isMobile ? 28 : 36,
                ),
          ),
          const SizedBox(height: 32),

          // Other projects grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.4 : 1.0,
            ),
            itemCount: others.length,
            itemBuilder: (_, i) => _ProjectCard(project: others[i]),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatefulWidget {
  final Project project;

  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => ProjectDetailDialog.show(context, widget.project),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovering ? widget.project.gradient[0].withValues(alpha: 0.5) : AppTheme.borderColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 24 : 36),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon block
                Container(
                  width: isMobile ? double.infinity : 200,
                  height: isMobile ? 140 : 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.project.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // child: Icon(
                  //   widget.project.icon,
                  //   color: Colors.white,
                  //   size: 64,
                  // ),
                  child: widget.project.iconImage != ''
                      ? Image.asset(
                    widget.project.iconImage,
                    fit: BoxFit.fill,
                    frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                      // If the image was loaded synchronously (e.g. cached or very fast), just show it.
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      // While frame is null, the image is still loading.
                      if (frame == null) {
                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                              ),
                            ),
                          ),
                        );
                      }
                      // Once frame is available, show the image with a fade in.
                      return AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(milliseconds: 300),
                        child: child,
                      );
                    },
                  )
                      : Icon(
                    widget.project.icon,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 36, height: isMobile ? 24 : 0),
                // Content
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.project.gradient[0].withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.project.category.toUpperCase(),
                              style: TextStyle(
                                color: widget.project.gradient[0],
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // "View details" hint on hover
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _hovering ? 1.0 : 0.0,
                            child: Row(
                              children: [
                                Text(
                                  'View details',
                                  style: TextStyle(
                                    color: widget.project.gradient[0],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_outward_rounded,
                                  color: widget.project.gradient[0],
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.project.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.project.subtitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textTertiary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.project.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      // Tech stack chips (preview — first 5)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.techStack.take(5).map((t) => _TechChip(label: t)).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Impact bullets (preview — first 2)
                      ...widget.project.impact.take(2).map(
                            (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle_rounded, size: 16, color: widget.project.gradient[0]),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      i,
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => ProjectDetailDialog.show(context, widget.project),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0.0, _hovering ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering ? widget.project.gradient[0].withValues(alpha: 0.5) : AppTheme.borderColor.withValues(alpha: 0.4),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: widget.project.gradient),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.project.icon, color: Colors.white, size: 28),
                  ),
                  const Spacer(),
                  // "Open" indicator on hover
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _hovering ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.project.gradient[0].withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        color: widget.project.gradient[0],
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.project.category.toUpperCase(),
                style: TextStyle(
                  color: widget.project.gradient[0],
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.project.title,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                widget.project.subtitle,
                style: TextStyle(
                  color: AppTheme.textTertiary,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Text(
                  widget.project.description,
                  style: TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.bolt_rounded, size: 14, color: AppTheme.textTertiary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.project.impact.first,
                      style: TextStyle(
                        color: AppTheme.textTertiary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.bgElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ============================================================
// Skills Section
// ============================================================
class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1100;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'Tech Stack'),
          const SizedBox(height: 16),
          Text(
            'What I build with.',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 32 : 44,
                ),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 2.2 : 1.1,
            ),
            itemCount: kSkills.length,
            itemBuilder: (_, i) {
              final entry = kSkills.entries.elementAt(i);
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.borderColor.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.accentBlue,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: entry.value.map((s) => _TechChip(label: s)).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Contact Section
// ============================================================
class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 80,
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 56),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.accentBlue.withValues(alpha: 0.15),
              AppTheme.accentPurple.withValues(alpha: 0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.accentBlue.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(text: 'Contact'),
            const SizedBox(height: 16),
            Text(
              "Let's build something.",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 32 : 48,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'Open to senior remote roles, contract engagements, or interesting collaborations — especially anything involving mobile + hardware integration.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 36),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ContactButton(
                  icon: Icons.mail_outline_rounded,
                  label: 'Email',
                  value: 'achmad.yukrisna@gmail.com',
                  onTap: () => _launchURL('mailto:achmad.yukrisna@gmail.com'),
                ),
                _ContactButton(
                  icon: Icons.phone_outlined,
                  label: 'WhatsApp',
                  value: '+62 857-3634-3719',
                  onTap: () => _launchURL('https://wa.me/6285736343719'),
                ),
                _ContactButton(
                  icon: Icons.business_center_outlined,
                  label: 'LinkedIn',
                  value: 'achmadyukrisna',
                  onTap: () => _launchURL('https://www.linkedin.com/in/achmadyukrisna'),
                ),
                _ContactButton(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: 'Kediri, East Java · Remote-friendly',
                  onTap: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _hovering ? AppTheme.bgElevated : AppTheme.bgCard.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering ? AppTheme.accentBlue.withValues(alpha: 0.6) : AppTheme.borderColor.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppTheme.accentBlue, size: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Footer
// ============================================================
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderColor.withValues(alpha: 0.4)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026 Achmad Yukrisna A.',
            style: TextStyle(
              color: AppTheme.textTertiary,
              fontSize: 12,
            ),
          ),
          Text(
            'Built with Flutter Web',
            style: TextStyle(
              color: AppTheme.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Shared widgets
// ============================================================
class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accentBlue, AppTheme.accentPurple],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovering ? [AppTheme.accentPurple, AppTheme.accentBlue] : [AppTheme.accentBlue, AppTheme.accentPurple],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppTheme.accentBlue.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(widget.icon, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovering ? AppTheme.bgElevated : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovering ? AppTheme.accentBlue : AppTheme.borderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppTheme.textPrimary, size: 18),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Helpers
// ============================================================
Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
