import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final controller = TextEditingController();
  OverlayEntry? entry;
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _showOverLay(),
    );
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _showOverLay();
      } else {
        hideOverLay();
      }
    });
  }

  void _showOverLay() {
    final overLay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
            width: size.width,
            child: CompositedTransformFollower(
                link: layerLink,
                offset: Offset(0, size.height + 8),
                showWhenUnlinked: false,
                child: buildOverLay()));
      },
    );
    overLay.insert(entry!);
  }

  void hideOverLay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverLay() {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                controller.text = 'Sarah Abs';
              });
              hideOverLay();
              focusNode.unfocus();
            },
            leading: Image.network(
              'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=is&k=20&c=M-zkBx55YCn_UZg9cyuVMm1nS_PhSKGqoVybgO1Dp0Y=',
              fit: BoxFit.cover,
            ),
            title: const Text('Sarah Abs'),
          ),
          ListTile(
            onTap: () {
              setState(() {
                controller.text = 'Julia Abs';
              });
              hideOverLay();
              focusNode.unfocus();
            },
            leading: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZTJ9PiXYRPBIWO2maHbR9UZHFId3Jj0aDTYR6uXROOA&s',
              fit: BoxFit.cover,
            ),
            title: const Text('Julia Abs'),
          ),
          ListTile(
            onTap: () {
              setState(() {
                controller.text = 'Emma Abs';
              });
              hideOverLay();
              focusNode.unfocus();
            },
            leading: Image.network(
              'https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80',
              fit: BoxFit.cover,
            ),
            title: const Text('Emma Abs'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Username'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
