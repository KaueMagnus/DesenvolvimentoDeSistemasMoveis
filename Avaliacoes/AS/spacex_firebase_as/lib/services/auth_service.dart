import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      print("Login realizado com sucesso: ${result.user?.email}");
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Erro Firebase Login: ${e.code} - ${e.message}");
      throw e.message ?? "Erro desconhecido no login";
    } catch (e) {
      print("Erro genérico Login: $e");
      throw "Erro ao tentar logar: $e";
    }
  }

  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      await result.user?.updateDisplayName(name);
      print("Cadastro realizado: ${result.user?.email}");
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Erro Firebase Cadastro: ${e.code}");
      if (e.code == 'weak-password') throw 'A senha é muito fraca.';
      if (e.code == 'email-already-in-use') throw 'Este e-mail já está cadastrado.';
      throw e.message ?? "Erro ao cadastrar";
    } catch (e) {
      throw "Erro genérico no cadastro: $e";
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}