part of 'Helpers.dart';

void modalSuccess( BuildContext context, String text, VoidCallback onPressed ){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) 
      => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            height: 250,
            child: Column(
              children: [
                Row(
                  children: [
                    TextFrave(text: 'Frave ', color: ColorsFrave.primaryColor, fontWeight: FontWeight.w500 ),
                    TextFrave(text: 'Food', fontWeight: FontWeight.w500),
                  ],
                ),
                Divider(),
                SizedBox(height: 10.0),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.white,
                        Color(0xff30d598)
                      ]
                    )
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff15c880)
                    ),
                    child: Icon(FontAwesomeIcons.check, color: Colors.white, size: 38),
                  ),                  
                ),
                SizedBox(height: 35.0),
                TextFrave(text: text, fontSize: 17, fontWeight: FontWeight.w400 ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: onPressed,
                  child: Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xff15c880),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: TextFrave(text: 'Done', color: Colors.white, fontSize: 16 ),
                  ),
                )
              ],
            ),
          ),
      ),
  );

}