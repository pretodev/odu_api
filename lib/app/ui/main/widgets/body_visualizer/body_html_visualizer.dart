part of "body_visualizer.dart";

class BodyHtmlVisualizer extends StatelessWidget {
  const BodyHtmlVisualizer({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Preview HTML não implementado',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              'Use o modo Pretty ou Raw para visualizar o conteúdo',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
