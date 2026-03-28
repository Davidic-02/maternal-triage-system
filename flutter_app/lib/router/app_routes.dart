class AppRoutes {
  // ── Public (no auth) ─────────────────────────
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const forgotPassword = '/login/forgot-password';
  static const results = '/results';

  // ── Main app (after login) ───────────────────
  static const triage = '/triage';
  static const assessment = '/assessment';
  static const resources = '/resources';
  static const history = '/history';

  // ── Dynamic routes ───────────────────────────
  static const patientDetail = '/triage/:id';
  static const historyDetail = '/history/:id';

  // ── Helpers (VERY IMPORTANT 🔥) ──────────────
  static String patientDetailPath(String id) => '/triage/$id';
  static String historyDetailPath(String id) => '/history/$id';
}
