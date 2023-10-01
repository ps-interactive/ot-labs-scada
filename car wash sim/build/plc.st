TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK



FUNCTION_BLOCK python_eval
  VAR_INPUT
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    STATE : DWORD;
    BUFFER : STRING;
    PREBUFFER : STRING;
    TRIGM1 : BOOL;
    TRIGGED : BOOL;
  END_VAR

  {extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(0, data__);}
END_FUNCTION_BLOCK

FUNCTION_BLOCK python_poll
  VAR_INPUT
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    STATE : DWORD;
    BUFFER : STRING;
    PREBUFFER : STRING;
    TRIGM1 : BOOL;
    TRIGGED : BOOL;
  END_VAR

  {extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(1,(PYTHON_EVAL*)(void*)data__);}
END_FUNCTION_BLOCK

FUNCTION_BLOCK python_gear
  VAR_INPUT
    N : UINT;
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    py_eval : python_eval;
    COUNTER : UINT;
    _TMP_ADD10_OUT : UINT;
    _TMP_EQ13_OUT : BOOL;
    _TMP_SEL15_OUT : UINT;
    _TMP_AND7_OUT : BOOL;
  END_VAR

  _TMP_ADD10_OUT := ADD(COUNTER, 1);
  _TMP_EQ13_OUT := EQ(N, _TMP_ADD10_OUT);
  _TMP_SEL15_OUT := SEL(_TMP_EQ13_OUT, _TMP_ADD10_OUT, 0);
  COUNTER := _TMP_SEL15_OUT;
  _TMP_AND7_OUT := AND(_TMP_EQ13_OUT, TRIG);
  py_eval(TRIG := _TMP_AND7_OUT, CODE := CODE);
  ACK := py_eval.ACK;
  RESULT := py_eval.RESULT;
END_FUNCTION_BLOCK


PROGRAM car_wash
  VAR
    conveyor_motor : BOOL := False;
    washer_1 : BOOL := False;
    washer_2 : BOOL := False;
    brush_1 : BOOL := False;
    brush_2 : BOOL := False;
    rinse_1 : BOOL := False;
    rinse_2 : BOOL := False;
    dryer_1 : BOOL := False;
    dryer_2 : BOOL := False;
    in_use_light : BOOL := False;
    wash_complete_light : BOOL := False;
    master_start : BOOL;
    master_stop : BOOL;
    entry_sensor : BOOL := False;
    washing_sensor : BOOL := False;
    brushing_sensor : BOOL := False;
    rinsing_sensor : BOOL := False;
    drying_sensor : BOOL := False;
    exit_sensor : BOOL := False;
    master_coil : BOOL;
    conveyor_start_delay : BOOL;
    washing_time : BOOL;
    brushing_time : BOOL;
    rinsing_time : BOOL;
    drying_time : BOOL;
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
