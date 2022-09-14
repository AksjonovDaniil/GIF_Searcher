import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class GifPage extends StatefulWidget {
  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  final TextEditingController controller = TextEditingController();
  String url='';

  bool showLoading = false;

  String searchInput=" ";
  var data;

  //@override
  //void initState(){

  //}

  getData(String searchInput) async {
    showLoading = true;
    setState(() {

    });
    final res= await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=J9Qyx1o6FpPMIOjgokE4SMg7HOWsQp3G&q=$searchInput&limit=25&offset=0&rating=g&lang=en'));
    data = jsonDecode(res.body)["data"];
    setState(() {
      showLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray800,
      body: Column(
          children: [
            "GIF Searcher".text.white.xl5.make().objectCenter(),
            Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 3.0),
                        ),
                        labelText: "Search your GIF here",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ),
                30.widthBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Vx.gray800,
                    side: BorderSide(width: 2.0, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed:(){
                    getData(controller.text);
                  },
                  child: Text("Go",style: TextStyle(fontSize: 32.0),),
                ).h8(context),
              ],
            ).p8(),
            if (showLoading)
              CircularProgressIndicator().centered()
            else
              VxConditional(
                condition: data != null,
                builder: (context) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isMobile?2:3,
                    ),
                    itemBuilder: (context,index){
                      final url = data[index]["images"]["fixed_height"]["url"].toString();
                      return Image.network(url, fit: BoxFit.cover).card.roundedSM.make();
                    },
                    itemCount: data.length,
                ),
                fallback: (context) => "Can't find anything with that search keyword".text.gray500.xl3.make().objectCenter(),
            ).h(context.percentHeight * 70)
          ],
        ).p16().scrollVertical(physics: NeverScrollableScrollPhysics()),
    );
  }
}
