import 'package:flutter/cupertino.dart';
import '../../const/models/region_model.dart';
import '../../const/regions/region_list.dart';
import 'buttons/dropdown_button.dart';

class RegionDropdownWidget extends StatefulWidget {
  const RegionDropdownWidget({super.key});

  @override
  State<RegionDropdownWidget> createState() => _RegionDropdownWidgetState();
}

class _RegionDropdownWidgetState extends State<RegionDropdownWidget> {
  var currentState;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownButton(
          dropDownList: regionList,
          //region리스트의 요소와 현재 클릭된 요소가 같으면 setstate
          onPressed: (e){
            setState(() {
              currentState = State_.getStateByName(e);
            });
          },),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: DropDownButton(dropDownList: currentState.cities)),
            Flexible(
                fit: FlexFit.tight,
                child: DropDownButton(dropDownList: null)),
          ],
        ),
      ],
    );
  }
}
