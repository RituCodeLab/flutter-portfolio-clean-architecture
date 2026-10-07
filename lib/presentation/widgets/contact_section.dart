import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/contact_info.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_state.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({
    super.key,
    this.onContactSelected,
  });

  final ValueChanged<ContactItemEntity>? onContactSelected;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  int? _hoveredIndex;
  bool _emailCopied = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _iconForType(ContactType type) {
    switch (type) {
      case ContactType.email:
        return Icons.mail_outline_rounded;
      case ContactType.phone:
        return Icons.phone_outlined;
      case ContactType.linkedin:
        return Icons.link_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        if (state is! PortfolioLoaded) {
          return const SizedBox.shrink();
        }

        final contactInfo = state.portfolioData.contactInfo;

        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                if (width < 700) {
                  return _buildMobile(contactInfo);
                }

                return _buildDesktop(width, contactInfo);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktop(double width, ContactInfo contactInfo) {
    final horizontalPadding = width > 1100 ? 70.0 : 35.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        90,
        horizontalPadding,
        110,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel(),
          const SizedBox(height: 42),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 11,
                child: _buildIntroduction(contactInfo),
              ),
              const SizedBox(width: 80),
              Expanded(
                flex: 9,
                child: _buildContactList(contactInfo),
              ),
            ],
          ),
          const SizedBox(height: 85),
          _buildFooterLine(),
        ],
      ),
    );
  }

  Widget _buildMobile(ContactInfo contactInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        65,
        20,
        75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel(),
          const SizedBox(height: 32),
          _buildIntroduction(contactInfo),
          const SizedBox(height: 50),
          _buildContactList(contactInfo),
          const SizedBox(height: 55),
          _buildFooterLine(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel() {
    return Row(
      children: [
        Container(
          width: 28,
          height: 1,
          color: const Color(0xFF1677FF),
        ),
        const SizedBox(width: 12),
        const Text(
          '05 / CONTACT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
            color: Color(0xFF1677FF),
          ),
        ),
      ],
    );
  }

  Widget _buildIntroduction(ContactInfo contactInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AVAILABLE FOR\nNEW OPPORTUNITIES.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            height: 1.35,
            color: Color(0xFF1677FF),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Let’s talk.',
          style: TextStyle(
            fontSize: 64,
            height: 0.98,
            fontWeight: FontWeight.w700,
            letterSpacing: -3,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 28),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: const Text(
            'I’m a Lead Mobile Application Developer focused on '
            'Flutter, Android and building reliable mobile products.',
            style: TextStyle(
              fontSize: 17,
              height: 1.75,
              color: Color(0xFF667085),
            ),
          ),
        ),
        const SizedBox(height: 42),
        _buildMetaRow(
          icon: Icons.location_on_outlined,
          label: 'BASED IN',
          value: contactInfo.location,
        ),
        const SizedBox(height: 20),
        _buildMetaRow(
          icon: Icons.code_rounded,
          label: 'FOCUS',
          value: contactInfo.focus,
        ),
        const SizedBox(height: 20),
        _buildMetaRow(
          icon: Icons.public_rounded,
          label: 'WORKING WITH',
          value: contactInfo.workingWith,
        ),
      ],
    );
  }

  Widget _buildMetaRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD0D5DD),
            ),
          ),
          child: Icon(
            icon,
            size: 15,
            color: const Color(0xFF475467),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF344054),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactList(ContactInfo contactInfo) {
    final items = contactInfo.contactItems;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D5DD),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactHeader(),
          for (int i = 0; i < items.length; i++)
            _buildContactRow(
              item: items[i],
              index: i,
              contactInfo: contactInfo,
            ),
          _buildEmailAction(contactInfo.email),
        ],
      ),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD0D5DD),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF12B76A),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'CONTACT DIRECTORY',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Color(0xFF344054),
            ),
          ),
          const Spacer(),
          const Text(
            'ONLINE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Color(0xFF12B76A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required ContactItemEntity item,
    required int index,
    required ContactInfo contactInfo,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndex = null;
        });
      },
      child: GestureDetector(
        onTap: () => _handleContact(item, contactInfo),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 23,
          ),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFF7FAFF) : Colors.white,
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFEAECF0),
              ),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isHovered
                      ? const Color(0xFFE8F1FF)
                      : const Color(0xFFF2F4F7),
                  border: Border.all(
                    color: isHovered
                        ? const Color(0xFFB2CCFF)
                        : const Color(0xFFE4E7EC),
                  ),
                ),
                child: Icon(
                  _iconForType(item.type),
                  size: 18,
                  color: isHovered
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF667085),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Color(0xFF98A2B3),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isHovered
                            ? const Color(0xFF1677FF)
                            : const Color(0xFF1D2939),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedSlide(
                duration: const Duration(milliseconds: 180),
                offset: isHovered ? const Offset(0.15, 0) : Offset.zero,
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 17,
                  color: isHovered
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF98A2B3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailAction(String email) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _openEmail(email),
                icon: const Icon(
                  Icons.send_outlined,
                  size: 17,
                ),
                label: const Text(
                  'SEND EMAIL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF101828),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 48,
            height: 48,
            child: OutlinedButton(
              onPressed: () => _copyEmail(email),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(
                  color: Color(0xFFD0D5DD),
                ),
                shape: const RoundedRectangleBorder(),
              ),
              child: Icon(
                _emailCopied ? Icons.check_rounded : Icons.copy_outlined,
                size: 18,
                color: _emailCopied
                    ? const Color(0xFF12B76A)
                    : const Color(0xFF475467),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLine() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 22),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFD0D5DD),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterIdentity(),
                const SizedBox(height: 14),
                _buildFooterRight(),
              ],
            );
          }

          return Row(
            children: [
              _buildFooterIdentity(),
              const Spacer(),
              _buildFooterRight(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooterIdentity() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'RITU NAMBATH',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: Color(0xFF344054),
          ),
        ),
        SizedBox(width: 12),
        Text(
          'MOBILE ENGINEERING',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Color(0xFF98A2B3),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterRight() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: 5,
          color: Color(0xFF12B76A),
        ),
        SizedBox(width: 8),
        Text(
          'OPEN TO CONVERSATIONS',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: Color(0xFF667085),
          ),
        ),
      ],
    );
  }

  Future<void> _handleContact(
      ContactItemEntity item, ContactInfo contactInfo) async {
    widget.onContactSelected?.call(item);

    switch (item.type) {
      case ContactType.email:
        await _openEmail(contactInfo.email);
        break;
      case ContactType.phone:
        await _openPhone(contactInfo.phone);
        break;
      case ContactType.linkedin:
        await _openLinkedIn(contactInfo.linkedIn);
        break;
    }
  }

  Future<void> _openEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: const {
        'subject': 'Mobile Development Opportunity',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await _copyText(email, 'Email address copied');
    }
  }

  Future<void> _openPhone(String phone) async {
    final uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await _copyText(phone, 'Phone number copied');
    }
  }

  Future<void> _openLinkedIn(String linkedinUrl) async {
    final uri = Uri.parse(
      linkedinUrl.startsWith('http')
          ? linkedinUrl
          : 'https://$linkedinUrl',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await _copyText(linkedinUrl, 'LinkedIn URL copied');
    }
  }

  Future<void> _copyEmail(String email) async {
    await _copyText(email, 'Email address copied');

    if (!mounted) return;

    setState(() {
      _emailCopied = true;
    });

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;
        setState(() {
          _emailCopied = false;
        });
      },
    );
  }

  Future<void> _copyText(String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
