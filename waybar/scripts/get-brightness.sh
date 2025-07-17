#!/bin/bash

level=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( 100 * level / max ))

echo "$percent%"
