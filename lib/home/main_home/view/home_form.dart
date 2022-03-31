import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../bloc/home_bloc.dart';
import '../page_bloc/page_bloc.dart';

/*class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }
   AuthenticationBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final user = context.select(
                      (AuthenticationBloc bloc) => bloc.state.user.name,
                );
                return Text('UserID: $user');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeForm());
  }

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  late PageController _pageController;

  //late AuthenticationBloc bloc;
  final int _currentIndex = 0;
  bool isLoading = false;
  bool hasErrorOccured = false;

  @override
  void initState() {
    super.initState();
    //bloc = BlocProvider.of<AuthenticationBloc>(context);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageBloc, PageState>(
      listener: (_, state) {
        switch (state.status) {
          case FormStatus.submissionInProgress:
            isLoading = true;
            break;
          case FormStatus.submissionSuccess:
            _pageController.animateToPage(state.currentIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isLoading = false;
              });
            });

            break;

          case FormStatus.submissionFailure:
            context.read<PageBloc>().add(PageIndexChanged(state.currentIndex - 1));
            hasErrorOccured = true;
            break;
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              /*ModuleForm(currentIndex: state.currentIndex),
              const SearchPage(),
              const SearchPage(),
              const SearchPage(),*/
            ],
          ),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: state.currentIndex,
            onTap: (i) => context.read<PageBloc>().add(PageIndexChanged(i)),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.view_module),
                title: const Text("Modüller"),
                selectedColor: Colors.purple,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Arama"),
                selectedColor: Colors.pink,
              ),

              /// Notification
            /*  SalomonBottomBarItem(
                icon: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Stack(
                      children: <Widget>[
                        const Icon(Icons.notifications),
                        Positioned(
                            right: 0,
                            child: state.notificationCount > 0
                                ? Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Text(
                                      state.notificationCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ))
                                : Container())
                      ],
                    );
                  },
                ),
                title: const Text('Bildirimler'),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.supervisor_account),
                title: const Text("Hesabım"),
                selectedColor: Colors.teal,
              ),*/
            ],
          ),
        );
      },
    );
  }
}
