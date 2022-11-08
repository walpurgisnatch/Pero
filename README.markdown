# Pero
Logging and text file operations library

## Usage

### Will be updated in near future

Configure templates 
```
(pero:logger-setup "~/log-dir")
(pero:create-template "file" '(:error "there was an error - ~a")
                             '(:simple "~a happened"))
```
Then call 
```
(pero:write-log :error "something went wrong")
```

## Installation

### Quicklisp
```
(ql:quickload :pero)
```

## License

Licensed under the MIT License.
