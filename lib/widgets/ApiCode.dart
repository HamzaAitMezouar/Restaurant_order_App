/*FutureBuilder<List<Item>>(
              future: itemController().getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print('NoDataaa');
                  Container(
                      margin: EdgeInsets.all(8),
                      height: size.height * 0.6,
                      child: Shimmerpage());
                }
                if (snapshot.hasData) {
                  List<Item> items = snapshot.data!;
                  print('Dataaa');
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: size.height * 0.65,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return FadeAnimation(
                              1.7,
                              InkWell(
                                ////////////////Selecte Item /////////////////
                                onTap: () {
                                  setState(() {
                                    items[index].isSelected =
                                        !items[index].isSelected;
                                  });
                                  if (items[index].isSelected == false) {
                                    //  command.addItem(items[index]);
                                  } else {
                                    //   command.removeItem(items[index]);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 191, 0)
                                          .withOpacity(0.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(
                                          1, 4), // changes position of shadow
                                    ),
                                  ]),
                                  margin: EdgeInsets.all(4),
                                  height: size.height * 0.4,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FadeAnimation(
                                              1.5, const Text('25\$')),
                                          SizedBox(
                                            width: size.width * 0.05,
                                          )
                                        ], //image
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      FadeAnimation(
                                        1.6,
                                        Stack(
                                          children: [
                                            SizedBox(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.network(
                                                  items[index].thumbnail_url,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.amber
                                                            .withOpacity(0.4),
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              height: size.height * 0.17,
                                              width: size.width * 0.4,
                                            ),
                                            //ISELECTED Icon///////////////
                                            items[index].isSelected == false
                                                ? Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      height:
                                                          size.height * 0.055,
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Color.fromARGB(
                                                            255, 0, 163, 5),
                                                        size: 40,
                                                      ),
                                                    ),
                                                  )
                                                : Text('')
                                          ],
                                        ),
                                      ),
                                      FadeAnimation(
                                        1.7,
                                        Container(
                                          alignment: Alignment.center,
                                          height: size.height * 0.02,
                                          child: Text(items[index].name,
                                              textAlign: TextAlign.center),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Confirm Bottons //////////////////////
                      FadeAnimation(
                        2,
                        SizedBox(
                          height: size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      size.width * 0.4,
                                      size.height * 0.05,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    primary: Colors.red,
                                    elevation: 2,
                                    shadowColor: Colors.amber),
                                onPressed: () {
                                  Navigator.pop(context);
                                  //   command.disposelist();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                        size.width * 0.4,
                                        size.height * 0.05,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      primary: Color.fromARGB(255, 0, 129, 4),
                                      elevation: 2,
                                      shadowColor: Colors.amber),
                                  onPressed: () {},
                                  child:
                                      Text('Confirm ${command.counter 2}'))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container(
                    margin: EdgeInsets.all(8),
                    height: size.height * 0.6,
                    child: Shimmerpage());
              },
            )*/