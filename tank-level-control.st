PROGRAM LevelControl
  VAR
    Measured_value AT %QW0.0 : INT;
    Displayed_value AT %QW0.1 : INT;
    Calibrated_scale AT %QW0.2 : INT := 65;
  END_VAR
  VAR
    Oscillator : BOOL;
    TimerON : TON;
    TimerOFF : TOF;
    timer : BOOL;
    PulseCounter : CTU;
    _TMP_DIV4_OUT : INT;
    R_TRIG1 : R_TRIG;
    _TMP_MUL52_OUT : INT;
    _TMP_ADD56_OUT : INT;
  END_VAR

  _TMP_DIV4_OUT := DIV(Measured_value, Calibrated_scale);
  Displayed_value := _TMP_DIV4_OUT;
  TimerON(IN := NOT(Oscillator), PT := T#10ms);
  TimerOFF(IN := TimerON.Q, PT := T#10ms);
  Oscillator := TimerOFF.Q;
  R_TRIG1(CLK := NOT(Oscillator));
  PulseCounter(CU := R_TRIG1.Q, R := PulseCounter.Q, PV := 10);
  timer := PulseCounter.Q;
  _TMP_MUL52_OUT := MUL(PulseCounter.CV, 100);
  _TMP_ADD56_OUT := ADD(_TMP_MUL52_OUT, 10000);
  Measured_value := _TMP_ADD56_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : LevelControl;
  END_RESOURCE
END_CONFIGURATION
