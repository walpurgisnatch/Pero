# Pero
Logging library

## Usage
Configure templates 
```
(pero:logger-setup "~/log-dir" '("folder/filename" (template-name1 "~a some stuff ~a") (template-name2 "second ~a")) 
                               '("filename" (template-name3 "simple-log")))
```
Then call 
```
(pero:write-log 'template-name1 "firs arg" "second arg")
```

## Installation
Clone repo
```
$ git clone https://github.com/walpurgisnatch/pero.git
```
Then load pero with quicklisp
```
(ql:quickload pero)
```

### With roswell
```
$ ros install walpurgisnatch/pero
```

## License

Licensed under the MIT License.

## Copyright

Copyright (c) 2021 Walpurgisnatch
