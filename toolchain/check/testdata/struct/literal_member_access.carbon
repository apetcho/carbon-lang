// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn G() -> {.x: i32, .y: i32, .z: i32};

fn F() -> i32 {
  return {.a = 1, .b = G(), .c = 3}.b.y;
}

// CHECK:STDOUT: --- literal_member_access.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = struct_type {.x: i32, .y: i32, .z: i32} [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: type = ptr_type {.x: i32, .y: i32, .z: i32} [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.5: type = struct_type {.a: i32, .b: {.x: i32, .y: i32, .z: i32}, .c: i32} [template]
// CHECK:STDOUT:   %.6: type = struct_type {.a: i32, .b: {.x: i32, .y: i32, .z: i32}*, .c: i32} [template]
// CHECK:STDOUT:   %.7: type = ptr_type {.a: i32, .b: {.x: i32, .y: i32, .z: i32}*, .c: i32} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .G = %G
// CHECK:STDOUT:     .F = %F
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %G: <function> = fn_decl @G [template] {
// CHECK:STDOUT:     %.loc7: type = struct_type {.x: i32, .y: i32, .z: i32} [template = constants.%.1]
// CHECK:STDOUT:     @G.%return: ref {.x: i32, .y: i32, .z: i32} = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %F: <function> = fn_decl @F [template] {
// CHECK:STDOUT:     @F.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() -> {.x: i32, .y: i32, .z: i32};
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_16: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %G.ref: <function> = name_ref G, file.%G [template = file.%G]
// CHECK:STDOUT:   %.loc10_25.1: ref {.x: i32, .y: i32, .z: i32} = temporary_storage
// CHECK:STDOUT:   %G.call: init {.x: i32, .y: i32, .z: i32} = call %G.ref() to %.loc10_25.1
// CHECK:STDOUT:   %.loc10_34: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   %.loc10_35.1: {.a: i32, .b: {.x: i32, .y: i32, .z: i32}, .c: i32} = struct_literal (%.loc10_16, %G.call, %.loc10_34)
// CHECK:STDOUT:   %.loc10_25.2: ref {.x: i32, .y: i32, .z: i32} = temporary %.loc10_25.1, %G.call
// CHECK:STDOUT:   %.loc10_25.3: ref i32 = struct_access %.loc10_25.2, element0
// CHECK:STDOUT:   %.loc10_25.4: i32 = bind_value %.loc10_25.3
// CHECK:STDOUT:   %.loc10_25.5: ref i32 = struct_access %.loc10_25.2, element1
// CHECK:STDOUT:   %.loc10_25.6: i32 = bind_value %.loc10_25.5
// CHECK:STDOUT:   %.loc10_25.7: ref i32 = struct_access %.loc10_25.2, element2
// CHECK:STDOUT:   %.loc10_25.8: i32 = bind_value %.loc10_25.7
// CHECK:STDOUT:   %.loc10_25.9: {.x: i32, .y: i32, .z: i32} = struct_value (%.loc10_25.4, %.loc10_25.6, %.loc10_25.8)
// CHECK:STDOUT:   %.loc10_35.2: {.x: i32, .y: i32, .z: i32} = converted %G.call, %.loc10_25.9
// CHECK:STDOUT:   %.loc10_35.3: {.a: i32, .b: {.x: i32, .y: i32, .z: i32}, .c: i32} = struct_value (%.loc10_16, %.loc10_35.2, %.loc10_34)
// CHECK:STDOUT:   %.loc10_35.4: {.a: i32, .b: {.x: i32, .y: i32, .z: i32}, .c: i32} = converted %.loc10_35.1, %.loc10_35.3
// CHECK:STDOUT:   %.loc10_36: {.x: i32, .y: i32, .z: i32} = struct_access %.loc10_35.4, element1
// CHECK:STDOUT:   %.loc10_38: i32 = struct_access %.loc10_36, element1
// CHECK:STDOUT:   return %.loc10_38
// CHECK:STDOUT: }
// CHECK:STDOUT:
