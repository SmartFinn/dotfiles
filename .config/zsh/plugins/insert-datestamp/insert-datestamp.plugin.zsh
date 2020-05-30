# Insert a datestamp on the command line (yyyy-mm-dd)
insert-datestamp() { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp
bindkey '^Ed' insert-datestamp

# Insert a timestamp on the command line (HH:MM:SS)
insert-timestamp() { LBUFFER+=${(%):-'%D{%H:%M:%S}'}; }
zle -N insert-timestamp
bindkey '^Et' insert-timestamp
