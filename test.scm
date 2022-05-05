(define-module (test)
    #:use-module (gnu packages guile)
    #:use-module (gnu packages pkg-config)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (guix build-system cmake)
    #:use-module (guix utils)
    #:use-module (guix gexp))

(package
    (name "guix-tools")
    (version "0.1.10")
    (source (local-file "." "guix-tools" #:recursive? #t))
    (build-system cmake-build-system)
    (arguments
        `(#:tests? #f))
    (inputs `(
        ("guile-json", guile-json-1)
        ("guile", guile-3.0)))
    (native-inputs `(
        ("pkg-config", pkg-config)))
    (home-page "https://PantherX.org")
    (synopsis "PantherX guix tools to automate guix related tasks")
    (description "Automate `guix` package manager tasks using scheme scripts.
        this tool is developed for PantherX team internal usage.")
    (license license:expat))
