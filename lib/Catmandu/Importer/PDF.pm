package Catmandu::Importer::PDF;

use Catmandu::Sane;
use Poppler;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

sub _createDocFromFilename {
    my $filename = $_[0];

    my $pdf = Poppler::Document->new_from_file( $filename );

    my $num_pages = $pdf->get_n_pages();

    my $record = {
        document => {
            version => $pdf->get_pdf_version_string(),
            title => $pdf->get_title(),
            author => $pdf->get_author(),
            subject => $pdf->get_subject(),
            keywords => $pdf->get_keywords(),
            creator => $pdf->get_creator(),
            producer => $pdf->get_producer(),
            creation_date => $pdf->get_creation_date(),
            modification_date => $pdf->get_modification_date(),
            metadata => $pdf->get_metadata()
        },
        pages => []
    };

    for(my $i = 0;$i < $num_pages;$i++){
        my $page = $pdf->get_page($i);
        my $text = $page->get_text();
        my($w,$h) = $page->get_size;
        my $label = $page->get_label();

        my $p = {
            width => $w,
            height => $h,
            label => $label,
            text => $text
        };

        push @{ $record->{pages} },$p;
    }

    $record;
}

sub generator {
    my ($self) = @_;

    return sub {
        state $doc = undef;

        unless($doc){
            $doc = _createDocFromFilename( $self->file );
            return $doc;
        }
        return;

    }
}
sub DESTROY {
    my ($self) = @_;
    close($self->fh);
}
=head1 NAME

Catmandu::Importer::PDF - Catmandu importer to extract data from one pdf

=head1 SYNOPSIS

# From the command line

# Export pdf information, and text

$ catmandu convert PDF --file input.pdf to YAML

#In a script

use Catmandu::Sane;

use Catmandu::Importer::PDF;

my $importer = Catmandu::Importer::PDF->new( file => "/tmp/input.pdf" );

$importer->each(sub{

    my $pdf = $_[0];
    #..

});

=head1 EXAMPLE OUTPUT IN YAML

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
