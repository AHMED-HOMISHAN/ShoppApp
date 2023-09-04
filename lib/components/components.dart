import 'package:flutter/material.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

Future<dynamic> navigateAndfinished(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Widget defaultButton(
    {required double width,
    required Function() function,
    required String label,
    Color buttonColor = primaryColorAccent,
    Color textColor = Colors.white,
    double radius = 8.0}) {
  return Container(
      width: width,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ));
}

// General Form

Widget defaultForm({
  required TextEditingController controller,
  required TextInputType type,
  required IconData prefixIcon,
  IconData? sufixIcon,
  bool validate = false,
  String validationMessage = 'This field is required',
  bool isPassword = false,
  required String label,
  required Function() suffixIconPressed,
  Function()? onSubmit,
  Color borderColor = primaryColorAccent,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword == true ? true : false,
    keyboardType: type,
    validator: validate == true
        ? (value) {
            if (value!.isEmpty) {
              return validationMessage;
            }
            if (isPassword == true && value.length < 4) {
              return 'The Password is too short';
            }
            return null;
          }
        : null,
    onTap: onSubmit,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      suffixIcon: sufixIcon != null
          ? GestureDetector(
              onTap: suffixIconPressed,
              child: Icon(sufixIcon),
            )
          : null,
      labelText: label,
      border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: borderColor)),
    ),
  );
}

messanger(
    {required BuildContext context,
    required String message,
    bool status = true}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: status ? primaryColor : Colors.redAccent,
  ));
}

Widget builderItem(model, BuildContext context, {isOldPrice = true}) =>
    Container(
      padding: const EdgeInsets.all(20.0),
      width: 120,
      height: 160,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.image),
                width: 120,
                height: 120,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ))
            ],
          ),
          horizantelSpacing,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0, height: 1.3)),
                const Spacer(),
                Row(
                  children: [
                    Text('${model.price.round()} \$',
                        style: const TextStyle(
                            fontSize: 12.0, color: primaryColor)),
                    horizantelSpacing,
                    if (model.oldPrice != 0 &&
                        isOldPrice &&
                        model.discount != 0)
                      Text('${model.oldPrice.round()} \$',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context)
                              .changeFavorites(model.id, context);
                        },
                        icon: Icon(
                            HomeCubit.get(context)
                                        .favorites[model.id] ==
                                    true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.0,
                            color: HomeCubit.get(context)
                                        .favorites[model.id] ==
                                    true
                                ? Colors.red
                                : Colors.black))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
