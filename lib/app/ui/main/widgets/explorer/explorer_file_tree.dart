part of 'explorer.dart';

class ExplorerFileTree extends StatelessWidget {
  const ExplorerFileTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('File $index'),
        );
      },
    );
  }
}
