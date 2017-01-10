# NAME

Catmandu::Importer::PDF - Catmandu importer to extract data from one pdf

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-Importer-PDF/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-Importer-PDF)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF.png)](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF)

# SYNOPSIS

\# From the command line

\# Export pdf information, and text

$ catmandu convert PDF --file input.pdf to YAML

\#In a script

use Catmandu::Sane;

use Catmandu::Importer::PDF;

my $importer = Catmandu::Importer::PDF->new( file => "/tmp/input.pdf" );

$importer->each(sub{

    my $pdf = $_[0];
    #..

});

# EXAMPLE OUTPUT IN YAML

# INSTALL

In order to install this package you need the following system packages installed

- Centos

    \* perl-devel

    \* make

    \* gcc

    \* gcc-c++

    \* libyaml-devel

    \* libyaml

    \* poppler-glib ( >= 0.16 )

    \* poppler-glib-devel ( >= 0.16 )

    Centos 6 only has poppler-glib 0.12. So you need at least Centos 7.
    Or you can compile the package.

- Ubuntu

    \* libpoppler-glib8

    \* libpoppler-glib-dev

    \* gobject-introspection

    \* libgirepository1.0-dev

# NOTES

\* returns only one record, compared to other Catmandu importers

\* all pages are stored in one record. For large documents this can be memory intensive.

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# SEE ALSO

[Catmandu::Importer::PDFInfo](https://metacpan.org/pod/Catmandu::Importer::PDFInfo), [Catmandu::Importer::PDFPages](https://metacpan.org/pod/Catmandu::Importer::PDFPages), [Catmandu](https://metacpan.org/pod/Catmandu), [Catmandu::Importer](https://metacpan.org/pod/Catmandu::Importer) , [Poppler](https://metacpan.org/pod/Poppler)
