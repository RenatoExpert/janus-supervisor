import 'package:flutter/material.dart';
import 'communicator.dart';
import 'dart:convert';
import 'dart:async';

class Server {
	final StreamController _controller = StreamController<int>();
	Map<String:String> _Current_States = {};
	fetch_states() {
		Timer.periodic(Duration(seconds: 1), (timer) {
			_controller.sink.add(_Current_States);
			Map<String, String> NewStates = jsonDecode(await Net.talk_to_server());
			if NewStates is Map _Current_States = NewStates;
			_controller.sink.close();
		})
	}
	Stream<int> get stream => _controller.stream;
}
final estados = Server().stream;
final subscription = estados.listen(
	(data) {
		print('Data: $data');
	},
	onDone: () {
		print('Concluido');
	}
);

class DeviceDisplay extends StatefulWidget {
	final String devtag;
	DeviceDisplay(@required this.devtag);
	@override
	_DeviceDisplayState createState() => _DeviceDisplayState(this.devtag);
}

class GenericIconButton extends StatefulWidget {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	GenericIconButton(@required this.iconsym, @required this.radical, @required this.gadget_index);
	@override
	_GenericIconButtonState createState() => _GenericIconButtonState(this.iconsym, this.radical, this.gadget_index);
}

class _GenericIconButtonState extends State<GenericIconButton> {
	final IconData iconsym;
	final String radical;
	final int gadget_index;
	bool lock_state () => Current_States['j324u']=='333' ? true:false;
	final revert_button = () {
			update_states();
	};
	get tooltip_render { 
		var execution = lock_state() ? 'Allowed' : 'Disabled';
		var inverse = lock_state() ? 'disable' : 'enable';
		return "${radical} is ${execution}. Click to ${inverse}";
	}
	get iconColor {
		return lock_state() ? Colors.green : Colors.black;
	}
	_GenericIconButtonState(@required this.iconsym, @required this.radical, @required this.gadget_index);
	@override
	Widget build(BuildContext context) {
		return IconButton(
			icon: Icon(
				iconsym,
				color: iconColor,
				semanticLabel: radical,
				size: 30,
			),
			onPressed: () {
				setState(() {
					revert_button();
				});
			},
			tooltip: tooltip_render,
		);
	}	
}

class _DeviceDisplayState extends State<DeviceDisplay> {
	final String devtag;
	_DeviceDisplayState(@required this.devtag);
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(devtag),
					Row (
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							GenericIconButton (Icons.lock, 'Lock', 0),
							GenericIconButton (Icons.lightbulb, 'Light', 1),
							GenericIconButton (Icons.ac_unit, 'Air conditioner', 2),
						], //   row's children
					), //   row 
				], //   columns' children
			), //   column
		); //	Center
	} //	Widget
} //    class

