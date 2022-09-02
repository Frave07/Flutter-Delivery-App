import 'dart:async';

class DeBouncer<T> {

  final Duration duration;
  void Function(T value)? onValue;

  DeBouncer({ required this.duration, this.onValue });

  
  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value( T val ){

    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!( _value! ));
  }


}