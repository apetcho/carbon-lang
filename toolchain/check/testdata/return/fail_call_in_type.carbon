// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// TODO: Some variant of this should work, once compile-time function calls are
// supported.
fn ReturnType() -> type { return i32; }
// CHECK:STDERR: fail_call_in_type.carbon:[[@LINE+3]]:13: ERROR: Cannot evaluate type expression.
// CHECK:STDERR: fn Six() -> ReturnType() { return 6; }
// CHECK:STDERR:             ^~~~~~~~~~~~
fn Six() -> ReturnType() { return 6; }

// CHECK:STDOUT: --- fail_call_in_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: i32 = int_literal 6 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .ReturnType = %ReturnType
// CHECK:STDOUT:     .Six = %Six
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %ReturnType: <function> = fn_decl @ReturnType [template] {
// CHECK:STDOUT:     @ReturnType.%return: ref type = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Six: <function> = fn_decl @Six [template] {
// CHECK:STDOUT:     %ReturnType.ref: <function> = name_ref ReturnType, %ReturnType [template = %ReturnType]
// CHECK:STDOUT:     %ReturnType.call: init type = call %ReturnType.ref()
// CHECK:STDOUT:     %.loc13_24.1: type = value_of_initializer %ReturnType.call
// CHECK:STDOUT:     %.loc13_24.2: type = converted %ReturnType.call, %.loc13_24.1
// CHECK:STDOUT:     @Six.%return: ref <error> = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @ReturnType() -> type {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return i32
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Six() -> <error> {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc13: i32 = int_literal 6 [template = constants.%.1]
// CHECK:STDOUT:   return <error>
// CHECK:STDOUT: }
// CHECK:STDOUT:
