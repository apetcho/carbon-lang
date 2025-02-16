// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- impl.carbon

package Impl api;

interface HasF {
  fn F();
}

class C {}

impl C as HasF {
  fn F() {}
}

// --- use.carbon

import Impl;

fn G(c: Impl.C) {
  c.(Impl.HasF.F)();
}

// CHECK:STDOUT: --- impl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = interface_type @HasF [template]
// CHECK:STDOUT:   %Self: HasF = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.2: type = assoc_entity_type @HasF, <function> [template]
// CHECK:STDOUT:   %.3: <associated <function> in HasF> = assoc_entity element0, @HasF.%F [template]
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = interface_witness (@impl.%F) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .HasF = %HasF.decl
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %HasF.decl: type = interface_decl @HasF [template = constants.%.1] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   impl_decl @impl {
// CHECK:STDOUT:     %C.ref: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %HasF.ref: type = name_ref HasF, %HasF.decl [template = constants.%.1]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @HasF {
// CHECK:STDOUT:   %Self: HasF = bind_symbolic_name Self 0 [symbolic = constants.%Self]
// CHECK:STDOUT:   %F: <function> = fn_decl @F.1 [template] {}
// CHECK:STDOUT:   %.loc5: <associated <function> in HasF> = assoc_entity element0, %F [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   .F = %.loc5
// CHECK:STDOUT:   witness = (%F)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl: C as HasF {
// CHECK:STDOUT:   %F: <function> = fn_decl @F.2 [template] {}
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%F) [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .F = %F
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F.1();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F.2() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- use.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = interface_type @HasF [template]
// CHECK:STDOUT:   %Self: HasF = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.3: type = tuple_type () [template]
// CHECK:STDOUT:   %.4: type = ptr_type {} [template]
// CHECK:STDOUT:   %.5: type = assoc_entity_type @HasF, <function> [template]
// CHECK:STDOUT:   %.6: <associated <function> in HasF> = assoc_entity element0, file.%import_ref.8 [template]
// CHECK:STDOUT:   %.7: <witness> = interface_witness (<unexpected instref inst+32>) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Impl = %Impl
// CHECK:STDOUT:     .G = %G
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Impl: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.1 = import_ref ir1, inst+10, unloaded
// CHECK:STDOUT:   %HasF.decl: type = interface_decl @HasF [template = constants.%.2] {}
// CHECK:STDOUT:   %import_ref.2: <associated <function> in HasF> = import_ref ir1, inst+7, loc_20 [template = constants.%.6]
// CHECK:STDOUT:   %import_ref.3 = import_ref ir1, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.4 = import_ref ir1, inst+5, unloaded
// CHECK:STDOUT:   %import_ref.5: <witness> = import_ref ir1, inst+16, loc_22 [template = constants.%.7]
// CHECK:STDOUT:   %import_ref.6: type = import_ref ir1, inst+9, loc_10 [template = constants.%C]
// CHECK:STDOUT:   %G: <function> = fn_decl @G [template] {
// CHECK:STDOUT:     %Impl.ref: <namespace> = name_ref Impl, %Impl [template = %Impl]
// CHECK:STDOUT:     %C.ref: type = name_ref C, %import_ref.6 [template = constants.%C]
// CHECK:STDOUT:     %c.loc4_6.1: C = param c
// CHECK:STDOUT:     @G.%c: C = bind_name c, %c.loc4_6.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.7: type = import_ref ir1, inst+1, loc_18 [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.8 = import_ref ir1, inst+5, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @HasF {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .F = file.%import_ref.2
// CHECK:STDOUT:   .Self = file.%import_ref.3
// CHECK:STDOUT:   witness = (file.%import_ref.4)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl: C as HasF;
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G(%c: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %c.ref: C = name_ref c, %c
// CHECK:STDOUT:   %Impl.ref: <namespace> = name_ref Impl, file.%Impl [template = file.%Impl]
// CHECK:STDOUT:   %HasF.ref: type = name_ref HasF, file.%import_ref.7 [template = constants.%.2]
// CHECK:STDOUT:   %F.ref: <associated <function> in HasF> = name_ref F, file.%import_ref.2 [template = constants.%.6]
// CHECK:STDOUT:   %.1: <function> = interface_witness_access file.%import_ref.5, element0 [template = <unexpected instref inst+32>]
// CHECK:STDOUT:   %F.call: init () = call %.1()
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F();
// CHECK:STDOUT:
