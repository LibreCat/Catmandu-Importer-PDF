package Catmandu::Importer::PDFPages;

use Catmandu::Sane;
use Poppler;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

sub generator {
    my $self = $_[0];

    return sub {
        state $pdf;
        state $page_index;
        state $num_pages;

        unless($pdf){
            $pdf = Poppler::Document->new_from_file( $self->file );
            $num_pages = $pdf->get_n_pages();
            $page_index = 0;
        }

        if($page_index < $num_pages){

            my $page = $pdf->get_page($page_index);
            my $text = $page->get_text();
            my($w,$h) = $page->get_size;
            my $label = $page->get_label();

            my $p = {
                width => $w,
                height => $h,
                label => $label,
                text => $text
            };
            $page_index++;

            return $p;

        }

        return;

    }
}
sub DESTROY {
    my ($self) = @_;
    close($self->fh);
}

=encoding utf8

=head1 NAME

Catmandu::Importer::PDFPages - Catmandu importer to extract text data per page from one pdf

=begin markdown

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-Importer-PDF)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-Importer-PDF/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-Importer-PDF)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF.png)](http://cpants.cpanauthors.org/dist/Catmandu-Importer-PDF)

=end markdown

=head1 SYNOPSIS

# From the command line

# Export pdf pages with their text and coördinates

$ catmandu convert PDFPages --file input.pdf to YAML

#In a script

use Catmandu::Sane;

use Catmandu::Importer::PDFPages;

my $importer = Catmandu::Importer::PDFPages->new( file => "/tmp/input.pdf" );

$importer->each(sub{

    my $page = $_[0];
    #..

});

=head1 EXAMPLE OUTPUT IN YAML

=begin text

    - label: Cover Page
      height: 878
      width: 595
      text: "Hello world"

=end text

=head1 INSTALL

In order to install this package you need the following system packages installed

=over

=item Centos

* perl-devel

* make

* gcc

* gcc-c++

* libyaml-devel

* libyaml

* poppler-glib ( >= 0.16 )

* poppler-glib-devel ( >= 0.16 )

Centos 6 only has poppler-glib 0.12. So you need at least Centos 7.
Or you can compile the package.

=item Ubuntu

* libpoppler-glib8

* libpoppler-glib-dev

* gobject-introspection

* libgirepository1.0-dev

=back

=head1 NOTES

* returns only one record, compared to other Catmandu importers

* all pages are stored in one record. For large documents this can be memory intensive.

=head1 AUTHORS

Nicolas Franck C<< <nicolas.franck at ugent.be> >>

=head1 SEE ALSO

L<Catmandu>, L<Catmandu::Importer> , L<Poppler>

=cut

1;
