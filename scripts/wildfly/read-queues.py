#!/usr/bin/env python

import json
import re
import os
import subprocess

def main():
    WILDFLY_HOME = os.environ.get('WILDFLY_HOME')
    cmd = WILDFLY_HOME + r'/bin/jboss-cli.sh --connect "/subsystem=messaging/hornetq-server=default/:read-children-resources\(child-type=jms-queue,include-runtime=true\)"'
    #print cmd.split()
    process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
    out, err = process.communicate()

    if err:
        print err

    # convert to json
    out = out.replace("=>", ":")
    out = re.sub(r': (\d+L),', r': "\1",', out)
    out = re.sub(r': (\w+),', r': "\1",', out)

    json_data = json.loads(out)
    queue_info = json_data['result']
    print '%30s %15s %15s' % ('queue', 'processing', 'total_added')
    print '-'*15*5
    for key, value in queue_info.items():
        print '%30s %15s %15s' % (key, value['message-count'], value['messages-added'])

if __name__ == '__main__':
    main()
