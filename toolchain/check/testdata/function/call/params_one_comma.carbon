// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Foo(a: i32,) {}

fn Main() {
  Foo(1);
  Foo(1,);
}

// CHECK:STDOUT: --- params_one_comma.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Foo = %Foo
// CHECK:STDOUT:     .Main = %Main
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Foo: <function> = fn_decl @Foo [template] {
// CHECK:STDOUT:     %a.loc7_8.1: i32 = param a
// CHECK:STDOUT:     @Foo.%a: i32 = bind_name a, %a.loc7_8.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Main: <function> = fn_decl @Main [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Foo(%a: i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Foo.ref.loc10: <function> = name_ref Foo, file.%Foo [template = file.%Foo]
// CHECK:STDOUT:   %.loc10: i32 = int_literal 1 [template = constants.%.1]
// CHECK:STDOUT:   %Foo.call.loc10: init () = call %Foo.ref.loc10(%.loc10)
// CHECK:STDOUT:   %Foo.ref.loc11: <function> = name_ref Foo, file.%Foo [template = file.%Foo]
// CHECK:STDOUT:   %.loc11: i32 = int_literal 1 [template = constants.%.1]
// CHECK:STDOUT:   %Foo.call.loc11: init () = call %Foo.ref.loc11(%.loc11)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
