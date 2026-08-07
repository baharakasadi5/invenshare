import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'InvenShare'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myInventions.
  ///
  /// In en, this message translates to:
  /// **'My Inventions'**
  String get myInventions;

  /// No description provided for @addInvention.
  ///
  /// In en, this message translates to:
  /// **'Add Invention'**
  String get addInvention;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Invention Details'**
  String get details;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @inventorName.
  ///
  /// In en, this message translates to:
  /// **'Inventor Name'**
  String get inventorName;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @aiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis'**
  String get aiAnalysis;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @searchInventions.
  ///
  /// In en, this message translates to:
  /// **'Search inventions...'**
  String get searchInventions;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noInventionFound.
  ///
  /// In en, this message translates to:
  /// **'No invention found'**
  String get noInventionFound;

  /// No description provided for @deleteInvention.
  ///
  /// In en, this message translates to:
  /// **'Delete Invention'**
  String get deleteInvention;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteConfirm;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No invention has been added to favorites yet'**
  String get noFavorites;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter invention title'**
  String get enterTitle;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @initialRegistration.
  ///
  /// In en, this message translates to:
  /// **'Initial Registration'**
  String get initialRegistration;

  /// No description provided for @addNewInvention.
  ///
  /// In en, this message translates to:
  /// **'Add New Invention'**
  String get addNewInvention;

  /// No description provided for @inventionTitle.
  ///
  /// In en, this message translates to:
  /// **'Invention Title'**
  String get inventionTitle;

  /// No description provided for @inventionDescription.
  ///
  /// In en, this message translates to:
  /// **'Invention Description'**
  String get inventionDescription;

  /// No description provided for @saveInvention.
  ///
  /// In en, this message translates to:
  /// **'Save Invention'**
  String get saveInvention;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Registration Date'**
  String get date;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Invention Images'**
  String get images;

  /// No description provided for @noImages.
  ///
  /// In en, this message translates to:
  /// **'No image has been added'**
  String get noImages;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @editInvention.
  ///
  /// In en, this message translates to:
  /// **'Edit Invention'**
  String get editInvention;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A platform for registering, managing and developing ideas and inventions'**
  String get appDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @technology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get technology;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Inventor Dashboard'**
  String get dashboard;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Inventor Profile'**
  String get profileTitle;

  /// No description provided for @profileInventor.
  ///
  /// In en, this message translates to:
  /// **'Inventor Profile'**
  String get profileInventor;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Image'**
  String get profileImage;

  /// No description provided for @notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'No user logged in'**
  String get notLoggedIn;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @inventor.
  ///
  /// In en, this message translates to:
  /// **'Inventor and Innovator'**
  String get inventor;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity Statistics'**
  String get activity;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @inventions.
  ///
  /// In en, this message translates to:
  /// **'Inventions'**
  String get inventions;

  /// No description provided for @ideas.
  ///
  /// In en, this message translates to:
  /// **'Ideas'**
  String get ideas;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Profile Progress'**
  String get progress;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Return to Login Page'**
  String get backToLogin;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @registerIdea.
  ///
  /// In en, this message translates to:
  /// **'Register New Idea'**
  String get registerIdea;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get bio;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @membership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @specialtyHint.
  ///
  /// In en, this message translates to:
  /// **'Example: AI, Architecture, Mechanics'**
  String get specialtyHint;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Write about yourself and your innovative activities'**
  String get bioHint;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved successfully'**
  String get profileSaved;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter username and password'**
  String get loginRequired;

  /// No description provided for @invalidLogin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username or password'**
  String get invalidLogin;

  /// No description provided for @loginToApp.
  ///
  /// In en, this message translates to:
  /// **'Login to InvenShare'**
  String get loginToApp;

  /// No description provided for @noAccountRegister.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get noAccountRegister;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registerSuccess;

  /// No description provided for @createInventorAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Inventor Account'**
  String get createInventorAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @specialtyHintRegister.
  ///
  /// In en, this message translates to:
  /// **'Example: Architecture, AI, Mechanics'**
  String get specialtyHintRegister;

  /// No description provided for @bioHintRegister.
  ///
  /// In en, this message translates to:
  /// **'Write about yourself and your ideas'**
  String get bioHintRegister;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @languageOptions.
  ///
  /// In en, this message translates to:
  /// **'Persian / English'**
  String get languageOptions;

  /// No description provided for @backupData.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get backupData;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create backup of inventions'**
  String get createBackup;

  /// No description provided for @backupCreated.
  ///
  /// In en, this message translates to:
  /// **'Backup created:'**
  String get backupCreated;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreData;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup file'**
  String get restoreBackup;

  /// No description provided for @restoreCompleted.
  ///
  /// In en, this message translates to:
  /// **'Restore completed'**
  String get restoreCompleted;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Application'**
  String get aboutApp;

  /// No description provided for @versionInfo.
  ///
  /// In en, this message translates to:
  /// **'InvenShare Version 1.0.0'**
  String get versionInfo;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @registerError.
  ///
  /// In en, this message translates to:
  /// **'Registration error'**
  String get registerError;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
