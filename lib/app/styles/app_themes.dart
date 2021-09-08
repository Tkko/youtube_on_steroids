import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_on_steroids/app/app.dart';

const kLM_FIRST_LEVEL = const Color.fromRGBO(243, 243, 246, 1);
const kLM_SECOND_LEVEL = const Color.fromRGBO(243, 243, 246, 1);
const kLM_THIRD_LEVEL = const Color.fromRGBO(243, 243, 246, 1);
const kLM_MAIN_COLOR = const Color.fromRGBO(255, 255, 255, 1);
const kLM_TEXT_PRIMARY = const Color.fromRGBO(39, 42, 55, 1);

class AppThemes {
  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: kLM_FIRST_LEVEL,
        primaryColor: kLM_FIRST_LEVEL,
        accentColor: kLM_TEXT_PRIMARY,
        cardColor: kLM_SECOND_LEVEL,
        appBarTheme: AppBarTheme(
          backgroundColor: kLM_SECOND_LEVEL,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kLM_TEXT_PRIMARY,
          ),
        ),
        textTheme: TextTheme(
          headline6: GoogleFonts.poppins(
            color: kLM_TEXT_PRIMARY,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: GoogleFonts.poppins(
            fontSize: 16,
            color: kLM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
          ),
          bodyText1: GoogleFonts.poppins(
            fontSize: 14,
            color: kLM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
          ),
          caption: GoogleFonts.poppins(
            fontSize: 12,
            color: kLM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
          ),
          button: GoogleFonts.poppins(
            fontSize: 16,
            color: kLM_TEXT_PRIMARY,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}
