import '../models/portfolio_models.dart';

abstract class PortfolioLocalDataSource {
  Future<PortfolioDataModel> getPortfolioData();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<PortfolioDataModel> getPortfolioData() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const PortfolioDataModel(
      profile: PortfolioProfileModel(
        name: 'Ritu Nambath',
        role: 'Lead Mobile Application Developer',
        summary:
            'Mobile application developer with 9+ years of experience building, modernizing, and publishing Android and Flutter applications. Strong in Kotlin, Java, Dart, Flutter, mobile architecture, BLoC, CI/CD, API integration, and application modernization.',
        email: 'ritunambath@gmail.com',
        phone: '+91-6359338882',
        location: 'Ahmedabad',
        linkedIn: 'https://www.linkedin.com/in/ritu-nambath-67123856',
        cvUrl: '/cv/Ritu_Nambath_Resume.pdf',
        highlights: [
          '9+ years in Android and Flutter development',
          'Led migrations from Java → Kotlin → Flutter',
          'Refactored Android MVP applications to MVVM',
          'Implemented BLoC in production Flutter applications',
          'Worked with CI/CD, Firebase, APIs and native SDK integrations',
          'Mentored junior developers, trainees and interns',
        ],
        heroTechnologies: ['Kotlin', 'Flutter', 'Dart', 'Android', 'Firebase'],
      ),
      experiences: [
        ExperienceModel(
          id: 'exp_1',
          company: 'TintBytes.com',
          role: 'Lead Mobile Application Developer',
          period: 'Sep 2025 – Jan 2026',
          location: 'India',
          description:
              'Led mobile application development with a focus on scalable architecture, Flutter and native Android engineering. Worked across application development, technical implementation and delivery.',
          technologies: ['Flutter', 'Dart', 'Kotlin', 'Android', 'BLoC'],
          isCurrent: true,
        ),
        ExperienceModel(
          id: 'exp_2',
          company: 'iPath Solutions',
          role: 'Senior Android & Flutter Developer',
          period: 'Dec 2024 – Apr 2025',
          location: 'India',
          description:
              'Worked on Android and Flutter applications, contributing to application architecture, feature development, integrations and production-ready mobile solutions.',
          technologies: ['Flutter', 'Dart', 'Kotlin', 'Android SDK', 'REST APIs'],
        ),
        ExperienceModel(
          id: 'exp_3',
          company: 'ADDV HealthTech Solutions',
          role: 'Senior Mobile Developer',
          period: 'Sep 2020 – Dec 2024',
          location: 'India',
          description:
              'Developed and maintained healthcare mobile applications across Android and Flutter. Worked on application migration, video calling, notifications, third-party integrations and CI/CD workflows.',
          technologies: ['Flutter', 'Kotlin', 'BLoC', 'OpenTok', 'Firebase', 'Bitrise'],
        ),
        ExperienceModel(
          id: 'exp_4',
          company: 'ELEGANZ IT Solutions Pvt. Ltd.',
          role: 'Senior Android Developer',
          period: 'Nov 2017 – May 2020',
          location: 'India',
          description:
              'Developed native Android applications using Kotlin and Java. Worked with Android architecture, networking, databases, background processing and third-party SDK integrations.',
          technologies: ['Kotlin', 'Java', 'Android SDK', 'MVVM', 'Retrofit', 'Room'],
        ),
        ExperienceModel(
          id: 'exp_5',
          company: 'TOPS Technology Pvt. Ltd.',
          role: 'Android Trainer',
          period: 'May 2016 – Jun 2017',
          location: 'India',
          description:
              'Delivered Android development training and helped learners understand mobile application development, Android fundamentals and practical implementation.',
          technologies: ['Android', 'Java', 'Android SDK', 'Training'],
        ),
        ExperienceModel(
          id: 'exp_6',
          company: 'MSP IT CONCEPT',
          role: 'Android Trainee',
          period: 'Jan 2016 – Apr 2016',
          location: 'India',
          description:
              'Started professional Android development experience by working with Android fundamentals, application development and practical mobile engineering concepts.',
          technologies: ['Android', 'Java', 'Android SDK'],
        ),
      ],
      projects: [
        ProjectModel(
          id: 'proj_1',
          name: 'Healthya',
          category: 'Healthcare',
          isHighlighted: true,
          description:
              'A healthcare application focused on online doctor consultation and communication between patients and healthcare professionals.',
          technologies: ['Flutter', 'Dart', 'BLoC', 'OpenTok', 'Firebase'],
          details: [
            'Migrated the application from Kotlin to Flutter.',
            'Implemented BLoC based state management.',
            'Integrated OpenTok for video conferencing.',
            'Used native Android and iOS handling through method channels.',
            'Configured CI/CD workflows with Bitrise.',
          ],
        ),
        ProjectModel(
          id: 'proj_2',
          name: 'AppLocum',
          category: 'Healthcare',
          description:
              'A UK-based healthcare application for medical staff with job applications, timesheets, communication and engagement features.',
          technologies: ['Android', 'Kotlin', 'Flutter', 'Firebase', 'Branch.io'],
          details: [
            'Worked on mobile application development for healthcare professionals.',
            'Implemented job application and timesheet related workflows.',
            'Worked with AppChat and AppForum functionality.',
            'Integrated notification and application engagement features.',
          ],
        ),
        ProjectModel(
          id: 'proj_3',
          name: 'PAS Audit',
          category: 'Healthcare',
          description:
              'A mobile application developed for audit and assessment workflows.',
          technologies: ['Android', 'Kotlin', 'MVVM', 'REST APIs'],
          details: [
            'Implemented Android application features.',
            'Worked with structured application architecture.',
            'Integrated backend APIs.',
            'Handled application data and user workflows.',
          ],
        ),
        ProjectModel(
          id: 'proj_4',
          name: 'Body Roundness Calculator',
          category: 'Health & Fitness',
          description:
              'A health-focused mobile application for calculating body roundness based on user measurements.',
          technologies: ['Flutter', 'Dart', 'BLoC'],
          details: [
            'Implemented the mobile application UI.',
            'Created reusable Flutter components.',
            'Implemented calculation and result flows.',
            'Used structured state management.',
          ],
        ),
        ProjectModel(
          id: 'proj_5',
          name: 'Fall Risk Assessment',
          category: 'Healthcare',
          description:
              'A healthcare application focused on assessing fall risk through structured assessment workflows.',
          technologies: ['Flutter', 'Dart', 'BLoC', 'Firebase'],
          details: [
            'Implemented assessment workflows.',
            'Created reusable mobile UI components.',
            'Managed application state using BLoC.',
            'Integrated application services.',
          ],
        ),
        ProjectModel(
          id: 'proj_6',
          name: 'ConnectMyHealth',
          category: 'Healthcare',
          description:
              'A mobile healthcare solution developed around connected health and patient-focused workflows.',
          technologies: ['Android', 'Kotlin', 'REST APIs', 'Firebase'],
          details: [
            'Developed Android application functionality.',
            'Worked with API based data flows.',
            'Implemented mobile UI and application logic.',
            'Integrated supporting mobile services.',
          ],
        ),
        ProjectModel(
          id: 'proj_7',
          name: 'Market24',
          category: 'Finance',
          description:
              'A market clock application designed to display global stock market timings and market sessions.',
          technologies: ['Android', 'Kotlin', 'Custom Views', 'Notifications'],
          details: [
            'Implemented market timing functionality.',
            'Worked with custom mobile UI components.',
            'Handled time based application behaviour.',
            'Implemented notification related functionality.',
          ],
        ),
        ProjectModel(
          id: 'proj_8',
          name: 'SoberSense',
          category: 'Health & Wellness',
          description:
              'A mobile application built around alcohol tracking and responsible consumption awareness.',
          technologies: ['Android', 'Kotlin', 'Bluetooth SDK', 'Firebase'],
          details: [
            'Worked on Android application development.',
            'Integrated device related functionality.',
            'Worked with Bluetooth based SDK integration.',
            'Implemented application data flows.',
          ],
        ),
      ],
      skillCategories: [
        SkillCategoryModel(
          id: 'cat_flutter',
          typeString: 'flutter',
          title: 'Flutter Engineering',
          subtitle: 'Modern cross-platform application development',
          description:
              'Building scalable cross-platform applications with Flutter, Dart, BLoC and native platform integrations.',
        ),
        SkillCategoryModel(
          id: 'cat_android',
          typeString: 'android',
          title: 'Android Engineering',
          subtitle: 'Native Android engineering and Jetpack',
          description:
              'Native Android development with Kotlin, Java, Jetpack components, architecture patterns and platform APIs.',
        ),
        SkillCategoryModel(
          id: 'cat_ai',
          typeString: 'ai',
          title: 'AI-Assisted Development',
          subtitle: 'Developer productivity and intelligent tools',
          description:
              'Using modern AI development tools to accelerate coding, debugging, refactoring, documentation and problem solving.',
        ),
      ],
      skills: [
        // Flutter
        SkillModel(
          id: 'sk_flutter',
          name: 'Flutter',
          categoryTypeString: 'flutter',
          isFeatured: true,
          description: 'Cross-platform mobile development',
        ),
        SkillModel(
          id: 'sk_dart',
          name: 'Dart',
          categoryTypeString: 'flutter',
          isFeatured: true,
          description: 'Primary Flutter language',
        ),
        SkillModel(
          id: 'sk_bloc',
          name: 'BLoC',
          categoryTypeString: 'flutter',
          isFeatured: true,
          description: 'State management',
        ),
        SkillModel(
          id: 'sk_provider',
          name: 'Provider',
          categoryTypeString: 'flutter',
        ),
        SkillModel(
          id: 'sk_dio',
          name: 'Dio',
          categoryTypeString: 'flutter',
        ),
        SkillModel(
          id: 'sk_hive',
          name: 'Hive',
          categoryTypeString: 'flutter',
        ),
        SkillModel(
          id: 'sk_firebase_flutter',
          name: 'Firebase',
          categoryTypeString: 'flutter',
          description: 'Authentication, notifications and Crashlytics',
        ),
        SkillModel(
          id: 'sk_opentok',
          name: 'OpenTok',
          categoryTypeString: 'flutter',
        ),
        SkillModel(
          id: 'sk_method_channels',
          name: 'Method Channels',
          categoryTypeString: 'flutter',
        ),
        SkillModel(
          id: 'sk_branch',
          name: 'Branch.io',
          categoryTypeString: 'flutter',
        ),

        // Android
        SkillModel(
          id: 'sk_kotlin',
          name: 'Kotlin',
          categoryTypeString: 'android',
          isFeatured: true,
          description: 'Primary Android language',
        ),
        SkillModel(
          id: 'sk_java',
          name: 'Java',
          categoryTypeString: 'android',
          isFeatured: true,
          description: 'Android development',
        ),
        SkillModel(
          id: 'sk_android_sdk',
          name: 'Android SDK',
          categoryTypeString: 'android',
          isFeatured: true,
        ),
        SkillModel(
          id: 'sk_jetpack',
          name: 'Jetpack',
          categoryTypeString: 'android',
          isFeatured: true,
        ),
        SkillModel(
          id: 'sk_viewmodel',
          name: 'ViewModel',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_livedata',
          name: 'LiveData',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_room',
          name: 'Room',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_navigation',
          name: 'Navigation',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_workmanager',
          name: 'WorkManager',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_mvvm',
          name: 'MVVM',
          categoryTypeString: 'android',
          isFeatured: true,
        ),
        SkillModel(
          id: 'sk_mvp',
          name: 'MVP',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_dagger',
          name: 'Dagger',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_retrofit',
          name: 'Retrofit',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_okhttp',
          name: 'OkHttp',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_sqlite',
          name: 'SQLite',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_coroutines',
          name: 'Kotlin Coroutines',
          categoryTypeString: 'android',
        ),
        SkillModel(
          id: 'sk_bluetooth',
          name: 'Bluetooth SDK',
          categoryTypeString: 'android',
        ),

        // AI
        SkillModel(
          id: 'sk_cursor',
          name: 'Cursor',
          categoryTypeString: 'ai',
          isFeatured: true,
          description: 'AI-assisted development',
        ),
        SkillModel(
          id: 'sk_claude',
          name: 'Claude',
          categoryTypeString: 'ai',
          isFeatured: true,
          description: 'Development and technical assistance',
        ),
        SkillModel(
          id: 'sk_chatgpt',
          name: 'ChatGPT',
          categoryTypeString: 'ai',
          isFeatured: true,
          description: 'Development and problem solving',
        ),
        SkillModel(
          id: 'sk_gemini',
          name: 'Gemini',
          categoryTypeString: 'ai',
          isFeatured: true,
          description: 'AI-assisted development',
        ),
        SkillModel(
          id: 'sk_prompt_eng',
          name: 'Prompt Engineering',
          categoryTypeString: 'ai',
        ),
        SkillModel(
          id: 'sk_code_review',
          name: 'Code Review',
          categoryTypeString: 'ai',
        ),
        SkillModel(
          id: 'sk_refactoring',
          name: 'Refactoring',
          categoryTypeString: 'ai',
        ),
        SkillModel(
          id: 'sk_doc',
          name: 'Technical Documentation',
          categoryTypeString: 'ai',
        ),
      ],
      contactInfo: ContactInfoModel(
        email: 'ritunambath@gmail.com',
        phone: '+91-6359338882',
        linkedIn: 'https://www.linkedin.com/in/ritu-nambath-67123856',
        location: 'Ahmedabad',
        focus: 'Flutter · Android · Mobile Engineering',
        workingWith: 'Remote · Product teams · Startups',
        contactItems: [
          ContactItemModel(
            label: 'EMAIL',
            value: 'ritunambath@gmail.com',
            typeString: 'email',
          ),
          ContactItemModel(
            label: 'PHONE',
            value: '+91-6359338882',
            typeString: 'phone',
          ),
          ContactItemModel(
            label: 'LINKEDIN',
            value: 'https://www.linkedin.com/in/ritu-nambath-67123856',
            typeString: 'linkedin',
          ),
        ],
      ),
    );
  }
}
