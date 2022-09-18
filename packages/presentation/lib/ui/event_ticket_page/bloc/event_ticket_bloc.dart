import 'package:presentation/base/bloc.dart';
import 'package:presentation/ui/event_ticket_page/data/event_ticket_screen_data.dart';
import 'package:presentation/ui/event_ticket_page/ticket_arguments/event_ticket_arguments.dart';

abstract class EventTicketBloc
    extends Bloc<EventTicketArguments, EventTicketScreenData> {
  factory EventTicketBloc() => EventTicketBlocImpl();
}

class EventTicketBlocImpl
    extends BlocImpl<EventTicketArguments, EventTicketScreenData>
    implements EventTicketBloc {

  EventTicketBlocImpl();


  @override
  void initArgs(EventTicketArguments arguments) {
    super.initArgs(arguments);
  }
}
