// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// OK, `const (const i32)` is the same type as `const i32`.
// CHECK:STDERR: collapse.carbon:[[@LINE+3]]:25: `const` applied repeatedly to the same type has no additional effect.
// CHECK:STDERR: fn F(p: const i32**) -> const (const i32)** {
// CHECK:STDERR:                         ^~~~~~~~~~~~~~~~~
fn F(p: const i32**) -> const (const i32)** {
  return p;
}

// CHECK:STDOUT: --- collapse.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = const_type i32 [template]
// CHECK:STDOUT:   %.2: type = ptr_type const i32 [template]
// CHECK:STDOUT:   %.3: type = ptr_type const i32* [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %F: <function> = fn_decl @F [template] {
// CHECK:STDOUT:     %.loc11_9: type = const_type i32 [template = constants.%.1]
// CHECK:STDOUT:     %.loc11_18: type = ptr_type const i32 [template = constants.%.2]
// CHECK:STDOUT:     %.loc11_19: type = ptr_type const i32* [template = constants.%.3]
// CHECK:STDOUT:     %p.loc11_6.1: const i32** = param p
// CHECK:STDOUT:     @F.%p: const i32** = bind_name p, %p.loc11_6.1
// CHECK:STDOUT:     %.loc11_32: type = const_type i32 [template = constants.%.1]
// CHECK:STDOUT:     %.loc11_25: type = const_type const i32 [template = constants.%.1]
// CHECK:STDOUT:     %.loc11_42: type = ptr_type const i32 [template = constants.%.2]
// CHECK:STDOUT:     %.loc11_43: type = ptr_type const i32* [template = constants.%.3]
// CHECK:STDOUT:     @F.%return: ref const i32** = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%p: const i32**) -> const i32** {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %p.ref: const i32** = name_ref p, %p
// CHECK:STDOUT:   return %p.ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
