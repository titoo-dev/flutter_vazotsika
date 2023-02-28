import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  CustomSearchDelegate(List<String> words)
      : _words = words,
        _history = <String>[
          'I got away with you',
          'These boots',
          'How can i help you',
          'Hello from the other side'
        ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          onPressed: () {
            query = 'TODO: implement voice input';
          },
          icon: const Icon(Icons.mic),
        )
      else
        IconButton(
          tooltip: 'Clear',
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => {close(context, '')},
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: [
            const Text('You have selected the word'),
            GestureDetector(
              onTap: () {
                close(context, query);
              },
              child: Text(
                query,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));
    return _SuggestionList(
        suggestions: suggestions.toList(),
        query: query,
        onSelected: (String suggestion) {
          query = suggestion;
          _history.insert(0, suggestion);
          showResults(context);
        });
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
      required this.query,
      required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
                text: suggestion.substring(0, query.length),
                style: textTheme?.copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: suggestion.substring(query.length),
                      style: textTheme)
                ]),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
