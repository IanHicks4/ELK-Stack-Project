#!/bin/bash


states=('North Carolina' 'New Hampshire' 'Colorado' 'California' 'New York')


for state in ${states[@]}
do
if [ $states == 'New York' ];
then
echo "New York is the best!"
else
echo "I'm not a fan of New York."
fi
done

