
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/option.dart';
import 'package:piehme_cup_flutter/models/question.dart';


TextDirection getTextDirection(String text) {
  final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
  return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

class QuestionListItem extends StatelessWidget {
  final Question question;
  final Function(Object) setAnswer;
  final Object? answer;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.setAnswer,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: ListView(
          shrinkWrap: true,
          children: [

            if(question.picture != null)
              CachedNetworkImage(
                imageUrl: question.picture!,
                placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
                height: 200,
              ),

            Text(
              question.title,
              textAlign: TextAlign.center,
              textDirection: getTextDirection(question.title),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Text(
                "${question.coins}€",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0XFF055E1D),
                ),
              ),
            ),

            const SizedBox(height: 10),

            QuestionInputMethod(
              questionType: question.type,
              options: question.options,
              setAnswer: setAnswer,
              answer: answer,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionInputMethod extends StatelessWidget {
  final QuestionType questionType;
  final List<Option> options;
  final Function(Object) setAnswer;
  final Object? answer;

  const QuestionInputMethod({
    super.key,
    required this.questionType,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {

    if (questionType == QuestionType.choice) {
      return ChoiceInputMethod(
        options: options,
        setAnswer: setAnswer,
        answer: answer,
      );
    }

    if (questionType == QuestionType.reorder) {
      return ReorderInputMethod(
        options: options,
        setAnswer: setAnswer,
        answer: answer as List<int>?,
      );
    }

    if (questionType == QuestionType.written) {
      return WrittenInputMethod(
        setAnswer: setAnswer,
        answer: answer as String?,
      );
    }

    return Container();
  }
}

class ChoiceInputMethod extends StatelessWidget {
  final List<Option> options;
  final Function(Object) setAnswer;
  final Object? answer;

  const ChoiceInputMethod({
    super.key,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...options.map((option) {
          return Directionality(
            textDirection: getTextDirection(option.name),

            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: RadioListTile<int>(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    if(option.picture != null)
                      CachedNetworkImage(
                        imageUrl: option.picture!,
                        height: 120,
                      ),

                    Text(
                      option.name,
                      textDirection: getTextDirection(option.name),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                value: option.order,
                groupValue: answer as int?,
                onChanged: (value) {
                  setAnswer(value!);
                },
                activeColor: Colors.greenAccent,
                fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.greenAccent; // Selected color
                  }
                  return Colors.black; // Unselected color
                }),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class ReorderInputMethod extends StatefulWidget {
  final List<Option> options;
  final Function(Object) setAnswer;
  final List<int>? answer;

  const ReorderInputMethod({
    super.key,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });

  @override
  State<ReorderInputMethod> createState() => _ReorderInputMethodState();
}

class ShortDragStartListener
    extends ReorderableDelayedDragStartListener {
  const ShortDragStartListener({
    super.key,
    required super.child,
    required super.index,
    super.enabled,
  });

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(
      delay: const Duration(milliseconds: 100), // default: 500 ms
      debugOwner: this,
    );
  }
}

class _ReorderInputMethodState extends State<ReorderInputMethod> {
  late List<Option> options;

  @override
  void initState() {
    options = List.from(widget.options);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.answer == null) {
        widget.setAnswer(options.map((option) => option.order).toList());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ReorderableListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: child,
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = options.removeAt(oldIndex);
          options.insert(newIndex, item);
          widget.setAnswer(options.map((option) => option.order).toList());
        });
      },
      children: [
        ...options.map((option) {
          return ShortDragStartListener(
            index: options.indexOf(option),
            key: Key("options-${option.id}"),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
              ),
              child: Directionality(
                textDirection: getTextDirection(option.name),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
            
                          if(option.picture != null)
                            CachedNetworkImage(
                              imageUrl: option.picture!,
                              height: 100,
                            ),
            
                          Text(
                            option.name,
                            textDirection: getTextDirection(option.name),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    const Icon(
                      Icons.drag_handle,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}


class WrittenInputMethod extends StatefulWidget {
  final Function(Object) setAnswer;
  final String? answer;

  const WrittenInputMethod({
    super.key,
    required this.setAnswer,
    required this.answer,
  });

  @override
  State<WrittenInputMethod> createState() => _WrittenInputMethodState();
}

class _WrittenInputMethodState extends State<WrittenInputMethod> {

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.answer ?? '');

    controller.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(WrittenInputMethod oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer != controller.text) {
      controller.text = widget.answer ?? '';
    }
  }

  void _onTextChanged() {
    widget.setAnswer(controller.text);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textDirection: getTextDirection(controller.text),
      decoration: InputDecoration(
        hintText: "الاجابة",
        hintTextDirection: TextDirection.rtl,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}