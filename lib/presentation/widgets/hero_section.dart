import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/portfolio_entities.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.profile,
    required this.onSkills,
  });

  final PortfolioProfile profile;
  final VoidCallback onSkills;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  Timer? _typingTimer;

  int _visibleCharacters = 0;
  bool _typingFinished = false;

  final List<String> _code = const [
    "import 'package:flutter/material.dart';",
    '',
    'class Developer extends StatelessWidget {',
    '  const Developer({super.key});',
    '',
    '  @override',
    '  Widget build(BuildContext context) {',
    '    return const Column(',
    '      children: [',
    '        Text(',
    "          'Building scalable mobile experiences',",
    '        ),',
    '      ],',
    '    );',
    '  }',
    '}',
  ];

  int get _totalCharacters {
    return _code.fold<int>(
      0,
          (total, line) => total + line.length,
    );
  }

  @override
  void initState() {
    super.initState();

    // Controls the subtle floating animation
    // and cursor blinking.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    )..repeat(reverse: true);

    _startTypingAnimation();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================
  // TYPING ANIMATION
  // ============================================================

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(
      const Duration(
        milliseconds: 38,
      ),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_visibleCharacters >= _totalCharacters) {
          timer.cancel();

          setState(() {
            _typingFinished = true;
          });

          return;
        }

        setState(() {
          _visibleCharacters++;
        });
      },
    );
  }

  // ============================================================
  // CONNECT
  // ============================================================

  Future<void> _connect() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: widget.profile.email,
      queryParameters: const {
        'subject': 'Mobile Development Opportunity',
      },
    );

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        _showMessage(
          'Unable to open your email application.',
        );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      _showMessage(
        'Unable to open your email application.',
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        final bool compact =
            constraints.maxWidth < 900;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: compact ? 42 : 78,
          ),
          child: compact
              ? _buildMobile()
              : _buildDesktop(),
        );
      },
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildCopy(),
        ),
        const SizedBox(width: 56),
        Expanded(
          child: _buildCodeCard(),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildCopy(),

        const SizedBox(height: 40),

        _buildCodeCard(),
      ],
    );
  }

  // ============================================================
  // HERO COPY
  // ============================================================

  Widget _buildCopy() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildOnlineBadge(),

        const SizedBox(height: 26),

        Text(
          'Hi, I’m',
          style: Theme.of(context)
              .textTheme
              .headlineLarge,
        ),

        const SizedBox(height: 2),

        _buildName(),

        const SizedBox(height: 12),

        Text(
          widget.profile.role,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          widget.profile.summary,
          style: Theme.of(context)
              .textTheme
              .bodyLarge,
        ),

        const SizedBox(height: 26),

        _buildActions(),

        const SizedBox(height: 24),

        _buildTechnologyChips(),
      ],
    );
  }

  // ============================================================
  // ONLINE BADGE
  // ============================================================

  Widget _buildOnlineBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OnlineIndicator(),

          SizedBox(width: 8),

          Text(
            'MOBILE.DEV  ::  ONLINE',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAME
  // ============================================================

  Widget _buildName() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            AppColors.blue,
            AppColors.cyan,
          ],
        ).createShader(bounds);
      },
      child: Text(
        widget.profile.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 58,
          fontWeight: FontWeight.w900,
          height: 1.05,
          letterSpacing: -1.5,
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================

  Widget _buildActions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilledButton.icon(
          onPressed: widget.onSkills,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(
            Icons.arrow_forward_rounded,
            size: 18,
          ),
          label: const Text(
            'View My Skills',
          ),
        ),
        OutlinedButton.icon(
          onPressed: _connect,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.blue,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            side: BorderSide(
              color: AppColors.blue,
              width: 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(
            Icons.send_rounded,
            size: 18,
            color: AppColors.blue,
          ),
          label: const Text(
            "Let's Connect",
            style: TextStyle(
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
  // ============================================================
  // TECHNOLOGY CHIPS
  // ============================================================

  Widget _buildTechnologyChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.profile.heroTechnologies
          .map(
            (item) {
          return Chip(
            label: Text(item),
          );
        },
      )
          .toList(),
    );
  }

  // ============================================================
  // CODE CARD
  // ============================================================

  Widget _buildCodeCard() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (
          context,
          child,
          ) {
        final double progress =
            _animationController.value;

        final double offset =
            (progress - 0.5) * 8;

        return Transform.translate(
          offset: Offset(
            0,
            offset,
          ),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.cyan.withValues(
              alpha: 0.55,
            ),
            width: 1.4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26147BFF),
              blurRadius: 40,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(22),
          child: Column(
            children: [
              _buildEditorHeader(),

              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE8EDF5),
              ),

              Expanded(
                child: _buildEditorBody(),
              ),

              _buildStatusBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EDITOR HEADER
  // ============================================================

  Widget _buildEditorHeader() {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      color: const Color(0xFFFBFCFE),
      child: Row(
        children: [
          _windowDot(
            const Color(0xFFFF5F57),
          ),

          const SizedBox(width: 7),

          _windowDot(
            const Color(0xFFFFBD2E),
          ),

          const SizedBox(width: 7),

          _windowDot(
            const Color(0xFF28C840),
          ),

          const SizedBox(width: 22),

          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.cyan.withValues(
                  alpha: 0.30,
                ),
              ),
              borderRadius:
              BorderRadius.circular(7),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.code,
                  size: 15,
                  color: AppColors.blue,
                ),

                SizedBox(width: 8),

                Text(
                  'portfolio.dart',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),

                SizedBox(width: 10),

                _EditorTabIndicator(),
              ],
            ),
          ),

          const Spacer(),

          const Icon(
            Icons.more_horiz,
            size: 20,
            color: Color(0xFF98A2B3),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WINDOW DOT
  // ============================================================

  Widget _windowDot(Color color) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // ============================================================
  // EDITOR BODY
  // ============================================================

  Widget _buildEditorBody() {
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        return Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics:
                const ClampingScrollPhysics(),
                padding:
                const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: _buildEditorContent(
                  constraints.maxWidth,
                ),
              ),
            ),

            Positioned(
              right: 7,
              top: 18,
              bottom: 18,
              child: _buildEditorScrollbar(),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EDITOR CONTENT
  // ============================================================

  Widget _buildEditorContent(
      double availableWidth,
      ) {
    final double codeWidth =
    availableWidth > 55
        ? availableWidth - 55
        : 1;

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _buildLineNumbers(),

        SizedBox(
          width: codeWidth,
          child: _buildCodeLines(),
        ),
      ],
    );
  }

  // ============================================================
  // LINE NUMBERS
  // ============================================================

  Widget _buildLineNumbers() {
    return SizedBox(
      width: 45,
      child: Column(
        mainAxisSize:
        MainAxisSize.min,
        crossAxisAlignment:
        CrossAxisAlignment.end,
        children: List.generate(
          _code.length,
              (index) {
            final bool active =
            _isActiveLine(index);

            return SizedBox(
              height: 20,
              child: Padding(
                padding:
                const EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    height: 1.0,
                    color: active
                        ? AppColors.blue
                        : const Color(
                      0xFF98A2B3,
                    ),
                    fontWeight: active
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // CODE LINES
  // ============================================================

  Widget _buildCodeLines() {
    return Column(
      mainAxisSize:
      MainAxisSize.min,
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: List.generate(
        _code.length,
            (index) {
          return _buildCodeLine(index);
        },
      ),
    );
  }

  // ============================================================
  // SINGLE CODE LINE
  // ============================================================

  Widget _buildCodeLine(
      int index,
      ) {
    final String line =
    _code[index];

    final int before =
    _charactersBeforeLine(index);

    final int visibleCount =
    (_visibleCharacters - before)
        .clamp(0, line.length);

    final String visibleText =
    line.substring(
      0,
      visibleCount,
    );

    final bool active =
    _isActiveLine(index);

    return Container(
      height: 20,
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFF4F8FF)
            : Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: _syntaxHighlightedText(
              visibleText,
            ),
          ),

          if (active)
            _buildCursor(),
        ],
      ),
    );
  }

  // ============================================================
  // SYNTAX HIGHLIGHTING
  // ============================================================

  Widget _syntaxHighlightedText(
      String text,
      ) {
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<TextSpan> spans = [];

    final RegExp pattern = RegExp(
      r"('(?:[^'\\]|\\.)*'|@[A-Za-z_]\w*|\b(?:import|class|extends|const|override|return|final|required)\b|\b(?:Widget|BuildContext|StatelessWidget|Column|Text)\b|\b(?:build|context|children|key)\b)",
    );

    int current = 0;

    for (
    final match
    in pattern.allMatches(text)
    ) {
      if (match.start > current) {
        spans.add(
          TextSpan(
            text: text.substring(
              current,
              match.start,
            ),
            style: _normalCodeStyle,
          ),
        );
      }

      final String token =
      match.group(0)!;

      spans.add(
        TextSpan(
          text: token,
          style: _tokenStyle(token),
        ),
      );

      current = match.end;
    }

    if (current < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(current),
          style: _normalCodeStyle,
        ),
      );
    }

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.clip,
      text: TextSpan(
        children: spans,
      ),
    );
  }

  // ============================================================
  // NORMAL CODE STYLE
  // ============================================================

  TextStyle get _normalCodeStyle {
    return const TextStyle(
      fontFamily: 'monospace',
      fontSize: 11,
      height: 1.4,
      color: Color(0xFF344054),
    );
  }

  // ============================================================
  // TOKEN STYLE
  // ============================================================

  TextStyle _tokenStyle(
      String token,
      ) {
    if (token.startsWith("'")) {
      return const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFF0A9F5B),
      );
    }

    if (token.startsWith('@')) {
      return const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFFB54708),
      );
    }

    const Set<String> keywords = {
      'import',
      'class',
      'extends',
      'const',
      'override',
      'return',
      'final',
      'required',
    };

    if (keywords.contains(token)) {
      return const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF8B2CF5),
      );
    }

    const Set<String> types = {
      'Widget',
      'BuildContext',
      'StatelessWidget',
      'Column',
      'Text',
    };

    if (types.contains(token)) {
      return const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF147BFF),
      );
    }

    const Set<String> properties = {
      'build',
      'context',
      'children',
      'key',
    };

    if (properties.contains(token)) {
      return const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFF0B8F55),
      );
    }

    return _normalCodeStyle;
  }

  // ============================================================
  // CURSOR
  // ============================================================

  Widget _buildCursor() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (
          context,
          child,
          ) {
        final double opacity =
        _animationController.value < 0.5
            ? 1
            : 0.15;

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Container(
        width: 1.5,
        height: 15,
        color: AppColors.blue,
      ),
    );
  }

  // ============================================================
  // ACTIVE LINE
  // ============================================================

  bool _isActiveLine(int index) {
    if (_typingFinished) {
      return false;
    }

    final int before =
    _charactersBeforeLine(index);

    final int length =
        _code[index].length;

    return _visibleCharacters >= before &&
        _visibleCharacters <=
            before + length;
  }

  // ============================================================
  // CHARACTERS BEFORE LINE
  // ============================================================

  int _charactersBeforeLine(
      int index,
      ) {
    int total = 0;

    for (int i = 0; i < index; i++) {
      total += _code[i].length;
    }

    return total;
  }

  // ============================================================
  // EDITOR SCROLLBAR
  // ============================================================

  Widget _buildEditorScrollbar() {
    return Container(
      width: 3,
      decoration: BoxDecoration(
        color: const Color(0xFFE4E7EC),
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 3,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.cyan,
            borderRadius:
            BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STATUS BAR
  // ============================================================

  Widget _buildStatusBar() {
    return Container(
      height: 32,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration:
      const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(
          top: BorderSide(
            color: Color(0xFFE8EDF5),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration:
            const BoxDecoration(
              color: Color(0xFF12B76A),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            _typingFinished
                ? 'Ready'
                : 'Running...',
            style:
            const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(width: 18),

          const Text(
            'Flutter',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFF667085),
            ),
          ),

          const Spacer(),

          const Text(
            'Dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(width: 15),

          const Text(
            'UTF-8',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFF667085),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// ONLINE INDICATOR
// ================================================================

class _OnlineIndicator extends StatefulWidget {
  const _OnlineIndicator();

  @override
  State<_OnlineIndicator> createState() =>
      _OnlineIndicatorState();
}

class _OnlineIndicatorState
    extends State<_OnlineIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.75,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 8,
        height: 8,
        decoration:
        const BoxDecoration(
          color: Color(0xFF1677FF),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ================================================================
// EDITOR TAB INDICATOR
// ================================================================

class _EditorTabIndicator
    extends StatelessWidget {
  const _EditorTabIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration:
      const BoxDecoration(
        color: AppColors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}