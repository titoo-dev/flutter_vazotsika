// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8),
// child: Row(
// children: [
// IconButton(
// onPressed: controller.openDrawer,
// icon: const Icon(Icons.menu),
// ),
// Expanded(
// child: GestureDetector(
// onTap: () async {
// final String? selected = await showSearch<String>(
// context: context,
// delegate: controller.delegate,
// );
// if (selected != null) {
// appController.scaffoldMessenger.currentState
//     ?.showSnackBar(
// SnackBar(
// content: Text('You have selected $selected'),
// ),
// );
// }
// },
// child: SizedBox(
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8),
// child: Text(
// 'Recherchez votre musique',
// style: Theme.of(context)
// .textTheme
//     .labelLarge
//     ?.copyWith(
// color: Colors.grey,
// fontSize: 16,
// fontWeight: FontWeight.normal),
// ),
// ),
// ),
// ),
// )
// ],
// ),
// )