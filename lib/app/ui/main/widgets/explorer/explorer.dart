import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'explorer_file_tree.dart';

class Explorer extends StatelessWidget {
  const Explorer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.all(8.0),
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            spreadRadius: 1.0,
            blurRadius: 0.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Project Name',
                style: GoogleFonts.firaCode(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 16.0,
                    constraints: BoxConstraints(),
                    icon: Icon(Symbols.note_add_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 16.0,
                    constraints: BoxConstraints(),
                    icon: Icon(Symbols.create_new_folder_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 16.0,
                    constraints: BoxConstraints(),
                    icon: Icon(Symbols.refresh_rounded),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ExplorerFileTree(),
          ),
        ],
      ),
    );
  }
}
