#/bin/env sh
create-wemux-session() {
    wemux -S /tmp/wemux-$1 new-session -d -s $1
    chmod 1777 /tmp/wemux-$1
}

create-wemux-session skipper
create-wemux-session rico
create-wemux-session kowalski
create-wemux-session private
