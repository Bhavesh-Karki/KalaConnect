import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../widgets/common_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About KalaConnect')),
      body: PageShell(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Hero Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: terracotta.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              'assets/images/KalaConnect-transparentIcon.png',
                              errorBuilder: (_, _, _) => const Icon(Icons.handshake_outlined, color: terracotta),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        letterSpacing: 0.2,
                                      ),
                                  children: const [
                                    TextSpan(
                                      text: 'Kala',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: ink,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Connect',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFE58E47),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Digital Marketplace & Knowledge Network',
                                style: TextStyle(color: teal, fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A digital ecosystem designed to connect traditional artisans, learners, researchers, and consumers—preserving generational craft knowledge while enabling direct economic discovery.',
                      style: TextStyle(height: 1.4, fontSize: 13.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Section 1: Problem Statement
            _StepSectionCard(
              stepNumber: '1',
              stepColor: terracotta,
              title: 'Problem Statement',
              icon: Icons.report_problem_outlined,
              points: const [
                _SectionPoint(
                  title: 'Market Invisibility:',
                  description:
                      'Generational artisans struggle to reach digital consumers, maintain visibility in modern commerce, and find new apprentices.',
                ),
                _SectionPoint(
                  title: 'Authenticity & Trust Gap:',
                  description:
                      'Buyers cannot easily distinguish authentic handmade craftwork from factory-made mass imitations or understand their cultural worth.',
                ),
                _SectionPoint(
                  title: 'Knowledge Erosion:',
                  description:
                      'Centuries of oral techniques, indigenous material know-how, and craft lineage lack structured digital preservation.',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Section 2: How KalaConnect Solves This
            _StepSectionCard(
              stepNumber: '2',
              stepColor: teal,
              title: 'How Our App Solves This',
              icon: Icons.lightbulb_outline,
              points: const [
                _SectionPoint(
                  title: 'Beyond Simple E-Commerce:',
                  description:
                      'Unites economic viability with deep cultural documentation—valuing the artisan and the process just as much as the product.',
                ),
                _SectionPoint(
                  title: 'Direct Maker Discovery:',
                  description:
                      'Connects conscious consumers directly with maker identities, workshops, regional origins, and fair local enquiries.',
                ),
                _SectionPoint(
                  title: 'Structured Living Archives:',
                  description:
                      'Preserves regional context, raw material origins, step-by-step methods, and cultural significance for each craft family.',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Section 3: What This App Does (Current Capabilities)
            _StepSectionCard(
              stepNumber: '3',
              stepColor: ochre,
              title: 'What This App Does (Current Prototype)',
              icon: Icons.touch_app_outlined,
              points: const [
                _SectionPoint(
                  title: 'Artisan Profiles & Stories:',
                  description:
                      'Explore detailed maker bios, experience years, geographic locations, and studio philosophies.',
                ),
                _SectionPoint(
                  title: 'Craft & Process Library:',
                  description:
                      'Learn the authentic processes, materials, care guides, and cultural roots of Pottery, Bamboo, Textiles, Wood, and Metal.',
                ),
                _SectionPoint(
                  title: 'Multi-Level Discovery Filters:',
                  description:
                      'Filter smoothly by category, sub-style, state/region, material, crafting duration, and price.',
                ),
                _SectionPoint(
                  title: 'Direct Custom Enquiries:',
                  description:
                      'Submit and manage custom order requests and bespoke specifications, saved offline on your device.',
                ),
                _SectionPoint(
                  title: 'Curated Image & Artwork Gallery:',
                  description:
                      'Real product photography backed by custom vector illustrations for guaranteed offline resilience.',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Section 4: Future Scope
            _StepSectionCard(
              stepNumber: '4',
              stepColor: ink,
              title: 'Future Scope & Innovation Roadmap',
              icon: Icons.rocket_launch_outlined,
              points: const [
                _SectionPoint(
                  title: 'AI-Assisted Multilingual Storytelling:',
                  description:
                      'Voice-guided oral history recording and translation across regional Indian vernaculars.',
                ),
                _SectionPoint(
                  title: 'Computer Vision Authenticity Check:',
                  description:
                      'Camera-based texture & weave scanning to verify genuine handmade provenance versus machine replica.',
                ),
                _SectionPoint(
                  title: 'Digital Provenance & GI Certification:',
                  description:
                      'Verifiable digital certificates and blockchain traceability for Geographical Indication (GI) crafts.',
                ),
                _SectionPoint(
                  title: 'AR/VR Virtual Craft Workshops:',
                  description:
                      'Immersive 3D apprentice learning environments connecting masters with global students.',
                ),
                _SectionPoint(
                  title: 'GIS Geographic Craft Mapping:',
                  description:
                      'Interactive map tracing artisan clusters, raw material belts, and regional craft heritage trails across India.',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Demo Notice
            // const DemoNotice(text: demoNotice)
          ],
        ),
      ),
    );
  }
}

class _StepSectionCard extends StatelessWidget {
  const _StepSectionCard({
    required this.stepNumber,
    required this.stepColor,
    required this.title,
    required this.icon,
    required this.points,
  });

  final String stepNumber;
  final Color stepColor;
  final String title;
  final IconData icon;
  final List<_SectionPoint> points;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: stepColor,
                  child: Text(
                    stepNumber,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, size: 20, color: stepColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ink,
                        ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...points.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 8),
                        child: Icon(Icons.fiber_manual_record, size: 7, color: stepColor),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35, fontSize: 13),
                            children: [
                              TextSpan(
                                text: '${p.title} ',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: ink),
                              ),
                              TextSpan(text: p.description),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _SectionPoint {
  const _SectionPoint({required this.title, required this.description});

  final String title;
  final String description;
}
