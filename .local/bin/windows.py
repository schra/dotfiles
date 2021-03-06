#!/usr/bin/env python3

# Parts of the code are based on https://stackoverflow.com/a/42404044

import subprocess
import re
import psutil

def get_active_window_id():
    root = subprocess.Popen(['xprop', '-root', '_NET_ACTIVE_WINDOW'], stdout=subprocess.PIPE)
    stdout, stderr = root.communicate()

    match = re.search(b'^_NET_ACTIVE_WINDOW.* ([\w]+)$', stdout)
    if match is None:
        return None
    else:
        return match.group(1)

def get_pid_by_window_id(window_id):
    window = subprocess.Popen(['xprop', '-id', window_id, '_NET_WM_PID'], stdout=subprocess.PIPE)
    stdout, stderr = window.communicate()

    match = re.search(b"_NET_WM_PID\(\w+\) = (?P<pid>[0-9]+)\n", stdout)
    if match is None:
        return None
    else:
        return int(match.group("pid"))

def get_pid_of_active_window():
    window_id = get_active_window_id()
    if window_id is None:
        return None

    pid = get_pid_by_window_id(window_id)
    if pid is None:
        return None

    return pid

def is_terminal(pid):
    process = psutil.Process(pid)
    argv = process.cmdline()
    return len(argv) > 0 and argv[0] == 'alacritty'

def get_cwd_of_bash_child(pid):
    process = psutil.Process(pid)
    for child in process.children(recursive=True):
        argv = child.cmdline()
        if len(argv) > 0 and argv[0] == '/bin/bash':
            return child.cwd()

if __name__ == "__main__":
    pid = get_pid_of_active_window()
    if pid is not None and is_terminal(pid):
        print(get_cwd_of_bash_child(pid))
    else:
        print('error: current window not a terminal', file=sys.stderr)
