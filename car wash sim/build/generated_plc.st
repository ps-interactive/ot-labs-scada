PROGRAM car_wash
  VAR
    conveyor_motor AT %QX0.0 : BOOL := False;
    washer_1 AT %QX0.1 : BOOL := False;
    washer_2 AT %QX0.2 : BOOL := False;
    brush_1 AT %QX0.3 : BOOL := False;
    brush_2 AT %QX0.4 : BOOL := False;
    rinse_1 AT %QX0.5 : BOOL := False;
    rinse_2 AT %QX0.6 : BOOL := False;
    dryer_1 AT %QX0.7 : BOOL := False;
    dryer_2 AT %QX1.0 : BOOL := False;
    in_use_light AT %QX1.1 : BOOL := False;
    wash_complete_light AT %QX1.2 : BOOL := False;
    master_start AT %QX1.3 : BOOL;
    master_stop AT %QX1.4 : BOOL;
    entry_sensor AT %QX1.5 : BOOL := False;
    washing_sensor AT %QX1.6 : BOOL := False;
    brushing_sensor AT %QX1.7 : BOOL := False;
    rinsing_sensor AT %QX2.0 : BOOL := False;
    drying_sensor AT %QX2.1 : BOOL := False;
    exit_sensor AT %QX2.2 : BOOL := False;
    master_coil AT %QX2.3 : BOOL;
    conveyor_start_delay AT %QX2.4 : BOOL;
    washing_time AT %QX2.5 : BOOL;
    brushing_time AT %QX2.6 : BOOL;
    rinsing_time AT %QX2.7 : BOOL;
    drying_time AT %QX3.0 : BOOL;
  END_VAR
  VAR
    TON0 : TON;
    conveyor_delay_pt : TIME := T#5s;
    TON1 : TON;
    wash_time_pt : TIME := T#5s;
    TON2 : TON;
    brush_time_pt : TIME := T#5s;
    TON3 : TON;
    rinse_time_pt : TIME := T#5s;
    TON4 : TON;
    dry_time_pt : TIME := T#5s;
    exit_delay : TIME := T#3s;
  END_VAR

  master_coil := NOT(master_stop) AND (master_coil OR master_start);
  TON0(IN := NOT(wash_complete_light) AND (brushing_sensor OR conveyor_start_delay OR drying_sensor OR entry_sensor OR rinsing_sensor OR washing_sensor) AND master_coil, PT := conveyor_delay_pt);
  conveyor_start_delay := TON0.Q;
  in_use_light := NOT(wash_complete_light) AND (brushing_sensor OR conveyor_start_delay OR drying_sensor OR entry_sensor OR rinsing_sensor OR washing_sensor) AND master_coil;
  conveyor_motor := NOT(dryer_1) AND NOT(rinse_1) AND NOT(brush_1) AND NOT(washer_1) AND conveyor_start_delay AND master_coil;
  washer_1 := NOT(washing_time) AND washing_sensor AND master_coil;
  washer_2 := NOT(washing_time) AND washing_sensor AND master_coil;
  TON1(IN := washing_sensor AND master_coil, PT := wash_time_pt);
  washing_time := TON1.Q;
  brush_1 := NOT(brushing_time) AND brushing_sensor AND master_coil;
  brush_2 := NOT(brushing_time) AND brushing_sensor AND master_coil;
  TON2(IN := brushing_sensor AND master_coil, PT := brush_time_pt);
  brushing_time := TON2.Q;
  rinse_1 := NOT(rinsing_time) AND rinsing_sensor AND master_coil;
  rinse_2 := NOT(rinsing_time) AND rinsing_sensor AND master_coil;
  TON3(IN := rinsing_sensor AND master_coil, PT := rinse_time_pt);
  rinsing_time := TON3.Q;
  dryer_1 := NOT(drying_time) AND drying_sensor AND master_coil;
  dryer_2 := NOT(drying_time) AND drying_sensor AND master_coil;
  TON4(IN := drying_sensor AND master_coil, PT := dry_time_pt);
  drying_time := TON4.Q;
  wash_complete_light := exit_sensor AND (NOT(entry_sensor) OR wash_complete_light) AND master_coil;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : car_wash;
  END_RESOURCE
END_CONFIGURATION
