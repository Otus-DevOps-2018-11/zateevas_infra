#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json
import pprint
with open ("inventory.json", "r") as inventory_file:
    json_file = json.load(inventory_file)
    pprint.pprint(json_file, width=1)
