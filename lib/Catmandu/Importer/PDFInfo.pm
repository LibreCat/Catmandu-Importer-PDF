package Catmandu::Importer::PDFInfo;

use Catmandu::Sane;
use Poppler;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

sub _createDocFromFilename {
    my $filename = $_[0];

    my $pdf = Poppler::Document->new_from_file( $filename );

    +{
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
    };
}

sub generator {
    my ($self) = @_;

    return sub {
        state $doc;

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

=encoding utf8

=head1 NAME

Catmandu::Importer::PDFInfo - Catmandu importer to extract metadata from one pdf

=head1 SYNOPSIS

    # From the command line

    # Export pdf information

    $ catmandu convert PDFInfo --file input.pdf to YAML

    #In a script

    use Catmandu::Sane;

    use Catmandu::Importer::PDFInfo;

    my $importer = Catmandu::Importer::PDFInfo->new( file => "/tmp/input.pdf" );

    $importer->each(sub{

        my $pdf = $_[0];
        #..

    });

=head1 EXAMPLE OUTPUT IN YAML

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

=head1 AUTHORS

Nicolas Franck C<< <nicolas.franck at ugent.be> >>

=head1 SEE ALSO

L<Catmandu>, L<Catmandu::Importer> , L<Poppler>

=cut

1;
