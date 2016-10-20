#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import geoip2.database
import json

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: ' + sys.argv[0] + ' <city_database> <ip>')
        sys.exit(1)

    reader = geoip2.database.Reader(sys.argv[1])
    response = reader.city(sys.argv[2])
    print(json.dumps(response.raw, lambda o: o.__dict__))

