#!/usr/bin/env python

import csv

with open('test.csv') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        print(row['datetime'])

with open('testOut.csv', 'w') as csvfile:
    fieldnames = ['datetime','u','v','temp(C)','rh','prmsl']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()


