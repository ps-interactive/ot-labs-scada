FUNCTION_BLOCK rand_generator
  VAR_INPUT
    IN : BOOL;
  END_VAR
  VAR
    M : BOOL := 0;
    INIT : BOOL := 0;
  END_VAR
  VAR_OUTPUT
    OUT : UDINT := 0;
  END_VAR
  
  {#include <stdlib.h>}
  IF INIT = 0 THEN
    {
      time_t t;
      srand((unsigned) time(&t))
    }
    INIT := 1;
  END_IF;

  IF M = 0 and INIT = 1 THEN
    {
      double l, u, r;
      int output;
      l=58326;
      u=59636;
      r=rand();
      r=(r/RAND_MAX)*(u-l)+l;
      output = r;
      SetFbVar(OUT,output)
    }
  END_IF;
END_FUNCTION_BLOCK

PROGRAM LevelControl
  VAR
    Measured_value AT %QW0 : UDINT := 32000;
    Displayed_value AT %QW1 : UDINT;
    Calibrated_scale AT %QW2 : UDINT := 65;
  END_VAR
  VAR
    button : BOOL;
    value : UDINT;
    rand_generator0 : rand_generator;
    R_TRIG1 : R_TRIG;
    _TMP_DIV4_OUT : UDINT;
  END_VAR

  R_TRIG1(CLK := button);
  rand_generator0(IN := R_TRIG1.Q);
  _TMP_DIV4_OUT := DIV(rand_generator0.OUT, Calibrated_scale);
  Displayed_value := _TMP_DIV4_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#1s0ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : LevelControl;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "93800005f47be48fa9f9e4edeb4cefa6";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern LEVELCONTROL RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.MEASURED_VALUE), UDINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DISPLAYED_VALUE), UDINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CALIBRATED_SCALE), UDINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BUTTON), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.VALUE), UDINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.INIT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RAND_GENERATOR0.OUT), UDINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_DIV4_OUT), UDINT_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               17*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    case UDINT_ENUM:*)
(*DBG:        return sizeof(UDINT);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case UDINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_UDINT_t *) ptr)->value;*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case UDINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_UDINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_UDINT_t *) ptr)->value = *((UDINT *) val);*)
(*DBG:            ((__IEC_UDINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case UDINT_ENUM:*)
(*DBG:            ((__IEC_UDINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
