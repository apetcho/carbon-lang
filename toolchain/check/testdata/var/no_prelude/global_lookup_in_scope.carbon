// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var x: {.v: ()} = {.v = ()};

fn Main() {
  var y: {.v: ()} = x;
}

// CHECK:STDOUT: --- global_lookup_in_scope.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %.2: type = struct_type {.v: ()} [template]
// CHECK:STDOUT:   %.3: () = tuple_value () [template]
// CHECK:STDOUT:   %.4: {.v: ()} = struct_value (%.3) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .x = %x
// CHECK:STDOUT:     .Main = %Main
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc7_14.1: () = tuple_literal ()
// CHECK:STDOUT:   %.loc7_14.2: type = converted %.loc7_14.1, constants.%.1 [template = constants.%.1]
// CHECK:STDOUT:   %.loc7_15: type = struct_type {.v: ()} [template = constants.%.2]
// CHECK:STDOUT:   %x.var: ref {.v: ()} = var x
// CHECK:STDOUT:   %x: ref {.v: ()} = bind_name x, %x.var
// CHECK:STDOUT:   %Main: <function> = fn_decl @Main [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_16.1: () = tuple_literal ()
// CHECK:STDOUT:   %.loc10_16.2: type = converted %.loc10_16.1, constants.%.1 [template = constants.%.1]
// CHECK:STDOUT:   %.loc10_17: type = struct_type {.v: ()} [template = constants.%.2]
// CHECK:STDOUT:   %y.var: ref {.v: ()} = var y
// CHECK:STDOUT:   %y: ref {.v: ()} = bind_name y, %y.var
// CHECK:STDOUT:   %x.ref: ref {.v: ()} = name_ref x, file.%x
// CHECK:STDOUT:   %.loc10_21.1: ref () = struct_access %x.ref, element0
// CHECK:STDOUT:   %.loc10_21.2: ref () = struct_access %y.var, element0
// CHECK:STDOUT:   %.loc10_21.3: init () = tuple_init () to %.loc10_21.2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc10_21.4: init () = converted %.loc10_21.1, %.loc10_21.3 [template = constants.%.3]
// CHECK:STDOUT:   %.loc10_21.5: init {.v: ()} = struct_init (%.loc10_21.4) to %y.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc10_22: init {.v: ()} = converted %x.ref, %.loc10_21.5 [template = constants.%.4]
// CHECK:STDOUT:   assign %y.var, %.loc10_22
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7_26.1: () = tuple_literal ()
// CHECK:STDOUT:   %.loc7_27.1: {.v: ()} = struct_literal (%.loc7_26.1)
// CHECK:STDOUT:   %.loc7_27.2: ref () = struct_access file.%x.var, element0
// CHECK:STDOUT:   %.loc7_26.2: init () = tuple_init () to %.loc7_27.2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc7_27.3: init () = converted %.loc7_26.1, %.loc7_26.2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc7_27.4: init {.v: ()} = struct_init (%.loc7_27.3) to file.%x.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_28: init {.v: ()} = converted %.loc7_27.1, %.loc7_27.4 [template = constants.%.4]
// CHECK:STDOUT:   assign file.%x.var, %.loc7_28
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
