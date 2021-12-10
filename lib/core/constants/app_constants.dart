///This is the time limit for every api call
const Duration timeOutDuration = Duration(seconds: 30);

const String connectionFailedString = 'La connexion a échoué, vérifier votre connexion internet SVP';

/// exception status code
const int timeoutStatusCode = 900;
const int runtimeExceptionStatusCode = 800;
const int socketExceptionStatusCode = 700;
const String timeoutExceptionMessage = "le serveur n'a pas répondu à temps nécessaire, essayez ultérieurement";

/// shared pref keys
const String tokenKey = 'Token';
const String userIdPushNotification = 'userIdPushNotif';
const String authorisationToken = 'authorisationToken';
const String localLanguageKey = 'localLanguage';
const String phoneKey = 'username';
const String firstLaunchKey = 'FirstLaunch';
const String userModelKey = 'userModel';
const String biometricsCodeKey = 'bioCode';
const String currenTheme = 'currenTheme';
const String isDarkMode = 'isDarkMode';
const String themeDataEnum = 'themeDataEnum';
const String offerStoredId = 'offerStoredId';
const String isDarkModeActivated = 'isDarkModeActivated';

/// http client header constants
const String acceptLanguageKey = 'Accept-Language';
const String authorisationKey = 'Authorization';
const String bearerKey = 'Bearer ';
const String contentTypeKey = 'Content-Type';
const String contentTypeValue = 'application/json';
const String contentMutlipartTypeValue = 'multipart/form-data';
const String userPhoneNumberKey = 'userPhoneNumber';

///base url
const String baseUrl = 'https://jsonplaceholder.typicode.com/';
