// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// This file was generated from unary_stmt.carbon.tmpl. Run make_tests.sh to regenerate.

// --- prelude.carbon

package Core api;

interface Inc {
  fn Op[addr self: Self*]();
}

// --- user.carbon

package User api;

import Core;

class C {};

impl C as Core.Inc {
  fn Op[addr self: C*]();
}

fn TestOp() {
  var c: C = {};
  ++c;
}

// CHECK:STDOUT: --- prelude.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = interface_type @Inc [template]
// CHECK:STDOUT:   %Self: Inc = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.2: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %.3: type = assoc_entity_type @Inc, <function> [template]
// CHECK:STDOUT:   %.4: <associated <function> in Inc> = assoc_entity element0, @Inc.%Op [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Inc = %Inc.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Inc.decl: type = interface_decl @Inc [template = constants.%.1] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Inc {
// CHECK:STDOUT:   %Self: Inc = bind_symbolic_name Self 0 [symbolic = constants.%Self]
// CHECK:STDOUT:   %Op: <function> = fn_decl @Op [template] {
// CHECK:STDOUT:     %Self.ref: Inc = name_ref Self, %Self [symbolic = constants.%Self]
// CHECK:STDOUT:     %.loc5_24.1: type = facet_type_access %Self.ref [symbolic = constants.%Self]
// CHECK:STDOUT:     %.loc5_24.2: type = converted %Self.ref, %.loc5_24.1 [symbolic = constants.%Self]
// CHECK:STDOUT:     %.loc5_24.3: type = ptr_type Self [symbolic = constants.%.2]
// CHECK:STDOUT:     %self.loc5_14.1: Self* = param self
// CHECK:STDOUT:     %self.loc5_14.3: Self* = bind_name self, %self.loc5_14.1
// CHECK:STDOUT:     %.loc5_9: Self* = addr_pattern %self.loc5_14.3
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc5_28: <associated <function> in Inc> = assoc_entity element0, %Op [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   .Op = %.loc5_28
// CHECK:STDOUT:   witness = (%Op)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op[addr @Inc.%self.loc5_14.3: Self*]();
// CHECK:STDOUT:
// CHECK:STDOUT: --- user.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = interface_type @Inc [template]
// CHECK:STDOUT:   %Self: Inc = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.3: type = ptr_type C [template]
// CHECK:STDOUT:   %.4: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %.5: <witness> = interface_witness (@impl.%Op) [template]
// CHECK:STDOUT:   %.6: type = tuple_type () [template]
// CHECK:STDOUT:   %.7: type = ptr_type {} [template]
// CHECK:STDOUT:   %.8: C = struct_value () [template]
// CHECK:STDOUT:   %.9: type = assoc_entity_type @Inc, <function> [template]
// CHECK:STDOUT:   %.10: <associated <function> in Inc> = assoc_entity element0, file.%import_ref.6 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .TestOp = %TestOp
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir2, inst+1, loc_18 [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.2: <associated <function> in Inc> = import_ref ir2, inst+15, loc_47 [template = constants.%.10]
// CHECK:STDOUT:   %import_ref.3 = import_ref ir2, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.4: <function> = import_ref ir2, inst+13, loc_19 [template = imports.%Op]
// CHECK:STDOUT:   impl_decl @impl {
// CHECK:STDOUT:     %C.ref: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %Inc.decl: type = interface_decl @Inc [template = constants.%.2] {}
// CHECK:STDOUT:     %Inc.ref: type = name_ref Inc, %import_ref.1 [template = constants.%.2]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %TestOp: <function> = fn_decl @TestOp [template] {}
// CHECK:STDOUT:   %import_ref.5: type = import_ref ir2, inst+1, loc_47 [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.6 = import_ref ir2, inst+13, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Inc {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = file.%import_ref.2
// CHECK:STDOUT:   .Self = file.%import_ref.3
// CHECK:STDOUT:   witness = (file.%import_ref.4)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl: C as Inc {
// CHECK:STDOUT:   %Op: <function> = fn_decl @Op.1 [template] {
// CHECK:STDOUT:     %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc9_21: type = ptr_type C [template = constants.%.3]
// CHECK:STDOUT:     %self.loc9_14.1: C* = param self
// CHECK:STDOUT:     %self.loc9_14.3: C* = bind_name self, %self.loc9_14.1
// CHECK:STDOUT:     %.loc9_9: C* = addr_pattern %self.loc9_14.3
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op) [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = %Op
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.1[addr @impl.%self.loc9_14.3: C*]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.2[addr %self: Self*]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestOp() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:   %c.var: ref C = var c
// CHECK:STDOUT:   %c: ref C = bind_name c, %c.var
// CHECK:STDOUT:   %.loc13_15.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc13_15.2: init C = class_init (), %c.var [template = constants.%.8]
// CHECK:STDOUT:   %.loc13_16: init C = converted %.loc13_15.1, %.loc13_15.2 [template = constants.%.8]
// CHECK:STDOUT:   assign %c.var, %.loc13_16
// CHECK:STDOUT:   %c.ref: ref C = name_ref c, %c
// CHECK:STDOUT:   %.1: <function> = interface_witness_access @impl.%.1, element0 [template = @impl.%Op]
// CHECK:STDOUT:   %.loc14_3.1: <bound method> = bound_method %c.ref, %.1
// CHECK:STDOUT:   %.loc14_5: C* = addr_of %c.ref
// CHECK:STDOUT:   %.loc14_3.2: init () = call %.loc14_3.1(%.loc14_5)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
