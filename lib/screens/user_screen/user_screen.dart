import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson47_1/components/userinfocard.dart';
import 'package:lesson47_1/models/user_model.dart';
import 'package:lesson47_1/screens/user_screen/bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc bloc;
  late UserModel userModel;

  @override
  void initState() {
    bloc = UserBloc();
    bloc.add(GetUserEvent());
    userModel = UserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(GetUserEvent());
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<UserBloc, UserState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is UserErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message.toString())));
                }
              },
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is UserErrorState) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        bloc.add(GetUserEvent());
                      },
                      child: const Text("Обновить"),
                    ),
                  );
                }

                if (state is UserFetchedState) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.grey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CachedNetworkImage(
                              imageUrl: state.userModel.results?.first.picture
                                      ?.medium ??
                                  "",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 50,
                                color: Colors.white,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(state.userModel.results?.first.name?.first ?? ''),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.blue[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  // height: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.amber[200]),
                                  child: Column(
                                    children: [
                                      UserInfoCard(
                                        name: 'name:',
                                        value: 'value',
                                        istitle: true,
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      UserInfoCard(
                                        name: 'country:',
                                        value: state.userModel.results?.first
                                                .location?.country ??
                                            '',
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      UserInfoCard(
                                        name: 'state:',
                                        value: state.userModel.results?.first
                                                .location?.state ??
                                            "",
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      UserInfoCard(
                                        name: 'city:',
                                        value: state.userModel.results?.first
                                                .location?.city ??
                                            '',
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      UserInfoCard(
                                        name: 'street:',
                                        value: state.userModel.results?.first
                                                .location?.street?.name ??
                                            '',
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      UserInfoCard(
                                        name: 'postcode:',
                                        value: state.userModel.results?.first
                                                .location?.postcode
                                                .toString() ??
                                            '',
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      bloc.add(GetUserEvent());
                                    },
                                    child: Icon(Icons.refresh))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
