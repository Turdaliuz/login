import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 80),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                "Tizimga kirish",
                style: TextStyle(
                    fontFamily: 'Josef',
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                    color: Colors.indigo),
              )),
              const SizedBox(height: 56),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: 376,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 28),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Login',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 44,
                    width: 376,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 12),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Parol',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Parolni unutganmisiz ?',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(300, 44),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Kirish',
                    style: TextStyle(
                        letterSpacing: 2, color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'No account yet ?',
                    style: TextStyle(color: Colors.blueGrey),
                  )),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Ro'yxatdan o'tish",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.cyan,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
