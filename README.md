# simple-arrows

More established libraries:

- [arrows](https://github.com/Harleqin/arrows) - lightweight, but I wanted nesting (see examples below)
- [arrow-macros](https://github.com/hipeta/arrow-macros) - heavy; I don't understand the need for a full code-walker: can't we just do with `simple-arrows::find-symbol-in-tree`?

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

