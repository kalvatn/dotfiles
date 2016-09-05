#! /usr/bin/env python3

import locale
from subprocess import Popen, PIPE

encoding = locale.getdefaultlocale()[1]

def get_password(attr, value):
    (out, err) = Popen(["secret-tool", "lookup", attr, value], stdout=PIPE).communicate()
    return out.decode(encoding).strip()
