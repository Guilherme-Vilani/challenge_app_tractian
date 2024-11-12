import 'package:app_tractian/services/api_service.dart';
import 'package:app_tractian/views/assets/assets_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  ApiService apiService = Get.find();

  init() async {
    await apiService.getCompanies();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 23, 25, 45),
        title: Image.asset('assets/logo_tractian.png'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: apiService.companies.length,
                itemBuilder: (ctx, index) {
                  final company = apiService.companies[index];
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AssetsView(company.id),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Colors.blue,
                        ),
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(left: 32),
                        alignment: Alignment.center,
                        height: 76,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Image.asset("assets/companies.png"),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Text(
                                company.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
