(use-modules (pxutils)
        (guix packages)
        (json))

; (for-each (lambda (pkg) 
;                 (if (string=? (package-name pkg) "git")
;                         (display (package-as-json pkg)))

;                 ; (define jsn (package-as-json pkg))
;                 ; (if (string=? (package-name pkg) "git")
;                 ;         (display jsn))
;         )
;         (all-packages))

; (newline)

(display (all-packages-as-json))

(newline)