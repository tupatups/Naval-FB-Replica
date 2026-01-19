import 'package:naval_mobprog/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/detail_screen.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    required this.name,
    required this.post,
    required this.description,
    this.icon = const Icon(Icons.person),
    this.profileImageUrl = "assets/images/TupeDP.jpg",
    this.atProfile = false,
    required this.date,
    this.imageUrl = "assets/images/golden.jpg",
    required this.numOfLikes,
  });

  final String name;
  final String post;
  final String description;
  final Icon icon;
  final String profileImageUrl;
  final String date;
  final int numOfLikes;
  final String imageUrl;
  final bool atProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(15)),
      child: InkWell(
        onTap: () {
          (atProfile)
              ? print('')
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      userName: name,
                      postContent: description,
                      date: date,
                      numOfLikes: numOfLikes,
                      imageUrl: imageUrl,
                      profileImageUrl: profileImageUrl,
                    ),
                  ),
                );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(17)),
              child: CircleAvatar(
                radius: ScreenUtil().setSp(25),
                backgroundImage: AssetImage(profileImageUrl),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: name,
                    fontSize: ScreenUtil().setSp(18),
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  CustomFont(
                    text: "Posted: $post",
                    fontSize: ScreenUtil().setSp(13),
                    color: Colors.black,
                  ),
                  CustomFont(
                    text: description,
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  CustomFont(
                    text: date,
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: const Icon(Icons.more_horiz, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // Notification 1
          CustomInformation(
            name: "Trisha Eunnisseh",
            post: "Zoo Visit",
            description: "uy may owl",
            date: "March 5, 2026",
            numOfLikes: 45,
            profileImageUrl: "assets/images/JoseDP.jpg",
            imageUrl: "assets/images/owl.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Riley",
            post: "strolling",
            description: "Si bini mikha",
            date: "March 4, 2026",
            numOfLikes: 23,
            profileImageUrl: "assets/images/TupeDP.jpg",
            imageUrl: "assets/images/owl.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Chumi",
            post: "Hiking with pares eating",
            description: "reached the summit after 2 minutes",
            date: "March 3, 2026",
            numOfLikes: 67,
            profileImageUrl: "assets/images/TupeDP.jpg",
            imageUrl: "assets/images/JoseDP.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

        
          CustomInformation(
            name: "RyMi",
            post: "Food Trip na may Bad Trip",
            description: "best ramen in Manila hands down kay bini mikhamot",
            date: "March 2, 2026",
            numOfLikes: 89,
            profileImageUrl: "assets/images/JoseDP.jpg",
            imageUrl: "assets/images/binimikha.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Baba",
            post: "Workout Session",
            description: "morning gym grind never stops",
            date: "March 1, 2026",
            numOfLikes: 34,
            profileImageUrl: "assets/images/JoseDP.jpg",
            imageUrl: "assets/images/cat.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

         
          CustomInformation(
            name: "Seungcheol",
            post: "Book Reading",
            description: "finished this amazing novel today",
            date: "February 28, 2026",
            numOfLikes: 12,
            profileImageUrl: "assets/images/TupeDP.jpg",
            imageUrl: "assets/images/cat.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Mingyu",
            post: "Pet Care",
            description: "my cat's first vet visit went well",
            date: "February 27, 2026",
            numOfLikes: 56,
            profileImageUrl: "assets/images/JoseDP.jpg",
            imageUrl: "assets/images/cat.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Joshua",
            post: "Gaming Night",
            description: "finally reached diamond rank",
            date: "February 26, 2026",
            numOfLikes: 41,
            profileImageUrl: "assets/images/TupeDP.jpg",
            imageUrl: "assets/images/binimikha.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Briee",
            post: "Art Project",
            description: "spent 3 days on this painting",
            date: "February 25, 2026",
            numOfLikes: 78,
            profileImageUrl: "assets/images/owl.jpg",
            imageUrl: "assets/images/binimikha.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),

          
          CustomInformation(
            name: "Japeth",
            post: "Concert Experience",
            description: "best night ever at the music festival",
            date: "February 24, 2026",
            numOfLikes: 92,
            profileImageUrl: "assets/images/TupeDP.jpg",
            imageUrl: "assets/images/binimikha.jpg",
          ),
          const Divider(height: 1, thickness: 0.5),
        ],
      ),
    );
  }
}