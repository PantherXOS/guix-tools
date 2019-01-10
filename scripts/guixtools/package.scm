(define-module (guixtools package)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix licenses)
  #:use-module (json)
  #:export (all-packages
            package-as-json
            all-packages-as-json))

(define %package-list
  (delay
    ;; Note: Dismiss packages found in $GUIX_PACKAGE_PATH.
    (let ((packages
           (sort (parameterize ((%package-module-path (last-pair
                                                       (%package-module-path))))
                   (fold-packages (lambda (package lst)
                                    (if (package-superseded package)
                                        lst
                                        (cons (or (package-replacement package)
                                                  package)
                                              lst)))
                                  '()))
                 (lambda (p1 p2)
                   (string<? (package-name p1)
                             (package-name p2))))))
      (cond ((null? packages) '())
            ((getenv "GUIX_WEB_SITE_LOCAL") (list-head packages 300))
            (else packages)))))

(define (all-packages)
  "Return the list of all Guix package objects, sorted by name.

   If GUIX_WEB_SITE_LOCAL=yes, return only 300 packages for
   testing the website."
  (force %package-list))


(define extract-dependency-names (lambda (deps extracted_deps)
              (define dep_list '())
              (for-each 
                     (lambda (d)
                            (define pkg (car (cdr d)))
                            (if (and (package? pkg) (not (member (package-full-name pkg) extracted_deps)))
                                   (set! dep_list (append dep_list (list (package-full-name pkg))))))
                     deps)
              dep_list))

(define package-dependencies (lambda (pkg)
              (define all_deps '())
              (set! all_deps (append all_deps (extract-dependency-names (package-inputs pkg) all_deps)))
              (set! all_deps (append all_deps (extract-dependency-names (package-native-inputs pkg) all_deps)))
              (set! all_deps (append all_deps (extract-dependency-names (package-propagated-inputs pkg) all_deps)))
              all_deps))

(define extract-license-names (lambda (pkg)
                     (define result '())
                     (for-each 
                            (lambda (lic)
                                   (set! result (append result (list (license-name lic)))))
                            (if (list? (package-license pkg))
                                   (package-license pkg)
                                   (list (package-license pkg))))
                     result))


(define make-package-object (lambda (pkg)
              (define jdata (make-hash-table))
              (define dependencies '())
              (define licenses '())

              (hash-set! jdata 'name (package-name pkg))
              (hash-set! jdata 'version (package-version pkg))
              (hash-set! jdata 'outputs (string-join (package-outputs pkg) " "))
              (hash-set! jdata 'systems (string-join (package-supported-systems pkg) " "))
              (hash-set! jdata 'dependencies (string-join (package-dependencies pkg) " "))
              (hash-set! jdata 'location (format #f "location: ~a:~a:~a" 
                                                        (location-file (package-location pkg))
                                                        (location-line (package-location pkg))
                                                        (location-column (package-location pkg))))
              (hash-set! jdata 'homepage (package-home-page pkg))
              (hash-set! jdata 'license (string-join (extract-license-names pkg) ", "))
              (hash-set! jdata 'synopsis (package-synopsis pkg))
              (hash-set! jdata 'description (package-description pkg))

              jdata))


(define package-as-json (lambda (pkg)
                     (scm->json-string (make-package-object pkg) #:pretty #t)))


(define all-packages-as-json (lambda () 
       (define result '())
       (for-each 
              (lambda (pkg) 
                     (set! result (append result (list (make-package-object pkg)))))
              (all-packages))
       (scm->json-string result #:pretty #t)))
