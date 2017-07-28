# NAME

Catmandu::Importer::PDF - Catmandu importer to extract data from one pdf

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-Importer-PDF/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-Importer-PDF)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF.png)](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF)

# SYNOPSIS

    #From the command line

    #Export pdf information, and text

    $ catmandu convert PDF --file input.pdf to YAML

    #In a script

    use Catmandu::Sane;

    use Catmandu::Importer::PDF;

    my $importer = Catmandu::Importer::PDF->new( file => "/tmp/input.pdf" );

    $importer->each(sub{

        my $pdf = $_[0];
        #..

    });

# EXAMPLE OUTPUT IN YAML

    document:
      author: ~
      creation_date: 1207274644
      creator: PDFplus
      keywords: ~
      metadata: ~
      modification_date: 1421574847
      producer: "Nobody at all"
      subject: ~
      title: "Hello there"
      version: PDF-1.6
    pages:
    - label: Cover Page
      height: 878
      width: 595
      text: "Hello world"

# INSTALLATION

In order to install this package you need the following system packages installed

- Centos

    Requires Centos 7 at minimum. Centos 6 only has poppler-glib 0.12.

    \* perl-devel

    \* make

    \* gcc

    \* gcc-c++

    \* libyaml-devel

    \* libyaml

    \* poppler-glib ( >= 0.16 )

    \* poppler-glib-devel ( >= 0.16 )

    \* gobject-introspection-devel

- Ubuntu

    Requires Ubuntu 14 at minimum.

    \* libpoppler-glib8

    \* libpoppler-glib-dev

    \* gobject-introspection

    \* libgirepository1.0-dev

# NOTES

\* [Catmandu::Importer::PDF](https://metacpan.org/pod/Catmandu::Importer::PDF) returns one record, containing both document information, and page text

\* [Catmandu::Importer::PDFPages](https://metacpan.org/pod/Catmandu::Importer::PDFPages) returns multiple records, each for each page

\* [Catmandu::Importer::PDFInfo](https://metacpan.org/pod/Catmandu::Importer::PDFInfo) returns one record, containing document information

# KNOWN ISSUES

\* Due to a bug in older versions of poppler-glib (bug #94173), the creation\_date and modification\_date can be returned in local time, instead of utc. This module tries to fix that.

\* Some versions of Poppler add form feeds and newlines to a text line, while others don't.

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# SEE ALSO

[Catmandu::Importer::PDFInfo](https://metacpan.org/pod/Catmandu::Importer::PDFInfo), [Catmandu::Importer::PDFPages](https://metacpan.org/pod/Catmandu::Importer::PDFPages), [Catmandu](https://metacpan.org/pod/Catmandu), [Catmandu::Importer](https://metacpan.org/pod/Catmandu::Importer) , [Poppler](https://metacpan.org/pod/Poppler)
