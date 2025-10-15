
class AppConstants {
  // App Information
  static const String appName = 'Cloud Task';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://ibockwwxokdypenewkkv.supabase.co';
  static const String supabaseAnonKey = 
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlib2Nrd3d4b2tkeXBlbmV3a2t2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1MDQ4NzIsImV4cCI6MjA3NjA4MDg3Mn0.Irlv1QXK55bGwf8xwPN-BaIj5wqrbl-wzHOj5fnYxoQ';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';

  // Animation Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  
  // Padding & Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 100.0;

  // Icons
  static const double iconSizeXS = 16.0;
  static const double iconSizeS = 20.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;

  // Buttons
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  static const double buttonBorderRadius = 12.0;

  // Input Fields
  static const double inputBorderRadius = 12.0;
  static const double inputBorderWidth = 1.0;
  static const double inputFocusedBorderWidth = 2.0;
  
  // Cards
  static const double cardElevation = 2.0;
  static const double cardBorderRadius = 16.0;
  
  // Dialogs
  static const double dialogBorderRadius = 20.0;
  
  // Bottom Sheets
  static const double bottomSheetBorderRadius = 24.0;
  
  // Snackbars
  static const double snackbarElevation = 6.0;
  
  // App Bar
  static const double appBarElevation = 0.0;
  
  // Dividers
  static const double dividerThickness = 1.0;
  
  // Grid
  static const double gridSpacing = 16.0;
  
  // Hero Tags
  static String heroTag(String tag, [String? suffix]) => 
      suffix != null ? '${tag}_$suffix' : tag;
      
  // Form Validations
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }
  
  // Date & Time Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'dd/MM/yyyy hh:mm a';
  
  // Default Values
  static const int defaultPageSize = 10;
  static const int defaultDebounceTime = 500; // milliseconds
  static const int defaultThrottleTime = 1000; // milliseconds
}
