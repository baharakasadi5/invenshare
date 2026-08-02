// lib/features/inventions/presentation/pages/invention_details_page.dart

import 'package:flutter/material.dart';

import '../../domain/entities/invention.dart';


class InventionDetailsPage extends StatelessWidget {

  final Invention invention;


  const InventionDetailsPage({
    super.key,
    required this.invention,
  });



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'جزئیات اختراع',
        ),

      ),



      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),


        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          children: [


            _buildTitle(
              context,
              invention.title,
            ),



            const SizedBox(height:20),



            _buildCard(
              icon: Icons.description_outlined,
              title: 'توضیحات',
              value: invention.description,
            ),



            _buildCard(
              icon: Icons.category_outlined,
              title: 'دسته‌بندی',
              value: invention.category,
            ),



            _buildCard(
              icon: Icons.person_outline,
              title: 'نام مخترع',
              value: invention.inventorName,
            ),



            _buildCard(
              icon: Icons.calendar_today_outlined,
              title: 'تاریخ ثبت',
              value:
                  '${invention.createdAt.year}/${invention.createdAt.month}/${invention.createdAt.day}',
            ),



            _buildCard(
              icon: Icons.info_outline,
              title: 'وضعیت',
              value: invention.status,
            ),



            _buildCard(
              icon: Icons.auto_awesome,
              title: 'تحلیل هوش مصنوعی',
              value: invention.aiAnalysis,
            ),



            const SizedBox(height:20),



            const Text(
              'تصاویر اختراع',
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(height:10),



            if(invention.images.isEmpty)

              const Text(
                'تصویری ثبت نشده است',
              )

            else

              Wrap(

                spacing:10,

                children: invention.images.map(
                  (image){

                    return Container(

                      width:100,

                      height:100,

                      decoration: BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(12),

                        image: DecorationImage(

                          image: NetworkImage(image),

                          fit: BoxFit.cover,

                        ),

                      ),

                    );

                  },

                ).toList(),

              ),


          ],

        ),

      ),

    );

  }



  Widget _buildTitle(
      BuildContext context,
      String title,
      ){

    return Text(

      title,

      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(
            fontWeight: FontWeight.bold,
          ),

    );

  }




  Widget _buildCard({

    required IconData icon,

    required String title,

    required String value,

  }){


    return Card(

      margin:
          const EdgeInsets.only(bottom:12),


      child: ListTile(

        leading: Icon(icon),


        title: Text(

          title,

          style: const TextStyle(

            fontWeight: FontWeight.bold,

          ),

        ),


        subtitle: Padding(

          padding:
              const EdgeInsets.only(top:6),

          child: Text(value),

        ),

      ),

    );

  }


}