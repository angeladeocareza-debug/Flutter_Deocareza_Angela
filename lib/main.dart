import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      home: const StudentProfile(),
    );
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();

  // Default gender
  String gender = 'Male';

  // Stores submitted information
  String submittedInfo = '';

  // Submit button function
  void submitForm() {
    // Check if all required fields are valid
    if (_formKey.currentState!.validate()) {
      setState(() {
        submittedInfo =
            'Full Name: ${fullNameController.text}\n'
            'Age: ${ageController.text}\n'
            'Gender: $gender\n'
            'Address: ${addressController.text}\n'
            'Contact Number: ${contactController.text}\n'
            'Email: ${emailController.text}';
      });
    } else {
      // Do not show old/blank submitted information
      setState(() {
        submittedInfo = '';
      });
    }
  }

  // Clear / Reset button function
  void clearForm() {
    // Clear all text fields
    fullNameController.clear();
    ageController.clear();
    addressController.clear();
    contactController.clear();
    emailController.clear();

    // Reset the form and submitted information
    setState(() {
      gender = 'Male';
      submittedInfo = '';
    });

    // Reset validation messages
    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    // Dispose controllers when the screen is removed
    fullNameController.dispose();
    ageController.dispose();
    addressController.dispose();
    contactController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile Form')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              const Text(
                'Student Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // FULL NAME
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // AGE
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Age is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // GENDER
              DropdownButtonFormField<String>(
                initialValue: gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value ?? 'Male';
                  });
                },
              ),

              const SizedBox(height: 15),

              // ADDRESS
              TextFormField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // CONTACT NUMBER
              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Contact Number is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // EMAIL
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // SUBMIT BUTTON
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),

              const SizedBox(height: 10),

              // CLEAR / RESET BUTTON
              OutlinedButton(
                onPressed: clearForm,
                child: const Text('Clear / Reset'),
              ),

              const SizedBox(height: 25),

              // DISPLAY SUBMITTED INFORMATION
              if (submittedInfo.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Submitted Student Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          submittedInfo,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
