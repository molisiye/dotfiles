#!/usr/bin/env sh

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
echo "hypr:"
echo $HYPRGAMEMODE

if [ "$HYPRGAMEMODE" = 1 ]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0;\
        keyword misc:vfr 1;\
        keyword misc:animate_manual_resizes 0;\
        "
    exit
fi

hyprctl reload
