# root command
complete -c timew --no-files
complete -c timew -n "__fish_use_subcommand" -a "annotate cancel config continue day delete diagnostics export extensions gaps get help join lengthen modify month move shorten show split start stop summary tag tags track undo untag week"

# completions for commands requiring tags (basically all of them)
complete -c timew -n "not __fish_use_subcommand" \
-a (timew export | jq 'map(select(.tags != null)) | .[].tags[]' | sort -u | tr '\n' ' ')
