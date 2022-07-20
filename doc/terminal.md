# Terminal

General terminal commands.

## Job control

* `CTRL-z` -- suspend current terminal foreground job
* `bg` -- send CONT signal to most recent terminal job, usually resuming it in the background
* `fg` -- resume the most recent terminal job
* `jobs` -- list terminal processes
* `fg %X` -- foreground terminal job `X` where `X` is the job number from `jobs`
* `bg %X` -- resume background job `X` where `X` is the job number from `jobs`
