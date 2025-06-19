import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../root/bodyes/my_card.dart';
import '/bloc/providers/provider_bloc.dart';
import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '/database/cards_stack.dart';
import 'dialog_add_card.dart';
import 'dialog_create_card.dart';
import 'dialog_delete.dart';
import 'stack_widget.dart';

class UpdateDeleteStackPage extends StatefulWidget {
  const UpdateDeleteStackPage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateDeleteStackPageState();
}

class _UpdateDeleteStackPageState extends State<UpdateDeleteStackPage> {
  List<AECard> cards = [];
  List<CardsStack> stacks = [];
  List<HeroStack> heroStacks = [];
  Size screenSize = const Size(0, 0);

  List<String> typesList = [];
  List<Color> colorsList = [];
  var curentColor = const Color.fromARGB(255, 255, 255, 255);

  stackColor(Color color) {
    return Container(
      width: 20,
      height: 20,
      color: color,
    );
  }

  cardWidget(int index) {
    //return Text("Card Item: ${cards[index].text}");
    return Column(
      children: [
        MyCard(
          Center(
            child: Text(
              cards[index].text,
              textAlign: TextAlign.center,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Size(150, 220),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CreateCardDialog(cards[index]));
          },
          child: const Text("Update card"),
        ),
        ElevatedButton(
          onPressed: () {
            var text = cards[index].text.split(":")[0];
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    DeleteDialog(text, true, false, cards[index].id));
            //context.read<CRUDStackBloc>().add(CRUDStackDeleteCardEvent(cards[index].id));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Delete card"),
        ),
      ],
    );
  }

  stackWidget(int index) {
    String cardNames = "\n";
    curentColor = colorsList[index];
    if (stacks[index].cards.isNotEmpty) {
      for (var element in stacks[index].cards) {
        if (element.text.isNotEmpty) {
          var cardName = element.text.split(":");
          cardNames += "${cardName[0]}, \n";
        }
      }
    }

    var curentName = stacks[index].name;
    var checkboxState = stacks[index].isActive;
    var curentType = typesList[index];

    Widget nameStack = Center(
      child: Text(
        "Stack name: $curentName",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    void changeName() {
      print("ChangeName in $curentName stack");
      
    }

    void addCard() {
      print("Add card in $curentName stack");
      showDialog(
          context: context,
          builder: (BuildContext context) => AddCardToStackDialog(stack: stacks[index])
              );
    }

    void checkboxChange(bool value) {
      var newStack = CardsStack(
          id: stacks[index].id,
          name: stacks[index].name,
          isActive: !stacks[index].isActive,
          stackType: stacks[index].stackType,
          stackColor: stacks[index].stackColor,
          cards: stacks[index].cards);
      // context.read<CRUDStackBloc>().add(
      //       CRUDStackUpdateStackEvent(newStack),
      //     );
      if(mounted) {
      setState(() {
        stacks.removeAt(index);
        stacks.insert(index, newStack);
        checkboxState = !checkboxState;
      });
      }
      print(
          "UpdateDeleteStackPage stackWidget checkboxChange $value, ${stacks[index].isActive}");
    }

    changeType(String value) {
      if (value != typesList[index]) {
        print("${stacks[index].name} Stack type changed to $value");
        var newStackType = StackType.turnOrder;
        if (value == "Turn order") {
          newStackType = StackType.turnOrder;
        } else if (value == "Friend / Foe") {
          newStackType = StackType.friendFoe;
        } else if (value == "Gravehold") {
          newStackType = StackType.gravehold;
        } else if (value == "Hero") {
          newStackType = StackType.hero;
        } else if (value == "Nemesis") {
          newStackType = StackType.nemesis;
        } /*else {
          value = "Is empty";
        }*/
        var newStack = CardsStack(
            id: stacks[index].id,
            name: stacks[index].name,
            isActive: stacks[index].isActive,
            stackType: newStackType,
            stackColor: stacks[index].stackColor,
            cards: stacks[index].cards);
            if(mounted) {
        setState(() {
          stacks.removeAt(index);
          stacks.insert(index, newStack);
          typesList[index] = value;
        });}
      } else {
        print("${stacks[index].id} Stack type not changed");
      }
    }

    changeColor(Color value) {
      if (value != colorsList[index]) {
        print("${stacks[index].name} Stack color changed to $value");
        //var newStackColor = const Color.fromARGB(255, 158, 158, 158);
        var newStack = CardsStack(
            id: stacks[index].id,
            name: stacks[index].name,
            isActive: stacks[index].isActive,
            stackType: stacks[index].stackType,
            stackColor: value,
            cards: stacks[index].cards);
            if(mounted) {
        setState(() {
          stacks.removeAt(index);
          stacks.insert(index, newStack);
          colorsList[index] = value;
        });}
      } else {
        print("${stacks[index].id} Stack color not changed");
      }
    }

    saveStack() {
      print("Save $curentName stack");
      context
          .read<CRUDStackBloc>()
          .add(CRUDStackUpdateStackEvent(stacks[index]));
    }

    deleteStack() {
      print("Delete $curentName stack");
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              DeleteDialog(stacks[index].name, false, true, stacks[index].id));
      //context.read<CRUDStackBloc>().add(CRUDStackDeleteStackEvent(index));
    }

    return StackWidget(
      //myStack(
      //curentName,
      nameStack,
      cardNames,
      checkboxState,
      curentType,
      curentColor,
      changeName,
      addCard,
      checkboxChange,
      changeType,
      changeColor,
      saveStack,
      deleteStack,
    );
  }

  box(String text, String buttonText, SizedBox sizedBox, Function create) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(text, style: const TextStyle(fontSize: 20))),
                ElevatedButton(
                  onPressed: () {
                    create();
                    // Add your stack creation logic here
                  },
                  child: Text(buttonText, style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          sizedBox,
        ],
      ),
    );
  }

  void createCard(BuildContext context) {
    print("UpdateDeleteStack createCard");
    AECard card = AECard(id: 0, text: "", imgPath: "");
    showDialog(
        context: context,
        builder: (BuildContext context) => CreateCardDialog(card));
  }

  void createStack() {
    context.read<ProviderBloc>().add(const CreateEvent(0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        cards = state.cards;
        stacks = state.stacks;
        screenSize = MediaQuery.of(context).size;
        typesList.clear();
        colorsList.clear();
        for (var element in stacks) {
          //print("UpdateDeleteStackPage build element.name == ${element.name} element.stackType == ${element.stackType}");
          var stackType = "";
          if (element.stackType == StackType.turnOrder) {
            stackType = "Turn order";
          } else if (element.stackType == StackType.friendFoe) {
            stackType = "Friend / Foe";
          } else if (element.stackType == StackType.gravehold) {
            stackType = "Gravehold";
          } else if (element.stackType == StackType.hero) {
            stackType = "Hero";
          } else if (element.stackType == StackType.nemesis) {
            stackType = "Nemesis";
          } /*else {
            stackType = "Is empty";
          }*/
          if (stackType != "" && stacks.length > typesList.length) {
            typesList.add(stackType);
            colorsList.add(element.stackColor);
          }
        }
        print("UpdateDeleteStackPage build typesList == $typesList");
        print("UpdateDeleteStackPage build colorsList.length == ${colorsList.length}");
      } else {
        print(
            "UpdateDeleteStackPage build state is not CRUDStackSuccessActionState \n");
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Create / Update Stack'),
              ElevatedButton(
                onPressed: () {
                  context.read<ProviderBloc>().add(RootEvent());
                },
                child: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        body: ListView(
          children: <Widget>[
            // Cards
            box(
              'Cards: ',
              'Create card',
              SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: cards.isEmpty ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => cardWidget(index),
                ),
              ),
              () => createCard(context),
            ),

            // Stacks
            box(
              'Stacks: ',
              'Create stack',
              SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: stacks.isEmpty ? 0 : stacks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) =>
                      stackWidget(index), // StackWidgetPage(index),
                ),
              ),
              () => createStack(),
            ),
          ],
        ),
      );
    });
  }
}
