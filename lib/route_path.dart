// Describe definitions to reference all potential pages in an application
// and define specific Page information. Basically this class represents all
// potentials screens that you could view regardless of how they are presented
// (as a stack, as a modal, as a tab, etc)

class RoutePath {
  final String id;

  // basic assumption in this example is that a single String argument satisfiest, but
  // could be anything.
  final String argument;

  RoutePath.lander()
      : id = 'lander',
        argument = null;
  RoutePath.details(String id)
      : id = 'details',
        argument = id;

  // expose the pages to be used by application
  bool get isLanderPage => id == 'lander';
  bool get isDetailsPage => id == 'details';
}
