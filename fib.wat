;; INFO asc module.ts --textFile module.wat --binaryFile module.wasm -O3 --runtime half
(module
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (memory $0 0)
 (export "memory" (memory $0))
 (export "fib" (func $module/fib))
 (func $module/fib (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 1
  local.set $1
  local.get $0
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|0
    local.get $0
    i32.const 1
    i32.sub
    local.tee $0
    if
     local.get $1
     local.get $2
     i32.add
     local.get $1
     local.set $2
     local.set $1
     br $while-continue|0
    end
   end
   local.get $1
   return
  end
  i32.const 0
 )
)

