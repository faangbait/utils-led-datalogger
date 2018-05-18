#!/bin/bash

counter=1
epochTime=$(date +%s)
sleepTime=60 #DO NOT TAKE READINGS MORE FREQUENTLY THAN 5s
mkdir ./cap-$epochTime

while [ 1 ]
do
        echo $(printf %08d $counter).jpeg ... sleeping: $sleepTime s
        streamer -o ./cap-$epochTime/cap$(printf %08d $counter).jpeg -q
        sleep $sleepTime
        # next line contains crop boundaries - edit if you want; can probably be safely removed if lights are off.
        echo $counter,`convert ./cap-$epochTime/cap$(printf %08d $counter).jpeg -crop 160x40+90+40 -despeckle -fuzz 35% -fill white -opaque white -fill black +opaque white -format "%[fx:100*mean]" info:` >> ./cap-$epochTime/analysis.txt;
        counter=$(( $counter + 1 ))
done
