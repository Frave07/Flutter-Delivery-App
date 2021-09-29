part of 'Helpers.dart';

void errorMessageSnack(BuildContext context, String error){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextFrave(text: error, color: Colors.white), 
      backgroundColor: Colors.red
    )
  );

}