#!/bin/bash

master_start () {
# Press Master Start
mbtget -a 11 -w5 1 > /dev/null
mbtget -a 11 -w5 0 > /dev/null
}

master_stop () {
# Press Master Stop
mbtget -a 12 -w5 1 > /dev/null
mbtget -a 12 -w5 0 > /dev/null
}

reset () {
for address in {0..24}
do
  mbtget -a $address -w5 0 > /dev/null
done
}

station_operation () {
# Turn station sensor on
mbtget -a $1 -w5 1 > /dev/null
# Check if station has finished
while :
do
  station_finished=$(mbtget -a $2 -r1)
  complete=${station_finished: -1}
  if [ $complete -eq 1 ]
  then
    break
  else
    sleep 1
  fi
done
# Turn station sensor off
mbtget -a $1 -w5 0 > /dev/null
sleep 2 # This is a transit delay between stations while the conveyor oeprates
}

# Reset all coils
echo "Resetting all coils to zero"
reset

# Manually start - not needed when HMI is used
echo "Press master start button"
master_start

while :
do
  # Check if master coil is energised
  master_coil=$(mbtget -a 19 -r1)
  master_coil=${master_coil: -1}

  if [ $master_coil -eq 1 ]
  then
    #TODO Adda random delay here to simulate cars arriving at the car wash
    # Car arrival
    echo "Car arriving"
    station_operation 13 20

    # Washing cycle
    echo "Starting washing cycle"
    station_operation 14 21

    # Brushing cycle
    echo "Starting brushing cycle"
    station_operation 15 22

    # Rinsing cycle
    echo "Starting rinsing cycle"
    station_operation 16 23

    # Drying cycle
    echo "Starting drying cycle"
    #station_operation 17 24

    # Exit
    echo "Car exiting"
    mbtget -a 18 -w5 1 > /dev/null
    sleep 2
    mbtget -a 18 -w5 0 > /dev/null
  fi

done
