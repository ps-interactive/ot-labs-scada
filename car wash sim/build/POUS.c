void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void PYTHON_EVAL_init__(PYTHON_EVAL *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->BUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->PREBUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->TRIGM1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRIGGED,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_EVAL_body__(PYTHON_EVAL *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __IL_DEFVAR_T __IL_DEFVAR;
  __IL_DEFVAR_T __IL_DEFVAR_BACK;
  #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
  #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)
extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(0, data__);
  #undef GetFbVar
  #undef SetFbVar
;

  goto __end;

__end:
  return;
} // PYTHON_EVAL_body__() 





void PYTHON_POLL_init__(PYTHON_POLL *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->BUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->PREBUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->TRIGM1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRIGGED,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_POLL_body__(PYTHON_POLL *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __IL_DEFVAR_T __IL_DEFVAR;
  __IL_DEFVAR_T __IL_DEFVAR_BACK;
  #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
  #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)
extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(1,(PYTHON_EVAL*)(void*)data__);
  #undef GetFbVar
  #undef SetFbVar
;

  goto __end;

__end:
  return;
} // PYTHON_POLL_body__() 





void PYTHON_GEAR_init__(PYTHON_GEAR *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->N,0,retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  PYTHON_EVAL_init__(&data__->PY_EVAL,retain);
  __INIT_VAR(data__->COUNTER,0,retain)
  __INIT_VAR(data__->_TMP_ADD10_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EQ13_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_SEL15_OUT,0,retain)
  __INIT_VAR(data__->_TMP_AND7_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_GEAR_body__(PYTHON_GEAR *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __SET_VAR(data__->,_TMP_ADD10_OUT,,ADD__UINT__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (UINT)__GET_VAR(data__->COUNTER,),
    (UINT)1));
  __SET_VAR(data__->,_TMP_EQ13_OUT,,EQ__BOOL__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (UINT)__GET_VAR(data__->N,),
    (UINT)__GET_VAR(data__->_TMP_ADD10_OUT,)));
  __SET_VAR(data__->,_TMP_SEL15_OUT,,SEL__UINT__BOOL__UINT__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (BOOL)__GET_VAR(data__->_TMP_EQ13_OUT,),
    (UINT)__GET_VAR(data__->_TMP_ADD10_OUT,),
    (UINT)0));
  __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->_TMP_SEL15_OUT,));
  __SET_VAR(data__->,_TMP_AND7_OUT,,AND__BOOL__BOOL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (BOOL)__GET_VAR(data__->_TMP_EQ13_OUT,),
    (BOOL)__GET_VAR(data__->TRIG,)));
  __SET_VAR(data__->PY_EVAL.,TRIG,,__GET_VAR(data__->_TMP_AND7_OUT,));
  __SET_VAR(data__->PY_EVAL.,CODE,,__GET_VAR(data__->CODE,));
  PYTHON_EVAL_body__(&data__->PY_EVAL);
  __SET_VAR(data__->,ACK,,__GET_VAR(data__->PY_EVAL.ACK,));
  __SET_VAR(data__->,RESULT,,__GET_VAR(data__->PY_EVAL.RESULT,));

  goto __end;

__end:
  return;
} // PYTHON_GEAR_body__() 





void CAR_WASH_init__(CAR_WASH *data__, BOOL retain) {
  __INIT_VAR(data__->CONVEYOR_MOTOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->WASHER_1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->WASHER_2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BRUSH_1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BRUSH_2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RINSE_1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RINSE_2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DRYER_1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DRYER_2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->IN_USE_LIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->WASH_COMPLETE_LIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MASTER_START,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MASTER_STOP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->ENTRY_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->WASHING_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BRUSHING_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RINSING_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DRYING_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->EXIT_SENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MASTER_COIL,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CONVEYOR_START_DELAY,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->WASHING_TIME,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BRUSHING_TIME,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RINSING_TIME,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DRYING_TIME,__BOOL_LITERAL(FALSE),retain)
  TON_init__(&data__->TON0,retain);
  __INIT_VAR(data__->CONVEYOR_DELAY_PT,__time_to_timespec(1, 0, 5, 0, 0, 0),retain)
  TON_init__(&data__->TON1,retain);
  __INIT_VAR(data__->WASH_TIME_PT,__time_to_timespec(1, 0, 5, 0, 0, 0),retain)
  TON_init__(&data__->TON2,retain);
  __INIT_VAR(data__->BRUSH_TIME_PT,__time_to_timespec(1, 0, 5, 0, 0, 0),retain)
  TON_init__(&data__->TON3,retain);
  __INIT_VAR(data__->RINSE_TIME_PT,__time_to_timespec(1, 0, 5, 0, 0, 0),retain)
  TON_init__(&data__->TON4,retain);
  __INIT_VAR(data__->DRY_TIME_PT,__time_to_timespec(1, 0, 5, 0, 0, 0),retain)
  __INIT_VAR(data__->EXIT_DELAY,__time_to_timespec(1, 0, 3, 0, 0, 0),retain)
}

// Code part
void CAR_WASH_body__(CAR_WASH *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,MASTER_COIL,,(!(__GET_VAR(data__->MASTER_STOP,)) && (__GET_VAR(data__->MASTER_COIL,) || __GET_VAR(data__->MASTER_START,))));
  __SET_VAR(data__->TON0.,IN,,((!(__GET_VAR(data__->WASH_COMPLETE_LIGHT,)) && (((((__GET_VAR(data__->BRUSHING_SENSOR,) || __GET_VAR(data__->CONVEYOR_START_DELAY,)) || __GET_VAR(data__->DRYING_SENSOR,)) || __GET_VAR(data__->ENTRY_SENSOR,)) || __GET_VAR(data__->RINSING_SENSOR,)) || __GET_VAR(data__->WASHING_SENSOR,))) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON0.,PT,,__GET_VAR(data__->CONVEYOR_DELAY_PT,));
  TON_body__(&data__->TON0);
  __SET_VAR(data__->,CONVEYOR_START_DELAY,,__GET_VAR(data__->TON0.Q,));
  __SET_VAR(data__->,IN_USE_LIGHT,,((!(__GET_VAR(data__->WASH_COMPLETE_LIGHT,)) && (((((__GET_VAR(data__->BRUSHING_SENSOR,) || __GET_VAR(data__->CONVEYOR_START_DELAY,)) || __GET_VAR(data__->DRYING_SENSOR,)) || __GET_VAR(data__->ENTRY_SENSOR,)) || __GET_VAR(data__->RINSING_SENSOR,)) || __GET_VAR(data__->WASHING_SENSOR,))) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,CONVEYOR_MOTOR,,(((((!(__GET_VAR(data__->DRYER_1,)) && !(__GET_VAR(data__->RINSE_1,))) && !(__GET_VAR(data__->BRUSH_1,))) && !(__GET_VAR(data__->WASHER_1,))) && __GET_VAR(data__->CONVEYOR_START_DELAY,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,WASHER_1,,((!(__GET_VAR(data__->WASHING_TIME,)) && __GET_VAR(data__->WASHING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,WASHER_2,,((!(__GET_VAR(data__->WASHING_TIME,)) && __GET_VAR(data__->WASHING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON1.,IN,,(__GET_VAR(data__->WASHING_SENSOR,) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON1.,PT,,__GET_VAR(data__->WASH_TIME_PT,));
  TON_body__(&data__->TON1);
  __SET_VAR(data__->,WASHING_TIME,,__GET_VAR(data__->TON1.Q,));
  __SET_VAR(data__->,BRUSH_1,,((!(__GET_VAR(data__->BRUSHING_TIME,)) && __GET_VAR(data__->BRUSHING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,BRUSH_2,,((!(__GET_VAR(data__->BRUSHING_TIME,)) && __GET_VAR(data__->BRUSHING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON2.,IN,,(__GET_VAR(data__->BRUSHING_SENSOR,) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON2.,PT,,__GET_VAR(data__->BRUSH_TIME_PT,));
  TON_body__(&data__->TON2);
  __SET_VAR(data__->,BRUSHING_TIME,,__GET_VAR(data__->TON2.Q,));
  __SET_VAR(data__->,RINSE_1,,((!(__GET_VAR(data__->RINSING_TIME,)) && __GET_VAR(data__->RINSING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,RINSE_2,,((!(__GET_VAR(data__->RINSING_TIME,)) && __GET_VAR(data__->RINSING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON3.,IN,,(__GET_VAR(data__->RINSING_SENSOR,) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON3.,PT,,__GET_VAR(data__->RINSE_TIME_PT,));
  TON_body__(&data__->TON3);
  __SET_VAR(data__->,RINSING_TIME,,__GET_VAR(data__->TON3.Q,));
  __SET_VAR(data__->,DRYER_1,,((!(__GET_VAR(data__->DRYING_TIME,)) && __GET_VAR(data__->DRYING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->,DRYER_2,,((!(__GET_VAR(data__->DRYING_TIME,)) && __GET_VAR(data__->DRYING_SENSOR,)) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON4.,IN,,(__GET_VAR(data__->DRYING_SENSOR,) && __GET_VAR(data__->MASTER_COIL,)));
  __SET_VAR(data__->TON4.,PT,,__GET_VAR(data__->DRY_TIME_PT,));
  TON_body__(&data__->TON4);
  __SET_VAR(data__->,DRYING_TIME,,__GET_VAR(data__->TON4.Q,));
  __SET_VAR(data__->,WASH_COMPLETE_LIGHT,,((__GET_VAR(data__->EXIT_SENSOR,) && (!(__GET_VAR(data__->ENTRY_SENSOR,)) || __GET_VAR(data__->WASH_COMPLETE_LIGHT,))) && __GET_VAR(data__->MASTER_COIL,)));

  goto __end;

__end:
  return;
} // CAR_WASH_body__() 





