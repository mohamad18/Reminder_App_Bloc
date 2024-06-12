import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/widgets/add_reminder_widget.dart';
import 'package:reminderapp_test/features/home/presentation/widgets/delete_reminder_widget.dart';
import 'package:reminderapp_test/features/home/presentation/widgets/edit_reminder_widget.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetListReminderEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Reminder App"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(ChangeThemeEvent());
            },
            icon: themeBloc.state.getModeIcon,
          ),
        ],
      ),
      body: _listReminder(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addReminder(context);
        },
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _loader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator()],
      ),
    );
  }

  Widget _listReminder(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state.loading == false) {
          context.read<HomeBloc>().add(GetListReminderEvent());
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.loading) {
            return SingleChildScrollView(
              child: Column(
                children: state.dataReminder!
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 5),
                            Divider(endIndent: 10, indent: 10),
                            SizedBox(height: 5),
                            Text("Desc : ${e.description}"),
                            Row(
                              children: [
                                Text(
                                    "Time : ${(e.hour > 12) ? e.hour - 12 : e.hour} : ${e.minute}  ${(e.hour > 12) ? "PM" : "AM"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    editReminder(reminder: e, context: context);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteReminder(
                                        idReminder: e.id, context: context);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }

          return _loader();
        },
      ),
    );
  }
}
