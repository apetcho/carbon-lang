// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// ============================================================================
// Setup files
// ============================================================================

// --- other_define.carbon

package Other library "define" api;

class C {}

// --- other_extern.carbon

package Other library "extern" api;

extern class C;

// --- other_conflict.carbon

package Other library "conflict" api;

fn C() {}

// ============================================================================
// Test files
// ============================================================================

// --- define.carbon

library "define" api;

import Other library "define";

var c: Other.C = {};

// --- fail_extern.carbon

library "extern" api;

import Other library "extern";

// CHECK:STDERR: fail_extern.carbon:[[@LINE+10]]:8: ERROR: Variable has incomplete type `C`.
// CHECK:STDERR: var c: Other.C = {};
// CHECK:STDERR:        ^~~~~~~
// CHECK:STDERR: fail_extern.carbon:[[@LINE-5]]:1: In import.
// CHECK:STDERR: import Other library "extern";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: other_extern.carbon:4:1: Class was forward declared here.
// CHECK:STDERR: extern class C;
// CHECK:STDERR: ^~~~~~~~~~~~~~~
// CHECK:STDERR:
var c: Other.C = {};

// --- fail_todo_merge_define_extern.carbon

library "merge_define_extern" api;

import Other library "define";
// CHECK:STDERR: fail_todo_merge_define_extern.carbon:[[@LINE+12]]:1: In import.
// CHECK:STDERR: import Other library "extern";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: other_extern.carbon:4:1: ERROR: Only one library can declare `class C` without `extern`.
// CHECK:STDERR: extern class C;
// CHECK:STDERR: ^~~~~~~~~~~~~~~
// CHECK:STDERR: fail_todo_merge_define_extern.carbon:[[@LINE-7]]:1: In import.
// CHECK:STDERR: import Other library "define";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: other_define.carbon:4:1: Previously declared here.
// CHECK:STDERR: class C {}
// CHECK:STDERR: ^~~~~~~~~
import Other library "extern";

// CHECK:STDERR: fail_todo_merge_define_extern.carbon:[[@LINE+4]]:8: In name lookup for `C`.
// CHECK:STDERR: var c: Other.C = {};
// CHECK:STDERR:        ^~~~~~~
// CHECK:STDERR:
var c: Other.C = {};

// --- fail_conflict.carbon

library "conflict" api;

import Other library "define";
// CHECK:STDERR: fail_conflict.carbon:[[@LINE+12]]:1: In import.
// CHECK:STDERR: import Other library "conflict";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: other_conflict.carbon:4:1: ERROR: Duplicate name being declared in the same scope.
// CHECK:STDERR: fn C() {}
// CHECK:STDERR: ^~~~~~~~
// CHECK:STDERR: fail_conflict.carbon:[[@LINE-7]]:1: In import.
// CHECK:STDERR: import Other library "define";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: other_define.carbon:4:1: Name is previously declared here.
// CHECK:STDERR: class C {}
// CHECK:STDERR: ^~~~~~~~~
import Other library "conflict";

// CHECK:STDERR: fail_conflict.carbon:[[@LINE+3]]:8: In name lookup for `C`.
// CHECK:STDERR: var c: Other.C = {};
// CHECK:STDERR:        ^~~~~~~
var c: Other.C = {};

// CHECK:STDOUT: --- other_define.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- other_extern.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C;
// CHECK:STDOUT:
// CHECK:STDOUT: --- other_conflict.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C: <function> = fn_decl @C [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @C() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- define.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %.3: type = ptr_type {} [template]
// CHECK:STDOUT:   %.4: C = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Other = %Other
// CHECK:STDOUT:     .c = %c
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other.ref: <namespace> = name_ref Other, %Other [template = %Other]
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir2, inst+2, loc_14 [template = constants.%C]
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.2 = import_ref ir2, inst+3, unloaded
// CHECK:STDOUT:   %C.ref: type = name_ref C, %import_ref.1 [template = constants.%C]
// CHECK:STDOUT:   %c.var: ref C = var c
// CHECK:STDOUT:   %c: ref C = bind_name c, %c.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc6_19.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc6_19.2: init C = class_init (), file.%c.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc6_20: init C = converted %.loc6_19.1, %.loc6_19.2 [template = constants.%.4]
// CHECK:STDOUT:   assign file.%c.var, %.loc6_20
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_extern.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Other = %Other
// CHECK:STDOUT:     .c = %c
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other.ref: <namespace> = name_ref Other, %Other [template = %Other]
// CHECK:STDOUT:   %import_ref: type = import_ref ir2, inst+2, loc_14 [template = constants.%C]
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %C.ref: type = name_ref C, %import_ref [template = constants.%C]
// CHECK:STDOUT:   %c.var: ref <error> = var c
// CHECK:STDOUT:   %c: ref <error> = bind_name c, %c.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc16: {} = struct_literal ()
// CHECK:STDOUT:   assign file.%c.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_todo_merge_define_extern.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C.1: type = class_type @C.1 [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %C.2: type = class_type @C.2 [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %.3: type = ptr_type {} [template]
// CHECK:STDOUT:   %.4: C = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Other = %Other
// CHECK:STDOUT:     .c = %c
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other.ref: <namespace> = name_ref Other, %Other [template = %Other]
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir2, inst+2, loc_19 [template = constants.%C.1]
// CHECK:STDOUT:   %C.decl.1: type = class_decl @C.1 [template = constants.%C.1] {}
// CHECK:STDOUT:   %import_ref.2 = import_ref ir2, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.3: type = import_ref ir3, inst+2, loaded [template = constants.%C.2]
// CHECK:STDOUT:   %C.decl.2: type = class_decl @C.2 [template = constants.%C.2] {}
// CHECK:STDOUT:   %C.ref: type = name_ref C, %import_ref.1 [template = constants.%C.1]
// CHECK:STDOUT:   %c.var: ref C = var c
// CHECK:STDOUT:   %c: ref C = bind_name c, %c.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C.1 {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C.2;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc23_19.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc23_19.2: init C = class_init (), file.%c.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc23_20: init C = converted %.loc23_19.1, %.loc23_19.2 [template = constants.%.4]
// CHECK:STDOUT:   assign file.%c.var, %.loc23_20
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_conflict.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C.2 [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %.3: type = ptr_type {} [template]
// CHECK:STDOUT:   %.4: C = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Other = %Other
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .c = %c
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Other: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Other.ref: <namespace> = name_ref Other, %Other [template = %Other]
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir1, inst+2, loc_19 [template = constants.%C]
// CHECK:STDOUT:   %C.decl: type = class_decl @C.2 [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.2 = import_ref ir1, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.3: <function> = import_ref ir2, inst+2, loaded [template = imports.%C]
// CHECK:STDOUT:   %C.ref: type = name_ref C, %import_ref.1 [template = constants.%C]
// CHECK:STDOUT:   %c.var: ref C = var c
// CHECK:STDOUT:   %c: ref C = bind_name c, %c.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C.2 {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @C.1();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc22_19.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc22_19.2: init C = class_init (), file.%c.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc22_20: init C = converted %.loc22_19.1, %.loc22_19.2 [template = constants.%.4]
// CHECK:STDOUT:   assign file.%c.var, %.loc22_20
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
