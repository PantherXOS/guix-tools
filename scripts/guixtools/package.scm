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


(define extract-dependency-names
  (lambda (deps extracted_deps)
    (define dep_list '())
    (for-each
     (lambda (d)
       (define pkg (car (cdr d)))
       (if (and (package? pkg) (not (member (package-full-name pkg) extracted_deps)))
           (set! dep_list (append dep_list (list (package-full-name pkg))))))
     deps)
    dep_list))

(define package-dependencies
  (lambda (pkg)
    (define all_deps '())
    (set! all_deps (append all_deps (extract-dependency-names (package-inputs pkg) all_deps)))
    (set! all_deps (append all_deps (extract-dependency-names (package-native-inputs pkg) all_deps)))
    (set! all_deps (append all_deps (extract-dependency-names (package-propagated-inputs pkg) all_deps)))
    all_deps))


(define (extract-license-names pkg)
  (with-exception-handler
      (lambda (exp)
	(format (current-error-port) "Exception Caught: ~s\n" exp)
	'())
    (lambda ()
      (let ((licenses (package-license pkg)))
    (map (lambda (lic)
	   (license-name lic))
	 (if (list? licenses)
	     licenses
	     (list licenses)))))
    #:unwind? #t))


(define (extract-package pkg)
  `(("name" . ,(package-name pkg))
    ("version" . ,(package-version pkg))
    ("outputs" . ,(list->vector (package-outputs pkg)))
    ("systems" . ,(list->vector (package-supported-systems pkg)))
    ("dependencies" . ,(list->vector (package-dependencies pkg)))
    ("location" . ,(format #f "~a:~a:~a"
			   (location-file (package-location pkg))
			   (location-line (package-location pkg))
			   (location-column (package-location pkg))))
    ("home-page" . ,(package-home-page pkg))
    ("license" . ,(list->vector (extract-license-names pkg)))
    ("synopsis" . ,(package-synopsis pkg))
    ("description" . ,(package-description pkg))))


(define* (package-as-json pkg #:key (pretty? #t))
  (scm->json-string (extract-package pkg)
		    #:pretty pretty?
		    #:unicode #t))


(define* (all-packages-as-json #:key (pretty? #t))
  (scm->json-string
   (list->vector
    (map (lambda (pkg)
	   (extract-package pkg))
	 (all-packages)))
   #:pretty pretty?
   #:unicode #t))
