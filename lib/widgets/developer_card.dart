import 'dart:ui'; // BackdropFilter için import edildi
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Fütüristik Sosyal Medya Butonu
class FuturisticSocialButton extends StatelessWidget {
  final String iconPath;
  final String url;
  final Color baseColor;

  const FuturisticSocialButton({
    super.key,
    required this.iconPath,
    required this.url,
    required this.baseColor,
  });

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: baseColor.withOpacity(0.2), // Yarı saydam arka plan
      ),
      child: IconButton(
        icon: Image.asset(iconPath, width: 20, height: 20),
        onPressed: _launchUrl,
        tooltip: url,
        splashRadius: 20,
        highlightColor: baseColor.withOpacity(0.5),
        hoverColor: baseColor.withOpacity(0.3),
      ),
    );
  }
}

// Ana Geliştirici Kartı Component'i (Fütüristik Versiyon)
class DeveloperCard extends StatelessWidget {
  final String name;
  final String title;
  final String githubImageAssetsPath; // Adı ve tipi değiştirildi
  final String? linkedinUrl;
  final String? githubUrl;
  final String? instagramUrl;
  final String? youtubeUrl;
  final String? twitterUrl;

  const DeveloperCard({
    super.key,
    required this.name,
    required this.title,
    required this.githubImageAssetsPath, // Yeni parametre
    this.linkedinUrl,
    this.githubUrl,
    this.instagramUrl,
    this.youtubeUrl,
    this.twitterUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final cardColor = isDarkMode
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.3);
    final borderColor = isDarkMode
        ? Colors.white.withOpacity(0.3)
        : Colors.black.withOpacity(0.2);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDarkMode ? 0.4 : 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(
                      isDarkMode ? 0.3 : 0.1,
                    ),
                    theme.colorScheme.secondary.withOpacity(
                      isDarkMode ? 0.3 : 0.1,
                    ),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    // Sol Taraf: Profil Fotoğrafı
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.secondary,
                          ],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          githubImageAssetsPath,
                        ), // AssetImage olarak değiştirildi
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Sağ Taraf: İsim, Unvan ve Butonlar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Sosyal Medya Butonları Sırası
                          Wrap(
                            spacing: 8.0,
                            children: [
                              if (linkedinUrl != null)
                                FuturisticSocialButton(
                                  iconPath: 'assets/linkedin.png',
                                  url: linkedinUrl!,
                                  baseColor: const Color(0xFF0A66C2),
                                ),
                              if (githubUrl != null)
                                FuturisticSocialButton(
                                  iconPath: 'assets/github.png',
                                  url: githubUrl!,
                                  baseColor: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              if (instagramUrl != null)
                                FuturisticSocialButton(
                                  iconPath: 'assets/instagram.png',
                                  url: instagramUrl!,
                                  baseColor: const Color(0xFFE1306C),
                                ),
                              if (youtubeUrl != null)
                                FuturisticSocialButton(
                                  iconPath: 'assets/youtube.png',
                                  url: youtubeUrl!,
                                  baseColor: const Color(0xFFFF0000),
                                ),
                              if (twitterUrl != null)
                                FuturisticSocialButton(
                                  iconPath: 'assets/twitter.png',
                                  url: twitterUrl!,
                                  baseColor: const Color(0xFF1DA1F2),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
