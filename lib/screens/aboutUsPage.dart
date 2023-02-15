import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/aboutusbg.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        "assets/freelanceNepalDp.jpg",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Freelance",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Nepal",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Freelance Nepal is modern platform where the skills of Nepalese freelancers meet some innovative tasks. People who wish to get their problems solved by the best brains of the country can be of help by using this app!",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "This application was developed by Aryan Pokharel as part of the final assignment of the Android Applications Development module. Although the works can be done in this application, some major features of this application are still under development.",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "The freelancers as well as the hirers can look for their required services in a single place and the services are best priced in Freelance Nepal app. We aim at both client and freelancer satisfaction.",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "Team Freelance Nepal wishes that freelancers as well as the clients are best satisfied with their works and we aim at producing more freelancers in the country by providing them a platform to expose their skills and make some money!",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "This app is aimed at uplifting the economy of the country as well as we aim at selling the skills and services of Nepalses freelancers to clients abroad. With this, forign currency can be earned by the freelancers by staying within the country and this would directly aid the foreign reserve of Nepal!",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
