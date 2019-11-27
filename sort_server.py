import json
import urllib.request

import numpy as np

def run():
    """ Run! """
    url='https://monitor.csie.ntu.edu.tw/js/data.js'
    data = urllib.request.urlopen(url).read().decode()
    data = data.replace('var glob_data=', '').replace(';','')
    data = json.loads(data)
    mac = data['mac']

    # check linux 5 ~ 14
    stats_beg = 5
    stats_end = 15
    available = np.zeros((stats_end - stats_beg, 2))
    for linux_id in range(stats_beg, stats_end):
        machine = mac['linux{}'.format(linux_id)]
        available[linux_id - stats_beg, 0] = (1 - float(machine['cpu']['text'][:-1]) / 100) # remove %
        available[linux_id - stats_beg, 1] = float(machine['mem']['text'][:-2]) / 128 # remove GB
    # print(available)

    # find the best machine
    score = (available[:, 0] ** 2) + (available[:, 1] ** 2)
    # print(score)
    arg_score = np.argsort(-score) + stats_beg
    # print(arg_score)
    for arg in arg_score:
        print(arg)

if __name__ == '__main__':
    run()
