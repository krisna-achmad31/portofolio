import 'package:flutter/material.dart';

class Project {
  final String title;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final List<String> impact;
  final String category; // 'Hardware', 'IoT', 'Mobile', 'Fintech', 'Healthcare'
  final bool featured;
  final IconData icon;
  final List<Color> gradient;
  // Optional: asset paths for real screenshots. If empty, stylized mockup is used.
  // Example: ['assets/images/screenshots/iot_stadium_1.png', '...']
  final List<String> screenshots;
  final String iconImage;

  const Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    required this.impact,
    required this.category,
    required this.featured,
    required this.icon,
    required this.gradient,
    this.screenshots = const [],
    this.iconImage = '',
  });
}

const List<Project> kProjects = [
  // === HARDWARE / IoT — Featured (signal differentiation) ===
  Project(
    title: 'IoT Stadium · Handheld RFID',
    subtitle: 'Industrial RFID Integration',
    description:
        'A robust RFID-integrated solution for industrial handhelds (Zebra MC3300 & UHF-RH03), bridging Flutter with native hardware SDKs via Method Channels. Maintains Clean Architecture to manage complex state transitions during bulk tag reads, ensuring stable performance in high-density warehouse environments.',
    techStack: ['Flutter', 'Native Android SDK', 'Method Channel', 'Clean Architecture', 'BLoC', 'Zebra MC3300', 'UHF-RH03'],
    impact: ['Industrial IoT Solution', '25% asset tracking accuracy gain', 'Offline-first architecture'],
    category: 'Hardware',
    featured: true,
    screenshots: ['assets/images/rfid_1.png','assets/images/rfid_2.png',],
    icon: Icons.qr_code_scanner_rounded,
    iconImage: 'assets/images/rfid.png',
    gradient: [Color(0xFF4A9EFF), Color(0xFF7B6FFF)],
  ),
  Project(
    title: 'IoT Stadium',
    subtitle: 'Smart Stadium Management',
    description:
        'An enterprise-grade Flutter application built for Smart Stadium management. Utilizes Clean Architecture to ensure scalability and stability. Provides comprehensive CRUD functionality for IoT devices and integrates seamlessly with BLE (Bluetooth Low Energy) gateways, leveraging MQTT and LoRaWAN protocols for real-time communication.',
    techStack: ['Flutter', 'BLE', 'MQTT', 'LoRaWAN', 'WebSocket', 'Clean Architecture'],
    impact: ['Real-time IoT monitoring', '15% latency reduction', 'Multi-protocol device support'],
    category: 'IoT',
    featured: true,
    screenshots: ['assets/images/iotstadium_1.png','assets/images/iotstadium_2.png',],
    icon: Icons.sensors_rounded,
    iconImage: 'assets/images/iotstadium.png',
    gradient: [Color(0xFF7B6FFF), Color(0xFFB94AFF)],
  ),
  Project(
    title: 'NoTo Labs',
    subtitle: 'IoT Gateway Configuration',
    description:
        'A specialized Flutter application designed for advanced IoT device configuration. Simplifies gateway management by providing an intuitive interface for pairing, controlling, and monitoring BLE-connected hardware. Engineered for precision and efficiency in industrial environments.',
    techStack: ['Flutter', 'BLE', 'Tuya SDK', 'MQTT', 'Real-time Sync'],
    impact: ['Smart Gateway Management', 'Industrial deployment', 'Cross-platform iOS + Android'],
    category: 'IoT',
    featured: true,
    screenshots: ['assets/images/noto_1.png','assets/images/noto_2.png',],
    iconImage: 'assets/images/noto.png',
    icon: Icons.hub_rounded,
    gradient: [Color(0xFF4ABEFF), Color(0xFF4A9EFF)],
  ),

  // === Other significant work ===
  Project(
    title: 'Hall Aircon · NTU Singapore',
    subtitle: 'Custom IoT Utility',
    description:
        'A custom IoT utility application deployed at Nanyang Technological University (NTU), Singapore. Allows students to wirelessly control dormitory air conditioning units via smartphone. Features a secure digital wallet for usage top-ups and real-time credit monitoring.',
    techStack: ['Flutter', 'IoT', 'Digital Wallet', 'REST API'],
    impact: ['Deployed at NTU Singapore', '1,000+ active users', 'iOS + Android'],
    category: 'IoT',
    featured: false,
    icon: Icons.ac_unit_rounded,
    screenshots: ['assets/images/hall_aircon_1.png','assets/images/hall_aircon_2.png',],
    gradient: [Color(0xFF4A9EFF), Color(0xFF4ABEFF)],
  ),
  Project(
    title: "COLLIN'S Rewards",
    subtitle: 'F&B Loyalty Platform',
    description:
        "Official mobile app for Collin's Grille, a major F&B chain in Singapore. Built with scalable Kotlin architecture, it handles high-traffic reservations, membership loyalty programs, and digital menu browsing to enhance the customer dining experience.",
    techStack: ['Kotlin', 'Swift', 'MVVM', 'REST API', 'Firebase'],
    impact: ['50,000+ users', '4.3★ rating on Google Play', 'Singapore F&B sector'],
    category: 'Mobile',
    featured: false,
    screenshots: ['assets/images/collins_1.png','assets/images/collins_2.png',],
    icon: Icons.restaurant_rounded,
    gradient: [Color(0xFFFFA94A), Color(0xFFFF6B4A)],
  ),
  Project(
    title: 'VinGeek',
    subtitle: 'F&B + E-commerce Hybrid',
    description:
        'A sophisticated lifestyle and e-commerce app for the culinary sector. VinGeek merges restaurant reservations with an online wine marketplace. Users can browse curated menus, book tables, or order exclusive wines for home delivery, all within a unified, elegant interface.',
    techStack: ['Flutter', 'E-commerce', 'POS Integration', 'Real-time Inventory'],
    impact: ['Singapore culinary sector', 'IFoundries partnership', 'Cross-platform'],
    category: 'Mobile',
    featured: false,
    screenshots: ['assets/images/vingeek_1.png','assets/images/vingeek_2.png',],
    icon: Icons.wine_bar_rounded,
    gradient: [Color(0xFFFF6B8A), Color(0xFFB94AFF)],
  ),
  Project(
    title: 'PropNex+',
    subtitle: 'Real Estate Super-App',
    description:
        "A comprehensive Real Estate Super-App built with Flutter. Designed to digitize the property market, it empowers agents and clients to list, sell, and rent properties effortlessly. Features advanced listing management, open house scheduling, and a seamless 'Lead Client' system for agents.",
    techStack: ['Flutter', 'MVVM', 'Provider', 'Maps', 'REST API'],
    impact: ['5.0★ App Store rating', '1,000+ downloads', '30% crash rate reduction'],
    category: 'Mobile',
    featured: false,
    screenshots: ['assets/images/propnex_1.png','assets/images/propnex_2.png',],
    icon: Icons.home_work_rounded,
    gradient: [Color(0xFF4ABEFF), Color(0xFF4AFFB1)],
  ),
  Project(
    title: 'Seraphim',
    subtitle: 'Healthcare Management',
    description:
        'A holistic Healthcare Management application developed with Flutter. Streamlines the patient experience by offering instant doctor appointments, access to medical history records, and integrated health analysis questionnaires. Designed with a focus on data privacy and user empathy.',
    techStack: ['Flutter', 'Clean Architecture', 'Secure Storage', 'REST API'],
    impact: ['Premier healthcare platform Jakarta', 'iOS + Android', 'Privacy-first design'],
    category: 'Healthcare',
    featured: false,
    screenshots: ['assets/images/seraphim_1.png','assets/images/seraphim_2.png',],
    icon: Icons.local_hospital_rounded,
    gradient: [Color(0xFFC9A24A), Color(0xFF8A6B3A)],
  ),
  Project(
    title: 'IndiHealth',
    subtitle: 'Telemedicine Platform',
    description:
        'A comprehensive Telemedicine platform developed for Lintasarta. The app connects patients with doctors through secure video consultations (integrated with Jitsi Meet). Features Electronic Medical Records (EMR) management and online prescription handling.',
    techStack: ['Android (Kotlin)', 'Jitsi Meet SDK', 'EMR', 'HIPAA-compliant'],
    impact: ['25% traffic capacity increase', 'Indonesian healthcare sector', 'HIPAA-compliant'],
    category: 'Healthcare',
    featured: false,
    screenshots: ['assets/images/indihealth_1.png','assets/images/indihealth_2.png',],
    icon: Icons.video_camera_front_rounded,
    gradient: [Color(0xFF4ADBC2), Color(0xFF4A9EFF)],
  ),
  Project(
    title: 'Vonix',
    subtitle: 'Crypto Trading Platform',
    description:
        'A high-security Cryptocurrency Trading platform built with Kotlin (MVVM). Vonix is engineered for speed and reliability, featuring real-time market charts (WebSocket integration), secure asset wallets, and seamless portfolio management for Indonesian crypto investors.',
    techStack: ['Kotlin', 'MVVM', 'WebSocket', 'Biometric Auth', 'Real-time Charts'],
    impact: ['Indonesian crypto market', 'Biometric security', 'Real-time trading'],
    category: 'Fintech',
    featured: false,
    screenshots: ['assets/images/vonix_1.png','assets/images/vonix_2.png',],
    icon: Icons.currency_bitcoin_rounded,
    gradient: [Color(0xFFFFC44A), Color(0xFFFF884A)],
  ),
  Project(
    title: 'PinGO',
    subtitle: 'Social Discovery',
    description:
        'A social discovery and photo editing application built with Kotlin. PinGo combines powerful image processing tools with location-based recommendations, helping users create stunning content and discover "Instagrammable" spots nearby.',
    techStack: ['Kotlin', 'Image Processing', 'Geolocation', 'Social Features'],
    impact: ['Social discovery market', 'Image editing toolkit', 'Location-aware'],
    category: 'Mobile',
    featured: false,
    screenshots: ['assets/images/ping_1.png','assets/images/ping_2.png',],
    icon: Icons.camera_alt_rounded,
    gradient: [Color(0xFF7B6FFF), Color(0xFF4ABEFF)],
  ),
  Project(
    title: 'SiKelud',
    subtitle: 'Government Data Collection',
    description:
        'The official data collection application for the Kediri Regional Government. Digitizes the survey process, allowing field officers to create, edit, and submit dynamic questionnaires efficiently. Replaces manual workflows and accelerates regional data analysis.',
    techStack: ['Android', 'Offline-first', 'Dynamic Forms', 'REST API'],
    impact: ['Official Kediri Regency app', 'Field officer workflow', 'Offline data sync'],
    category: 'Mobile',
    featured: false,
    screenshots: ['assets/images/inkelud_1.png','assets/images/inkelud_2.png',],
    icon: Icons.assignment_rounded,
    gradient: [Color(0xFF4ADBC2), Color(0xFF4ABEFF)],
  ),
];

// Skills grouped by category
const Map<String, List<String>> kSkills = {
  'Mobile Platforms': [
    'Flutter (Mobile & Desktop)',
    'Android (Kotlin / Java)',
    'iOS (Swift)',
    'Cross-Platform Development',
  ],
  'Hardware Integration': [
    'BLE (Bluetooth Low Energy)',
    'RFID — Zebra MC3300',
    'UHF — EL-UHF-RH03',
    'POS Systems',
    'ESP-32 / IoT Devices',
    'MQTT / WebSocket',
    'Method Channel (Native Bridge)',
  ],
  'Architecture & Patterns': [
    'Clean Architecture',
    'MVVM',
    'BLoC / Cubit',
    'Provider / GetX',
    'Offline-first Sync',
    'Repository Pattern',
  ],
  'Backend & Integration': [
    'RESTful APIs',
    'GraphQL',
    'WebSocket (Real-time)',
    'Firebase',
    'Tuya SDK',
    'Jitsi Meet SDK',
  ],
  'Tools & Workflow': [
    'Git / GitHub / GitLab',
    'CI/CD (GitHub Actions, Bitrise)',
    'AI-Augmented (Cursor, Copilot, Gemini)',
    'Jira / Agile / Scrum',
    'Play Store + App Store Deployment',
  ],
};
