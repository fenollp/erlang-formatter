-module(amqp_cron_task).

-export([extract_integers/3]).

extract_integers(Min, Max, Acc) ->
    fun
        (Int) when Int < Min ->
            throw({'error', {'out_of_range', {'min', Min}, {'value', Int}}});
        (Int) when Int > Max ->
            throw({'error', {'out_of_range', {'max', Max}, {'value', Int}}});
        (_Int) ->
            'ok'
    end.
