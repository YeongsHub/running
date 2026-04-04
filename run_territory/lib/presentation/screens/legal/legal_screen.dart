import 'package:flutter/material.dart';

enum LegalType { privacyPolicy, termsOfUse }

class LegalScreen extends StatelessWidget {
  final LegalType type;

  const LegalScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isPrivacy = type == LegalType.privacyPolicy;
    final title = isPrivacy
        ? _localizedTitle(context, isPrivacy: true)
        : _localizedTitle(context, isPrivacy: false);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          isPrivacy ? _privacyPolicy(context) : _termsOfUse(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
        ),
      ),
    );
  }

  String _localizedTitle(BuildContext context, {required bool isPrivacy}) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'de') return isPrivacy ? 'Datenschutzerklärung' : 'Nutzungsbedingungen';
    if (locale == 'ko') return isPrivacy ? '개인정보처리방침' : '이용약관';
    return isPrivacy ? 'Privacy Policy' : 'Terms of Use';
  }

  String _privacyPolicy(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'de') return _privacyDe;
    if (locale == 'ko') return _privacyKo;
    return _privacyEn;
  }

  String _termsOfUse(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'de') return _termsDe;
    if (locale == 'ko') return _termsKo;
    return _termsEn;
  }

  // ── English ────────────────────────────────────────────────────────────────

  static const _privacyEn = '''
Privacy Policy
Last updated: April 2026

1. Data We Collect
RunDone collects GPS location data while you are actively running. This data is stored locally on your device and is never transmitted to external servers in the Free version.

2. How We Use Your Data
Your location data is used solely to track your running route, detect loop completion, and generate territory polygons on the map.

3. Data Storage
All data (runs, routes, territories) is stored locally in a SQLite database on your device. We do not upload or share your data with third parties.

4. Advertising
The Free version displays ads provided by Google AdMob. AdMob may collect device identifiers and usage data in accordance with Google's Privacy Policy.

5. Permissions
- Location (Fine & Coarse): Required for GPS tracking during runs.
- Background Location: Required to continue tracking when the app is in the background.

6. Your Rights
You may delete all app data at any time by uninstalling the app or clearing app data in your device settings.

7. Contact
For privacy inquiries, please contact us via the app store listing.
''';

  static const _termsEn = '''
Terms of Use
Last updated: April 2026

1. Acceptance
By using RunDone, you agree to these Terms of Use.

2. License
RunDone grants you a limited, non-exclusive, non-transferable license to use the app for personal, non-commercial purposes.

3. Prohibited Use
You may not reverse-engineer, modify, or distribute the app. You may not use the app for any unlawful purpose.

4. GPS & Safety
RunDone uses your GPS location. Always pay attention to your surroundings while running. We are not liable for any accidents or injuries.

5. Disclaimer
The app is provided "as is" without warranty of any kind. We do not guarantee accuracy of GPS data or territory calculations.

6. In-App Purchases
Pro features are available via a one-time in-app purchase. All purchases are final and non-refundable unless required by law.

7. Changes
We reserve the right to modify these terms at any time. Continued use of the app constitutes acceptance of the updated terms.

8. Contact
For questions, please contact us via the app store listing.
''';

  // ── German ─────────────────────────────────────────────────────────────────

  static const _privacyDe = '''
Datenschutzerklärung
Stand: April 2026

1. Erhobene Daten
RunDone erfasst GPS-Standortdaten, während du aktiv läufst. Diese Daten werden lokal auf deinem Gerät gespeichert und in der kostenlosen Version nicht an externe Server übertragen.

2. Verwendung deiner Daten
Deine Standortdaten werden ausschließlich zur Aufzeichnung deiner Laufroute, zur Erkennung von Schleifen und zur Erstellung von Gebietsflächen auf der Karte verwendet.

3. Datenspeicherung
Alle Daten (Läufe, Routen, Gebiete) werden lokal in einer SQLite-Datenbank auf deinem Gerät gespeichert. Wir laden deine Daten nicht hoch und geben sie nicht an Dritte weiter.

4. Werbung
Die kostenlose Version zeigt Werbeanzeigen von Google AdMob. AdMob kann Gerätekennungen und Nutzungsdaten gemäß der Datenschutzrichtlinie von Google erfassen.

5. Berechtigungen
- Standort (Genau & Ungefähr): Erforderlich für GPS-Tracking während des Laufens.
- Hintergrundstandort: Erforderlich, um das Tracking fortzusetzen, wenn die App im Hintergrund läuft.

6. Deine Rechte
Du kannst alle App-Daten jederzeit löschen, indem du die App deinstallierst oder die App-Daten in den Geräteeinstellungen löschst.

7. Kontakt
Für Datenschutzanfragen kontaktiere uns bitte über den App-Store-Eintrag.
''';

  static const _termsDe = '''
Nutzungsbedingungen
Stand: April 2026

1. Zustimmung
Durch die Nutzung von RunDone stimmst du diesen Nutzungsbedingungen zu.

2. Lizenz
RunDone gewährt dir eine eingeschränkte, nicht-exklusive, nicht übertragbare Lizenz zur persönlichen, nicht-kommerziellen Nutzung der App.

3. Verbotene Nutzung
Du darfst die App nicht zurückentwickeln, modifizieren oder verbreiten. Eine rechtswidrige Nutzung ist nicht gestattet.

4. GPS & Sicherheit
RunDone nutzt deinen GPS-Standort. Achte beim Laufen stets auf deine Umgebung. Wir haften nicht für Unfälle oder Verletzungen.

5. Haftungsausschluss
Die App wird „wie besehen" ohne jegliche Garantie bereitgestellt. Wir übernehmen keine Gewähr für die Genauigkeit der GPS-Daten oder Gebietsberechnungen.

6. In-App-Käufe
Pro-Funktionen sind über einen einmaligen In-App-Kauf verfügbar. Alle Käufe sind endgültig und nicht erstattungsfähig, sofern nicht gesetzlich vorgeschrieben.

7. Änderungen
Wir behalten uns das Recht vor, diese Bedingungen jederzeit zu ändern. Die weitere Nutzung der App gilt als Zustimmung zu den aktualisierten Bedingungen.

8. Kontakt
Bei Fragen kontaktiere uns bitte über den App-Store-Eintrag.
''';

  // ── Korean ─────────────────────────────────────────────────────────────────

  static const _privacyKo = '''
개인정보처리방침
최종 업데이트: 2026년 4월

1. 수집하는 정보
RunDone는 달리기 중 GPS 위치 데이터를 수집합니다. 이 데이터는 기기에 로컬로 저장되며, 무료 버전에서는 외부 서버로 전송되지 않습니다.

2. 데이터 사용 목적
위치 데이터는 달리기 경로 추적, 루프 완료 감지, 지도 위 영역 생성에만 사용됩니다.

3. 데이터 저장
모든 데이터(달리기 기록, 경로, 영역)는 기기의 SQLite 데이터베이스에 로컬로 저장됩니다. 제3자에게 데이터를 업로드하거나 공유하지 않습니다.

4. 광고
무료 버전은 Google AdMob 광고를 표시합니다. AdMob은 Google 개인정보처리방침에 따라 기기 식별자 및 사용 데이터를 수집할 수 있습니다.

5. 권한
- 위치(정밀 및 대략적): 달리기 중 GPS 추적에 필요합니다.
- 백그라운드 위치: 앱이 백그라운드에 있을 때 추적을 계속하기 위해 필요합니다.

6. 귀하의 권리
앱을 삭제하거나 기기 설정에서 앱 데이터를 초기화하면 언제든지 모든 데이터를 삭제할 수 있습니다.

7. 문의
개인정보 관련 문의는 앱 스토어 페이지를 통해 연락해 주세요.
''';

  static const _termsKo = '''
이용약관
최종 업데이트: 2026년 4월

1. 동의
RunDone를 사용함으로써 본 이용약관에 동의하는 것으로 간주됩니다.

2. 라이선스
RunDone는 개인적, 비상업적 목적으로 앱을 사용할 수 있는 제한적, 비독점적, 양도 불가능한 라이선스를 부여합니다.

3. 금지 행위
앱을 역공학, 수정 또는 배포할 수 없습니다. 불법적인 목적으로 앱을 사용하는 것은 금지됩니다.

4. GPS 및 안전
RunDone는 GPS 위치를 사용합니다. 달리기 중 항상 주변 환경에 주의하세요. 사고나 부상에 대해 당사는 책임지지 않습니다.

5. 면책 조항
앱은 어떠한 보증도 없이 "있는 그대로" 제공됩니다. GPS 데이터 또는 영역 계산의 정확성을 보장하지 않습니다.

6. 인앱 구매
Pro 기능은 1회 인앱 구매로 이용 가능합니다. 법적으로 요구되지 않는 한 모든 구매는 최종적이며 환불되지 않습니다.

7. 변경
당사는 언제든지 본 약관을 수정할 권리를 보유합니다. 앱의 계속 사용은 변경된 약관에 동의한 것으로 간주됩니다.

8. 문의
문의사항은 앱 스토어 페이지를 통해 연락해 주세요.
''';
}
