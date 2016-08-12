-module(teletype_new_account).

-export([a/0
        ]).

-define(TEMPLATE_TEXT, <<"
{% if A %}
A
{% endif %}

{% if B %}
B
{% endif %}
                                          C
">>).

a() ->
    ?TEMPLATE_TEXT.
