import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/option.dart';
import 'package:piehme_cup_flutter/models/question.dart';

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
    final bool isRTL = _isRTL(question.title);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        color: isDark ? Colors.grey.shade900 : Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              // Question Image
              if (question.picture != null)
                Container(
                  height: 200,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: question.picture!,
                      placeholder: (context, url) => Container(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        child: Icon(
                          Icons.error,
                          color: isDark ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Question Title
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.blue.withAlpha(26) : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.blue.withAlpha(77) : Colors.blue.shade200,
                  ),
                ),
                child: Text(
                  question.title,
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                    height: 1.4,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Coins Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.green.withAlpha(26) : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? Colors.green.withAlpha(77) : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.monetization_on_rounded,
                      color: isDark ? Colors.green.shade300 : Colors.green.shade600,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${question.coins}€",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.green.shade300 : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Input Method
              QuestionInputMethod(
                questionType: question.type,
                options: question.options,
                setAnswer: setAnswer,
                answer: answer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }
}

// Enhanced ChoiceInputMethod
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: options.map((option) {
        final bool isRTL = _isRTL(option.name);
        final bool isSelected = answer == option.order;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? (isDark ? Colors.blue.withAlpha(51) : Colors.blue.shade50)
                : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
            border: Border.all(
              color: isSelected
                  ? (isDark ? Colors.blue.shade300 : Colors.blue.shade500)
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setAnswer(option.order),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Radio Indicator
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? Colors.blue.shade300 : Colors.blue.shade500)
                              : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                          width: 2,
                        ),
                        color: isSelected
                            ? (isDark ? Colors.blue.shade300 : Colors.blue.shade500)
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                          : null,
                    ),
                    SizedBox(width: 16),

                    // Option Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isRTL
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (option.picture != null)
                            Container(
                              height: 100,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: option.picture!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                                    child: Icon(
                                      Icons.error,
                                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Text(
                            option.name,
                            textAlign: isRTL ? TextAlign.right : TextAlign.left,
                            textDirection: isRTL
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.grey.shade900,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
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

// Enhanced ReorderInputMethod
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

class ShortDragStartListener extends ReorderableDelayedDragStartListener {
  const ShortDragStartListener({
    super.key,
    required super.child,
    required super.index,
    super.enabled,
  });

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(
      delay: const Duration(milliseconds: 100),
      debugOwner: this,
    );
  }
}

TextDirection getTextDirection(String text) {
  final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
  return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

class _ReorderInputMethodState extends State<ReorderInputMethod> {
  late List<Option> options;

  @override
  void initState() {
    options = List.from(widget.options);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.answer != null && widget.answer!.isNotEmpty) {
        setState(() {
          final List<int> answerOrder = widget.answer!;
          final Map<int, Option> optionMap = {
            for (var option in options) option.order: option
          };
          options = answerOrder.map((order) => optionMap[order]!).toList();
        });
      }
      widget.setAnswer(options.map((option) => option.order).toList());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ReorderableListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 8,
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDark ? Colors.blue.withAlpha(51) : Colors.blue.shade100,
              border: Border.all(
                color: isDark ? Colors.blue.shade300 : Colors.blue.shade400,
                width: 2,
              ),
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
        // List<Option> qOptions = this.options;
        ...options.map((option) {
          final bool isRTL = _isRTL(option.name);

          return ShortDragStartListener(
            index: options.indexOf(option),
            key: Key("options-${option.id}"),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? Colors.grey.shade800 : Colors.white,
                border: Border.all(
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Drag Handle
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.drag_handle,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 16),

                  // Option Content
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if (option.picture != null)
                          Container(
                            height: 80,
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: option.picture!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        Text(
                          option.name,
                          textDirection: getTextDirection(option.name),
                          textAlign: isRTL ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.grey.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }
}

// Enhanced WrittenInputMethod
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isRTL = _isRTL(controller.text);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey.shade800 : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
      ),
      child: TextField(
        controller: controller,
        textDirection: getTextDirection(controller.text),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: isRTL ? "اكتب إجابتك هنا..." : "Type your answer here...",
          hintTextDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        style: TextStyle(
          color: isDark ? Colors.white : Colors.grey.shade900,
          fontSize: 16,
          height: 1.4,
        ),
      ),
    );
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }
}