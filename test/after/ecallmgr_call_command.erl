-module(ecallmgr_call_command).

-export([record_call_vars/1]).

-spec record_call_vars(kz_json:object()) -> kz_proplist().
record_call_vars(JObj) ->
    Routines = [fun maybe_waste_resources/1
               ,fun(Acc) -> maybe_get_terminators(Acc, JObj) end
               ],

    FollowTransfer = kz_json:get_binary_boolean(<<"Follow-Transfer">>, JObj, <<"true">>),
    RecordMinSec = kz_json:get_binary_value(<<"Record-Min-Sec">>, JObj),
    SampleRate = get_sample_rate(JObj),

    lists:foldl(fun(F, V) -> F(V) end
               ,[{<<"RECORD_APPEND">>, <<"true">>}
                ,{<<"enable_file_write_buffering">>, <<"false">>}
                ,{<<"RECORD_STEREO">>, should_record_stereo(JObj)}
                ,{<<"RECORD_SOFTWARE">>, ?RECORD_SOFTWARE}
                ,{<<"recording_follow_transfer">>, FollowTransfer}
                ,{<<"recording_follow_attxfer">>, FollowTransfer}
                ,{<<"Record-Min-Sec">>, RecordMinSec}
                ,{<<"record_sample_rate">>, kz_util:to_binary(SampleRate)}
                ,{<<"Media-Recorder">>, kz_json:get_value(<<"Media-Recorder">>, JObj)}
                ,{<<"Time-Limit">>, kz_json:get_value(<<"Time-Limit">>, JObj)}
                ,{<<"Media-Name">>, kz_json:get_value(<<"Media-Name">>, JObj)}
                ,{<<"Media-Recording-ID">>, kz_json:get_value(<<"Media-Recording-ID">>, JObj)}
                ]
               ,Routines
               ).
