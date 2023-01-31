import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/model/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketState get initialState => const TicketState([]);

  TicketBloc() : super(const TicketState([])) {
    on<TicketEvent>((event, emit) async {
      if (event is BuyTicket) {
        await TicketServices.saveTicket(event.userID, event.ticket);

        List<Ticket> tickets = state.tickets + [event.ticket];

        emit(TicketState(tickets));
      } else if (event is GetTickets) {
        List<Ticket> tickets = await TicketServices.getTickets(event.userID);

        emit(TicketState(tickets));
      }
    });
  }
}
