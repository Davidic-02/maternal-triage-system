import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/services/toast_services.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login';
  @override
  Widget build(BuildContext context) {
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final obscurePassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return  Scaffold(body:
    
    BlocBuilder<AuthBloc,  AuthState>(
      buildWhen: (previous, current) {
        _loginBuildWhen(context, previous ,current),
      },
      
      
      builder: (context, state){
        return  const Column(
children: [
  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                        const Center(
                          child: Text(
                            'Login to Your Account',))
],
    ))))]);
      })
    
    
     );

  }




  _loginBuildWhen(
     BuildContext context,
    AuthState previous,
    AuthState current,
  ){
    if(previous.loginStatus != current.loginStatus && current.loginStatus.isSuccess){
ToastService.toast('Welcome!');
    }
  }
}
