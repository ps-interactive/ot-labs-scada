PROGRAM LevelControl
  VAR
    Measured_value AT %QW0.0 : DINT := 32000;
    Displayed_value AT %QW0.1 : DINT;
    Calibrated_scale AT %QW0.2 : DINT := 65;
  END_VAR
  VAR
    Oscillator : BOOL;
    TimerON : TON;
    TimerOFF : TOF;
    timer : BOOL;
    PulseCounter : CTU;
    elapsed_time : TIME;
    Current_value : INT;
    F : REAL;
    Period : REAL := 0.01;
    Amplitude : REAL := 655.0;
    Setpoint : REAL := 58981.0;
    _TMP_DIV4_OUT : DINT;
    R_TRIG1 : R_TRIG;
    _TMP_ABS50_OUT : REAL;
    _TMP_REAL_TO_DINT51_OUT : DINT;
    _TMP_INT_TO_REAL35_OUT : REAL;
    _TMP_MUL26_OUT : REAL;
    _TMP_DIV30_OUT : REAL;
    _TMP_SIN45_OUT : REAL;
    _TMP_MUL37_OUT : REAL;
    _TMP_ADD33_OUT : REAL;
  END_VAR

  _TMP_DIV4_OUT := DIV(Measured_value, Calibrated_scale);
  Displayed_value := _TMP_DIV4_OUT;
  TimerON(IN := NOT(Oscillator), PT := T#100ms);
  TimerOFF(IN := TimerON.Q, PT := T#100ms);
  Oscillator := TimerOFF.Q;
  R_TRIG1(CLK := NOT(Oscillator));
  PulseCounter(CU := R_TRIG1.Q, PV := 10000);
  timer := PulseCounter.Q;
  Current_value := PulseCounter.CV;
  _TMP_ABS50_OUT := ABS(F);
  _TMP_REAL_TO_DINT51_OUT := REAL_TO_DINT(_TMP_ABS50_OUT);
  Measured_value := _TMP_REAL_TO_DINT51_OUT;
  _TMP_INT_TO_REAL35_OUT := INT_TO_REAL(Current_value);
  _TMP_MUL26_OUT := MUL(2.0, 3.142, _TMP_INT_TO_REAL35_OUT);
  _TMP_DIV30_OUT := DIV(_TMP_MUL26_OUT, Period);
  _TMP_SIN45_OUT := SIN(_TMP_DIV30_OUT);
  _TMP_MUL37_OUT := MUL(_TMP_SIN45_OUT, Amplitude);
  _TMP_ADD33_OUT := ADD(_TMP_MUL37_OUT, Setpoint);
  F := _TMP_ADD33_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : LevelControl;
  END_RESOURCE
END_CONFIGURATION
