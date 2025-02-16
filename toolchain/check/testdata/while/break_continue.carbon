// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn A() -> bool;
fn B() -> bool;
fn C() -> bool;
fn D() -> bool;
fn E() -> bool;
fn F() -> bool;
fn G() -> bool;
fn H() -> bool;

fn While() {
  while (A()) {
    if (B()) { continue; }
    if (C()) { break; }
    while (D()) {
      if (E()) { continue; }
      if (F()) { break; }
    }
    if (G()) { continue; }
    if (H()) { break; }
  }
}

// CHECK:STDOUT: --- break_continue.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .A = %A
// CHECK:STDOUT:     .B = %B
// CHECK:STDOUT:     .C = %C
// CHECK:STDOUT:     .D = %D
// CHECK:STDOUT:     .E = %E
// CHECK:STDOUT:     .F = %F
// CHECK:STDOUT:     .G = %G
// CHECK:STDOUT:     .H = %H
// CHECK:STDOUT:     .While = %While
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %A: <function> = fn_decl @A [template] {
// CHECK:STDOUT:     @A.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %B: <function> = fn_decl @B [template] {
// CHECK:STDOUT:     @B.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %C: <function> = fn_decl @C [template] {
// CHECK:STDOUT:     @C.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %D: <function> = fn_decl @D [template] {
// CHECK:STDOUT:     @D.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %E: <function> = fn_decl @E [template] {
// CHECK:STDOUT:     @E.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %F: <function> = fn_decl @F [template] {
// CHECK:STDOUT:     @F.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G: <function> = fn_decl @G [template] {
// CHECK:STDOUT:     @G.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %H: <function> = fn_decl @H [template] {
// CHECK:STDOUT:     @H.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %While: <function> = fn_decl @While [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @A() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @B() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @C() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @D() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @E() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @H() -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @While() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   br !while.cond.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !while.cond.loc17:
// CHECK:STDOUT:   %A.ref: <function> = name_ref A, file.%A [template = file.%A]
// CHECK:STDOUT:   %A.call: init bool = call %A.ref()
// CHECK:STDOUT:   %.loc17_13.1: bool = value_of_initializer %A.call
// CHECK:STDOUT:   %.loc17_13.2: bool = converted %A.call, %.loc17_13.1
// CHECK:STDOUT:   if %.loc17_13.2 br !while.body.loc17 else br !while.done.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !while.body.loc17:
// CHECK:STDOUT:   %B.ref: <function> = name_ref B, file.%B [template = file.%B]
// CHECK:STDOUT:   %B.call: init bool = call %B.ref()
// CHECK:STDOUT:   %.loc18_12.1: bool = value_of_initializer %B.call
// CHECK:STDOUT:   %.loc18_12.2: bool = converted %B.call, %.loc18_12.1
// CHECK:STDOUT:   if %.loc18_12.2 br !if.then.loc18 else br !if.else.loc18
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc18:
// CHECK:STDOUT:   br !while.cond.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc18:
// CHECK:STDOUT:   %C.ref: <function> = name_ref C, file.%C [template = file.%C]
// CHECK:STDOUT:   %C.call: init bool = call %C.ref()
// CHECK:STDOUT:   %.loc19_12.1: bool = value_of_initializer %C.call
// CHECK:STDOUT:   %.loc19_12.2: bool = converted %C.call, %.loc19_12.1
// CHECK:STDOUT:   if %.loc19_12.2 br !if.then.loc19 else br !if.else.loc19
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc19:
// CHECK:STDOUT:   br !while.done.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc19:
// CHECK:STDOUT:   br !while.cond.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: !while.cond.loc20:
// CHECK:STDOUT:   %D.ref: <function> = name_ref D, file.%D [template = file.%D]
// CHECK:STDOUT:   %D.call: init bool = call %D.ref()
// CHECK:STDOUT:   %.loc20_15.1: bool = value_of_initializer %D.call
// CHECK:STDOUT:   %.loc20_15.2: bool = converted %D.call, %.loc20_15.1
// CHECK:STDOUT:   if %.loc20_15.2 br !while.body.loc20 else br !while.done.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: !while.body.loc20:
// CHECK:STDOUT:   %E.ref: <function> = name_ref E, file.%E [template = file.%E]
// CHECK:STDOUT:   %E.call: init bool = call %E.ref()
// CHECK:STDOUT:   %.loc21_14.1: bool = value_of_initializer %E.call
// CHECK:STDOUT:   %.loc21_14.2: bool = converted %E.call, %.loc21_14.1
// CHECK:STDOUT:   if %.loc21_14.2 br !if.then.loc21 else br !if.else.loc21
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc21:
// CHECK:STDOUT:   br !while.cond.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc21:
// CHECK:STDOUT:   %F.ref: <function> = name_ref F, file.%F [template = file.%F]
// CHECK:STDOUT:   %F.call: init bool = call %F.ref()
// CHECK:STDOUT:   %.loc22_14.1: bool = value_of_initializer %F.call
// CHECK:STDOUT:   %.loc22_14.2: bool = converted %F.call, %.loc22_14.1
// CHECK:STDOUT:   if %.loc22_14.2 br !if.then.loc22 else br !if.else.loc22
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc22:
// CHECK:STDOUT:   br !while.done.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc22:
// CHECK:STDOUT:   br !while.cond.loc20
// CHECK:STDOUT:
// CHECK:STDOUT: !while.done.loc20:
// CHECK:STDOUT:   %G.ref: <function> = name_ref G, file.%G [template = file.%G]
// CHECK:STDOUT:   %G.call: init bool = call %G.ref()
// CHECK:STDOUT:   %.loc24_12.1: bool = value_of_initializer %G.call
// CHECK:STDOUT:   %.loc24_12.2: bool = converted %G.call, %.loc24_12.1
// CHECK:STDOUT:   if %.loc24_12.2 br !if.then.loc24 else br !if.else.loc24
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc24:
// CHECK:STDOUT:   br !while.cond.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc24:
// CHECK:STDOUT:   %H.ref: <function> = name_ref H, file.%H [template = file.%H]
// CHECK:STDOUT:   %H.call: init bool = call %H.ref()
// CHECK:STDOUT:   %.loc25_12.1: bool = value_of_initializer %H.call
// CHECK:STDOUT:   %.loc25_12.2: bool = converted %H.call, %.loc25_12.1
// CHECK:STDOUT:   if %.loc25_12.2 br !if.then.loc25 else br !if.else.loc25
// CHECK:STDOUT:
// CHECK:STDOUT: !if.then.loc25:
// CHECK:STDOUT:   br !while.done.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !if.else.loc25:
// CHECK:STDOUT:   br !while.cond.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: !while.done.loc17:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
