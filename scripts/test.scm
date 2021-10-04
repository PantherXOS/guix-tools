(add-to-load-path (dirname (current-filename)))

(use-modules (guixtools package)
        (guix packages)
        (json))


(display (all-packages-as-json #:pretty? #t))

(newline)
