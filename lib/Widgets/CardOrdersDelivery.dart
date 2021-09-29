part of 'Widgets.dart';


class CardOrdersDelivery extends StatelessWidget {

  final OrdersResponse orderResponse;
  final VoidCallback? onPressed;

  const CardOrdersDelivery({required this.orderResponse, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFrave(text: 'ORDER ID: ${orderResponse.orderId}'),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: 'Date', fontSize: 16, color: ColorsFrave.secundaryColor),
                  TextFrave(text: DateFrave.getDateOrder(orderResponse.currentDate.toString()), fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(text: 'Client', fontSize:16, color: ColorsFrave.secundaryColor),
                  TextFrave(text: orderResponse.cliente!, fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              TextFrave(text: 'Address shipping', fontSize: 16, color: ColorsFrave.secundaryColor),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextFrave(text: orderResponse.reference!, fontSize: 16, maxLine: 2)
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}