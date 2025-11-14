import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Pàgina principal de Upload
class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna la pàgina sense MaterialApp anidada
    return _UploadPage();
  }
}

class _UploadPage extends StatefulWidget {
  const _UploadPage();

  @override
  State<_UploadPage> createState() => __UploadPageState();
}

class __UploadPageState extends State<_UploadPage> {
  // Títol de l'AppBar
  final String title = 'Salesians Sarrià 25/26';
  // Clau per accedir al formulari
  final _formKey = GlobalKey<FormBuilderState>();

  // Guarda el formulari i mostra diàleg
  void _onContinue() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value.toString() ?? '';
      alertDialog(context, formData);
    }
  }

  // Tanca la pàgina
  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        // Columna amb el contingut principal de la pàgina
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            // Menú de pasos amb sombra
            Container(
              // Decoració amb sombra i vores arrodonides
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: const Icon(Icons.info, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Text('Pers.'),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Text('Contact'),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Upload'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Formulari principal
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Camp email
                    FormBuilderTextField(
                      name: 'email',
                      // Fons blanc, hint i border de color blau clar
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.lightBlue[200]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Camp adreça multilínia
                    FormBuilderTextField(
                      name: 'address',
                      // 3 a 5 línies de text
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: TextStyle(color: Colors.lightBlue[200]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18,
                        ),
                      ),
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    // Camp telèfon
                    FormBuilderTextField(
                      name: 'mobile',
                      decoration: InputDecoration(
                        hintText: 'Mobile No.',
                        hintStyle: TextStyle(color: Colors.lightBlue[200]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.lightBlue[200]!,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    // Botons Continue i Cancel
                    Row(
                      children: [
                        // Botó Continue
                        ElevatedButton(
                          onPressed: _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text('CONTINUE'),
                        ),
                        const SizedBox(width: 20),
                        // Botó Cancel
                        TextButton(
                          onPressed: _onCancel,
                          child: const Text('CANCEL'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Component no usat
// ignore: must_be_immutable
class FormLabelGroup extends StatelessWidget {
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  // Retorna el widget del subtítol només si existeix
  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(
        subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
          fontSizeFactor: 1.25,
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.apply(fontSizeFactor: 1.25),
          ),
          conditionalSubtitle(context),
        ],
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  const FormTitle({super.key});
  // Component no usat--> Per serveix per mostrar títol i descripció del formulari
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Form title',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text('description', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  // Mostra diàleg amb dades del formulari
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          // Botó per tancar
          onPressed: () => Navigator.pop(context, 'Tancar'),
          child: const Text('Tancar'),
        ),
      ],
    ),
  );
}
