.section .rodata
.global hello
hello:
  .string "Hello, world!"

.global here
here:
  .string "here"

.text
.global main

main:
  xor %ecx,%ecx
  jmp _start

.global l
l:
  mov $here, %edi
  mov %ecx, %edi
  call puts
  dec %ecx
  cmp %ecx, 10
  jle l


_start:
  push %rbp
  mov %rsp, %rbp
  mov $hello, %edi
  call puts

  mov $0, %eax

  jmp l

  leave
  ret
