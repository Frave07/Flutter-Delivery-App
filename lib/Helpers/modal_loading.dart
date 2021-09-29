part of 'Helpers.dart';

void modalLoading(BuildContext context){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextFrave(text: 'Frave ', color: ColorsFrave.primaryColor, fontWeight: FontWeight.w500 ),
                  TextFrave(text: 'Food', fontWeight: FontWeight.w500),
                ],
              ),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                children: [
                  CircularProgressIndicator( color: ColorsFrave.primaryColor),
                  SizedBox(width: 15.0),
                  TextFrave(text: 'Loading...')
                ],
              ),
            ],
          ),
        ),
      ),
  );

}