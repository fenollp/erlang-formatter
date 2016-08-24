-module(amqp_leader_proc).

-type routine() :: {fun((any()) -> any()), any()}.
-type routines() :: [].
