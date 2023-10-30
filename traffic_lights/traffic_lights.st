PROGRAM TrafficLight
  VAR
    Redlight AT %QX0.0 : BOOL;
    Orangelight AT %QX0.1 : BOOL;
    Greenlight AT %QX0.2 : BOOL;
  END_VAR
  VAR
    TON0 : TON;
    Step_0 : BOOL;
    Step_1 : BOOL;
    Step_2 : BOOL;
    TON1 : TON;
    TON2 : TON;
  END_VAR
  VAR
    Pedestrian_PB AT %QX0.4 : BOOL;
    Emergency_mode AT %QX0.3 : BOOL;
  END_VAR
  VAR
    R_TRIG0 : R_TRIG;
    _TMP_OR27_OUT : BOOL;
    _TMP_OR24_OUT : BOOL;
    _TMP_NOT30_OUT : BOOL;
    _TMP_AND29_OUT : BOOL;
    _TMP_OR16_OUT : BOOL;
  END_VAR

  INITIAL_STEP Step0:
    Redlight(N);
    Step_0(N);
    COMPUTE_FUNCTION_BLOCKS(S);
  END_STEP

  ACTION COMPUTE_FUNCTION_BLOCKS:
    TON0(IN := Step_0, PT := T#6s);
    _TMP_OR27_OUT := OR(TON0.Q, Emergency_mode);
    TON1(IN := Step_1, PT := T#6s);
    R_TRIG0(CLK := Pedestrian_PB);
    _TMP_OR24_OUT := OR(TON1.Q, R_TRIG0.Q);
    _TMP_NOT30_OUT := NOT(Emergency_mode);
    _TMP_AND29_OUT := AND(_TMP_OR24_OUT, _TMP_NOT30_OUT);
    TON2(IN := Step_2, PT := T#3s);
    _TMP_OR16_OUT := OR(TON2.Q, Emergency_mode);
  END_ACTION

  TRANSITION FROM Step0 TO Step1
    := _TMP_OR27_OUT;
  END_TRANSITION

  STEP Step1:
    Greenlight(N);
    Step_1(N);
  END_STEP

  TRANSITION FROM Step1 TO Step2
    := _TMP_AND29_OUT;
  END_TRANSITION

  STEP Step2:
    Orangelight(N);
    Step_2(N);
  END_STEP

  TRANSITION FROM Step2 TO Step0
    := _TMP_OR16_OUT;
  END_TRANSITION

END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : TrafficLight;
  END_RESOURCE
END_CONFIGURATION
