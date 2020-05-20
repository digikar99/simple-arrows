# simple-arrows

>This library is rendered redundant using the following cases:
>
>```lisp
>;;; Fails on:
>(-<> 5
>  (+ 6 <>
>     (eval (macroexpand `(-<> 10
>                           (+ 2 <> ,<>))))))
>;;; Alternative using arrows:
>(as-> 5 a
>      (+ 6 a
>         (eval (macroexpand `(as-> 10 a
>                                   (+ 2 a ,a))))))
>;=> 28
>```

## Original README

More established libraries:

- [arrows](https://github.com/Harleqin/arrows) - lightweight, but I wanted nesting (see examples below)
- [arrow-macros](https://github.com/hipeta/arrow-macros) - heavy; I don't understand the need for a full code-walker: can't we just do with `simple-arrows::replace-symbol-in-tree`?

## Examples

Exported symbols: `-> -<>`

```lisp
CL-USER> (-> 3 (/))
1/3
CL-USER> (let ((a 3))
           (-> a (incf) (1+)))
5
CL-USER> (let ((a 5))
           (-<> a
             (incf <>)
             (+ <> <> (-<> 5 (+ <> <>)))))
22
```

