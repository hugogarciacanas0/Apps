import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  // Aqui s'inicialitza i mostra el widget arrel
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Widget arrel de l'aplicació.
  // S'encarrega de configurar el tema i la pàgina inicial.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M0489 - Apps - Form (A)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final String title = 'Salesians Sarrià 25/26';
  // Clau per accedir a l'estat del formulari (guardar, validar, llegir valors)
  final _formKey = GlobalKey<FormBuilderState>();

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
            // Títol del formulari
            const FormTitle(),
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------------------------------------------
                    // Grup d'etiqueta + eleccions (radio)
                    FormLabelGroup(
                      title: 'Please provide the speed of vehicle?',
                      subtitle: 'please select one option given below',
                    ),
                    // Radio group per seleccionar una velocitat
                    FormBuilderRadioGroup(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      name: "speed",
                      orientation: OptionsOrientation.vertical,
                      // separator: const Padding(padding: EdgeInsets.all(20)),
                      options: const [
                        FormBuilderFieldOption(value: 'abvoe 40km/h'),
                        FormBuilderFieldOption(value: 'below 40km/h'),
                        FormBuilderFieldOption(value: '0km/h')
                      ],
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    // Camp de text per afegir observacions
                    FormLabelGroup(title: 'Enter remarks'),
                    FormBuilderTextField(
                      name: 'remark',
                      // Com ser l'estil del camp de text
                      decoration: InputDecoration(
                        hintText: 'Enter your remarks',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                      ),
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    // grup del Dropdown per seleccionar una opció
                    FormLabelGroup(
                      title: 'Please provide the high speed of vehicle?',
                      subtitle: 'please select one option given below',
                    ),
                    //dropdown per seleccionar tipus de velocitat
                    FormBuilderDropdown(
                      name: 'highspeed',
                      decoration: InputDecoration(
                        hintText: 'Select option',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      //items del dropdown
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('High')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Medium')),
                        DropdownMenuItem(value: 'low', child: Text('Low')),
                      ],
                      onChanged: (String? value) {
                        debugPrint(value);
                      },
                    ),
                    // Checkbox group per seleccionar múltiples velocitats
                    FormLabelGroup(
                      title: 'Please provide the speed of vehicle past 1 hour?',
                      subtitle: 'please select one or more options given below',
                    ),
                    FormBuilderCheckboxGroup(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      name: "selectSpeed",
                      orientation: OptionsOrientation.vertical,
                      // separator: const Padding(padding: EdgeInsets.all(20)),
                      // opcions del checkbox group
                      options: const [
                        FormBuilderFieldOption(value: '20km/h'),
                        FormBuilderFieldOption(value: '30km/h'),
                        FormBuilderFieldOption(value: '40km/h'),
                        FormBuilderFieldOption(value: '50km/h'),
                      ],
                      onChanged: (List<String>? value) {
                        debugPrint(value.toString());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Botó flotant per validar el formulari i mostrar els valors
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.upload),
          onPressed: () {
            _formKey.currentState?.saveAndValidate();
            String? formString = _formKey.currentState?.value.toString();
            alertDialog(context, formString!);
          }),
    );
  }
}

// Component reutilitzable per mostrar un títol d'un bloc del formulari
// i una línia subtitle.
// Manté la presentació uniforme per a radio, checkbox, dropdown, etc.
// ignore: must_be_immutable
class FormLabelGroup extends StatelessWidget {
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  // Retorna el widget del subtítol només si existeix
  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(subtitle!,
          style: Theme.of(context).textTheme.labelLarge?.apply(
              fontSizeFactor: 1.25,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)));
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
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.apply(fontSizeFactor: 1.25)),
          conditionalSubtitle(context)
        ],
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
  });
  // Widget que mostra el títol i la descripció curta del formulari
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Form title',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text('description', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  // Mostra un diàleg amb el contingut del formulari enviat
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          // 'Tancar' tanca el diàleg
          onPressed: () => Navigator.pop(context, 'Tancar'),
          child: const Text('Tancar'),
        ),
      ],
    ),
  );
}
