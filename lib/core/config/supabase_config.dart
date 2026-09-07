abstract final class SupabaseConfig {
  static bool initialized = false;
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://lvunvsuasewpzgnlhwdd.supabase.co',
  );
  static const anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_0bByEF0kYfo0JCvxMSMqcg_vURgYZRp',
  );

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}