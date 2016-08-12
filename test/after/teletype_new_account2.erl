-module(teletype_new_account2).

-export([a/0
        ]).

-define(TEMPLATE_TEXT,
        <<"\n"
          "{% if A %}\n"
          "A\n"
          "{% endif %}\n"
          "\n"
          "{% if B %}\n"
          "B\n"
          "{% endif %}\n"
          "                                          C\n"
        >>).

a() ->
    ?TEMPLATE_TEXT.
