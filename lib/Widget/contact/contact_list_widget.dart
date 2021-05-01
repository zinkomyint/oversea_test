import 'package:borderlessWorking/data/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget buildLoading() => Center(child: CircularProgressIndicator());

Widget item(ContactModel model, BuildContext context) {
  return Card(
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          icon: Icons.edit,
          color: Colors.blue,
          onTap: () async {
            // var result = await Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => EditContactScreen(contact)));
            // if (result != null && result == 'success') {
            //   BlocProvider.of<GetcontactCubit>(context).getContact();
            //}
          },
        )
      ],
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            // context.bloc<GetcontactCubit>().delete(contact.id.toString());
          },
        )
      ],
      child: ListTile(
        onTap: () {
          // Get.to(AddContactScreen());
        },
        title: Text(model.name),
        subtitle: Text(model.job),
        trailing: Text('age ${model.age}'),
      ),
    ),
  );
}
