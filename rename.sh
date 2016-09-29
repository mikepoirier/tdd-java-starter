#!/usr/bin/env bash

args=("$@")

first=${args[0]}
second=${args[1]}
third=${args[2]}

first_replace="s/some_app/${first}/g"
second_replace="s/SomeApp/${second}/g"
third_replace="s/Some App/${third}/g"

#git grep -l 'some_app' | xargs sed -i "${first_replace}"
#git grep -l 'SomeApp' | xargs sed -i "${first_replace}"
#git grep -l 'Some App' | xargs sed -i "${first_replace}"