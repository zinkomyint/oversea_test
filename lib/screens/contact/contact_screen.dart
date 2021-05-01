import 'package:borderlessWorking/bloc/contact_bloc/contact_bloc.dart';
import 'package:borderlessWorking/data/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactBloc _newsBloc = ContactBloc();

  @override
  void initState() {
    _newsBloc.add(GetContactList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact List')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is ContactFail) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactInitial) {
                return _buildLoading();
              } else if (state is ContactSuccess) {
                List<ContactModel> contacts = state.contacts;
                return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, position) {
                      return item(contacts[position], context);
                      // return ContactList(contacts[position],context);
                    });
              } else if (state is ContactFail) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildLoading() => Center(child: CircularProgressIndicator());

// Widget _buildCard(BuildContext context, ContactModel model) {
//   return ListView.builder(
//     itemCount: model.length,
//     itemBuilder: (context, index) {
//       return Container(
//         margin: EdgeInsets.all(8.0),
//         child: Card(
//           child: Container(
//             margin: EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 Text("ID: ${model.id}"),
//                 Text("Name: ${model.name}"),
//                 Text("Job: ${model.job}"),
//                 Text("Age: ${model.age}"),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

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
